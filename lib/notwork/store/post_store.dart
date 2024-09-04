import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dummy_api_call_retrofit/notwork/repository/post_repo_implement.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../model/response/photos_response.dart';

part 'post_store.g.dart';

class PostStore = PostStoreBase with _$PostStore;

abstract class PostStoreBase with Store {
  @observable
  ObservableList<PhotosResponse> photosList = ObservableList();

  @observable
  String? errorMessage;

  @action
  Future getPhotosList(int start, int limit) async {
    try {
      var res = await postRepositoryImpl.getPhotos(start, limit);
      photosList.addAll(res);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          (e.error is SocketException || e.error is HandshakeException)) {
        errorMessage = "No internet connection";
      } else {
        errorMessage = e.toString();
      }
    } catch (error, st) {
      errorMessage = error.toString();
      debugPrintStack(stackTrace: st);
    }
  }
}

//final postStore = locator<PostStore>();
