import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziprofile/models/reel.dart';
import 'package:ziprofile/providers/story_provider.dart';
import 'package:ziprofile/screens/app/story_screen.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

import '../../models/private_user/private_story.dart';
import '../../widgets/cached_image.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key, required this.navigatorKey});
  final navigatorKey;
  @override
  Widget build(BuildContext context) {
    //return _page();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return _page(context);
        });
      },
    );
  }

  _page(BuildContext context) {
    var provider = Provider.of<StoryProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Hikayeler'),
      ),
      body: _pageContent(provider),
    );
  }

  _pageContent(StoryProvider provider) {
    return ((provider.stored_reels == null ||
                provider.stored_reels?.length == 0) &&
            !SharedPrefs().userStorage.getIsFastAuth())
        ? _buildEmptyPage()
        : _buildGridView(provider);
  }

  Column _buildEmptyPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            'Hiç Hikaye Listelenemedi!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontFamily: 'Raleway',
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  CustomScrollView _buildGridView(StoryProvider provider) {
    var childCount = provider.stored_reels?.length ?? 0;
    if (SharedPrefs().userStorage.getIsFastAuth()) {
      childCount =
          SharedPrefs().userStorage.getM2XUserList()?.userResponses.length ?? 0;
    }
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 15),
              color: Colors.yellow[800],
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Takip ettiğiniz kullanıcıların hikayelerini görmek için oturum açmalısınız.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }, childCount: 1),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                color: Colors.grey[850],
                child: SharedPrefs().userStorage.getIsFastAuth() == true
                    ? _nonAuthListView(index)
                    : storyWidget(provider, index, context),
              );
            }, childCount: childCount),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 0.75,
            ))
      ],
    );
  }

  Widget _nonAuthListView(int index) {
    var user =
        SharedPrefs().userStorage.getM2XUserList()!.userResponses[index].info;
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(250),
            child: CachedImage(
              imageUrl: user?.profile_picture ?? "",
              width: 90,
              height: 90,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            user?.username ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  InkWell storyWidget(StoryProvider provider, int index, BuildContext context) {
    return InkWell(
      onTap: () => _openStory(provider.stored_reels![index], context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(250),
            child: CachedImage(
              imageUrl: provider.stored_reels?[index].user.profile_pic_url,
              width: 90,
              height: 90,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            provider.stored_reels?[index].user.username ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  _openStory(Reel reel, BuildContext ctx) {
    List<PrivateStory> _privateStories = [];

    for (var item in reel.items) {
      var media_type = item.media_type;
      if (media_type == 1) {
        _privateStories.add(
          PrivateStory(
            item.taken_at,
            item.id,
            media_type,
            item.image_versions2?.candidates?[0].url,
            null,
          ),
        );
      } else {
        _privateStories.add(
          PrivateStory(
            item.taken_at,
            item.id,
            media_type,
            null,
            item.video_versions?[0].url,
          ),
        );
      }
    }
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => StoryScreen(
          privateStory: _privateStories,
        ),
      ),
    );
  }

  Widget StoryListItem() {
    return Container(
      height: 150,
      width: 25,
      child: Card(
        color: Colors.grey[850],
        child: Column(
          children: [Text('sasa')],
        ),
      ),
    );
  }
}
