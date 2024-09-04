import 'package:dummy_api_call_retrofit/screens/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../notwork/getx_controller/app_controller.dart';

class AllPostListPage extends StatefulWidget {
  const AllPostListPage({super.key});

  @override
  State<AllPostListPage> createState() => _AllPostListPageState();
}

class _AllPostListPageState extends State<AllPostListPage> {
  //ValueNotifier<bool> isLoading2 = ValueNotifier(false);

  final ScrollController _scrollController = ScrollController();
  //var isLoading = false.obs;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  int _page = 1;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _callApi();
    super.initState();
  }

  _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading.value) {
        isLoading.value = true;
        _page = _page + 10;
        await appController.getPhotosList(_page, 10);
        isLoading.value = false;
      }
    }
  }

  _callApi() async {
    isLoading.value = true;
    await appController.getPhotosList(_page, 10);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).allPosts),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _observeResponse(),
            ),
          )
        ],
      ),
    );
  }

  Widget _observeResponse() {
    return Obx(() {
      debugPrint("OBX_OBX  CALL  E");
      if (appController.postList.isEmpty) {
        return const Text("No Data found");
      } else {
        return ListView.builder(
          itemCount: appController.postList.length + 1,
          shrinkWrap: true,
          controller: _scrollController,
          itemBuilder: (context, index) {
            debugPrint(
                "OBX_OBX  CONTROLLER LEN :${appController.postList.length}");
            if (index < appController.postList.length) {
              return ImageCard(
                imageUrl: appController.postList[index].url ?? "null",
                description: appController.postList[index].title ?? "null",
              );
            } else {
              return _buildProgressIndicator();
            }
          },
        );
      }
    });
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
