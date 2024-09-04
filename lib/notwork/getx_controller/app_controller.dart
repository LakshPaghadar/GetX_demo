import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dummy_api_call_retrofit/locator/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/response/photos_response.dart';
import '../repository/post_repo_implement.dart';

class AppController extends GetxController {
  RxString str = "test".obs;
  RxList<PhotosResponse> postList = <PhotosResponse>[].obs;

  RxList<PhotosResponse> allPostList = <PhotosResponse>[].obs;

  RxString? errorMessage;

  Future getPhotosList(int start, int limit) async {
    try {
      if (start == 1) {
        postList.value.clear();
      }
      var res = await postRepositoryImpl.getPhotos(start, limit);
      postList.addAll(res);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          (e.error is SocketException || e.error is HandshakeException)) {
        errorMessage = "No internet connection" as RxString?;
      } else {
        errorMessage = e.toString().obs as RxString?;
      }
    } catch (error, st) {
      errorMessage = error.toString().obs as RxString?;
      debugPrintStack(stackTrace: st);
    }
  }

  Future getAllPost() async {
    try {
      debugPrint("DEMO_GETX : dalay ");
      await Future.delayed(const Duration(seconds: 5));
      debugPrint("DEMO_GETX : api calling ");
      var res = await postRepositoryImpl.getAllPhotos();
      debugPrint("DEMO_GETX : api called ");
      allPostList.addAll(res);
      debugPrint("DEMO_GETX : response got ");
    } on DioException catch (e) {
      debugPrint("DEMO_GETX : error ");
      if (e.type == DioExceptionType.unknown &&
          (e.error is SocketException || e.error is HandshakeException)) {
        errorMessage = "No internet connection" as RxString?;
      } else {
        errorMessage = e.toString().obs as RxString?;
      }
    } catch (error, st) {
      debugPrint("DEMO_GETX : error 2");
      errorMessage = error.toString().obs as RxString?;
      debugPrintStack(stackTrace: st);
    }
  }
}

var appController = locator.get<AppController>();
