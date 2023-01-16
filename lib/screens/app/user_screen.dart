import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziprofile/models/private_user/private_user_info_response.dart';
import 'package:ziprofile/screens/app/post_screen.dart';
import 'package:ziprofile/screens/app/story_screen.dart';
import 'package:ziprofile/screens/app/user_following_screen.dart';
import 'package:ziprofile/widgets/cached_image.dart';
import 'package:ziprofile/widgets/scaffold_snackbar.dart';
import 'package:story_view/story_view.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.naviagorKey, required this.response});
  final naviagorKey;
  final PrivateUserInfoResponse response;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text('@${widget.response.info?.username}'),
            (widget.response.info?.is_verified == true)
                ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 19,
                    ),
                  )
                : SizedBox(),
            (widget.response.info?.is_private == true)
                ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 19,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return UserHead();
            }, childCount: 1),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var media_url = "";
                if (widget.response.posts?[index].media_type == 1) {
                  media_url = widget.response.posts?[index].image_url ?? "";
                }
                if (widget.response.posts?[index].media_type == 8) {
                  media_url = widget.response.posts?[index].carousel_media?[0]
                          .image_url ??
                      "";
                }
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => PostScreen(
                              navigatorKey: this.widget.naviagorKey,
                              privatePost: widget.response.posts![index],
                            )),
                      ),
                    );
                  },
                  child: CachedImage(
                    imageUrl: media_url,
                  ),
                );
              },
              childCount: widget.response.posts?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  _navigateToFollowerScreen() {
    Navigator.of(this.context).push(
      MaterialPageRoute(
        builder: (context) => UserFollowingScreen(
          navigatorKey: widget.naviagorKey,
          userList: widget.response.following!,
        ),
      ),
    );
  }

  _navigateToStoryScreen() {
    if (widget.response.stories != null &&
        widget.response.stories!.length != 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StoryScreen(
            privateStory: widget.response.stories!,
          ),
        ),
      );
    } else {
      ScaffoldSnackbar(context: context, message: "Hikaye Yok!");
    }
  }

  Container myListView() {
    return Container(
      //color: Colors.black,
      child: ListView.builder(
          itemBuilder: ((context, index) {
            if (index == 0) {
              return UserHead();
            }
          }),
          itemCount: 2),
    );
  }

  Widget UserHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Color.fromARGB(255, 24, 24, 24),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Kayıt Tarihi: ${DateFormat("dd.MM.yyyy HH:mm").format(DateTime.fromMillisecondsSinceEpoch(widget.response.info?.checked_at * 1000))}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              UserAvatar(),
              Spacer(),
              UserStatistic(
                widget.response.info?.media_count.toString() ?? "0",
                "Gönderi",
                () => {},
              ),
              Spacer(),
              UserStatistic(
                widget.response.info?.follower_count.toString() ?? "0",
                "Takipçi",
                () => {
                  ScaffoldSnackbar(
                    context: context,
                    message:
                        "Yanlızca kullanıcının takip ettiklerini görebilirsiniz.",
                  )
                },
              ),
              Spacer(),
              UserStatistic(
                widget.response.info?.following_count.toString() ?? "0",
                "Takip",
                () => _navigateToFollowerScreen(),
              ),
              Spacer(),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 8)),
        widget.response.info?.full_name != null
            ? Text(
                widget.response.info!.full_name!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              )
            : SizedBox(),
        widget.response.info?.biography != null
            ? Text(
                widget.response.info!.biography!,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              )
            : SizedBox(),
      ],
    );
  }

  InkWell UserStatistic(String count, String description, Function onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  UserAvatar() {
    return Container(
      decoration: (widget.response.stories == null ||
              widget.response.stories!.length == 0)
          ? BoxDecoration()
          : BoxDecoration(
              border: Border.all(color: Colors.red, width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(250),
              ),
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(250),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(250)),
          onTap: () => _navigateToStoryScreen(),
          child: CachedImage(
            imageUrl: widget.response.info?.profile_picture,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
