import 'package:flutter/material.dart';
import '../../models/private_user/private_following_user.dart';
import '../../widgets/scaffold_snackbar.dart';

// ignore: must_be_immutable
class UserFollowingScreen extends StatefulWidget {
  final navigatorKey;
  List<PrivateFollowingUser> userList;
  UserFollowingScreen({
    super.key,
    required this.navigatorKey,
    required this.userList,
  });

  @override
  State<UserFollowingScreen> createState() => _UserFollowingScreenState(
        navigatorKey: navigatorKey,
        userList: userList,
      );
}

class _UserFollowingScreenState extends State<UserFollowingScreen> {
  final navigatorKey;
  List<PrivateFollowingUser> userList;
  _UserFollowingScreenState(
      {required this.navigatorKey, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Takip'),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () => ScaffoldSnackbar(
              context: context,
              message: "Bu sayfadan kullanıcıyı görüntüleyemezsiniz",
            ),
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${widget.userList[index].username}",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  widget.userList[index].is_verified == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 19,
                          ),
                        )
                      : SizedBox(),
                  widget.userList[index].is_private == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 19,
                          ),
                        )
                      : SizedBox()
                ],
              ),
              subtitle: Text(
                widget.userList[index].full_name ?? "",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }),
        itemCount: widget.userList.length,
      ),
    );
  }
}
