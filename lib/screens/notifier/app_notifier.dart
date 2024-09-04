import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/response/photos_response.dart';
import '../../notwork/repository/post_repo_implement.dart';

class AppNotifier extends ChangeNotifier {
  List<PhotosResponse> allPostList = <PhotosResponse>[];
  String? errorMessage;

  bool? isLoading;
  Future getAppPost() async {
    try {
      isLoading = true;
      notifyListeners();
      var res = await postRepositoryImpl.getAllPhotos();
      allPostList.addAll(res);
      isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          (e.error is SocketException || e.error is HandshakeException)) {
        errorMessage = "No internet connection" as String?;
      } else {
        errorMessage = e.toString() as String?;
      }
    } catch (error, st) {
      errorMessage = error.toString() as String?;
      debugPrintStack(stackTrace: st);
    }
  }

  List<PhotosResponse> postList = <PhotosResponse>[];
  Future getPhotosList(int start, int limit) async {
    try {
      if (start == 1) {
        postList.clear();
      }
      isLoading = true;
      notifyListeners();
      var res = await postRepositoryImpl.getPhotos(start, limit);
      postList.addAll(res);
      isLoading = false;
      notifyListeners();
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

  int _page = 1;
  Future loadMorePhotos() async {
    isLoading = true;
    notifyListeners();
    await getPhotosList(_page, 10);
    _page = _page + 10;
    isLoading = false;
    notifyListeners();
  }
}
