import 'package:dummy_api_call_retrofit/main.dart';
import 'package:dummy_api_call_retrofit/screens/all_post_list_page.dart';
import 'package:dummy_api_call_retrofit/screens/provider_demo/all_post_with_provider.dart';
import 'package:dummy_api_call_retrofit/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../generated/l10n.dart';
import '../notwork/getx_controller/app_controller.dart';
import 'custom_animation_demo.dart';
import 'widgets/image_card.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isLoading2 = ValueNotifier(false);
  List<ReactionDisposer>? disposer;
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  final int _perPage = 10;
  @override
  void initState() {
    super.initState();
    registerReactions();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      isLoading2.value = true;
      await appController.getPhotosList(_page, _perPage);
      isLoading2.value = false;
    });
  }

  void registerReactions() {
    disposer ??= [
      reaction((p0) => appController.postList, (list) {
        debugPrint("LIST_LIST : ${list.length}");
        if (list.isNotEmpty) {
          isLoading.value = false;
        }
      }),
      reaction((p0) => appController.errorMessage, (errorMsg) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg.toString())));
      })
    ];
  }

  void removeReactions() {
    if (disposer == null) {
      return;
    } else {
      for (var ele in disposer!) {
        ele.reaction.dispose();
      }
    }
  }

  @override
  void dispose() {
    removeReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text(S.of(context).home),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Count")));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).countTask),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AllPostListPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).allPostDemoGetx),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AllPostDemoProviderPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).allPostDemoProvider),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CustomAnimationPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).customAnimation),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
            ),
          ),
        ],
      )),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Expanded(
            child: observeResponse(),
          )
        ],
      ),
    );
  }

  Widget observeResponse() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(
        () {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (appController.postList.isEmpty) {
            return const Text("No Data found");
          } else {
            return ListView.builder(
              itemCount: appController.postList.length + 1,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < appController.postList.length) {
                  return ImageCard(
                    imageUrl: appController.postList[index].url!,
                    description: appController.postList[index].title!,
                  );
                } else {
                  return _buildProgressIndicator();
                }
              },
            );
          }
        },
      ),
    );
  }

  // Widget observeResponse() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Observer(
  //       builder: (context) {
  //         if (isLoading.value) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (postStore.photosList.isEmpty) {
  //           return const Text("No Data found");
  //         } else {
  //           return ListView.builder(
  //             itemCount: postStore.photosList.length + 1,
  //             shrinkWrap: true,
  //             controller: _scrollController,
  //             itemBuilder: (context, index) {
  //               if (index < postStore.photosList.length) {
  //                 return ImageCard(
  //                   imageUrl: postStore.photosList[index].url!,
  //                   description: postStore.photosList[index].title!,
  //                 );
  //               } else {
  //                 return _buildProgressIndicator();
  //               }
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  Future<void> _loadData() async {
    if (!isLoading2.value) {
      setState(() {
        isLoading2.value = true;
      });
      await Future.delayed(Duration(seconds: 2));
      _page = _page + 10;
      await appController.getPhotosList(_page, _perPage);
      setState(() {
        isLoading2.value = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
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
