import 'package:dummy_api_call_retrofit/screens/notifier/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../widgets/image_card.dart';

class AllPostDemoProviderPage extends StatefulWidget {
  const AllPostDemoProviderPage({super.key});

  @override
  State<AllPostDemoProviderPage> createState() =>
      _AllPostDemoProviderPageState();
}

class _AllPostDemoProviderPageState extends State<AllPostDemoProviderPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AppNotifier>(context, listen: false).loadMorePhotos();
    });
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<AppNotifier>(context, listen: false).loadMorePhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).allPostProvider),
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
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        if (value.postList.isEmpty) {
          return const Text("No Data found");
        } else {
          return ListView.builder(
            itemCount: value.postList.length + 1,
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (context, index) {
              debugPrint(
                  "Consumer_Consumer  CONTROLLER LEN :${value.postList.length}");
              if (index < value.postList.length) {
                return ImageCard(
                  imageUrl: value.postList[index].url ?? "null",
                  description: value.postList[index].title ?? "null",
                );
              } else {
                return _buildProgressIndicator();
              }
            },
          );
        }
      },
    );
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
