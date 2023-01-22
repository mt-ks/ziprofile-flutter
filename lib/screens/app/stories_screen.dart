import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/random_users_provider.dart';
import './user_screen.dart';
import '../../exceptions/api_exception.dart';
import '../../models/private_user/private_user.dart';
import '../../services/api_service.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/scaffold_snackbar.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key, required this.navigatorKey});
  final navigatorKey;

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    //return _page();
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return _page(context);
        });
      },
    );
  }

  _page(BuildContext context) {
    var provider = Provider.of<RandomUsersProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Rastgele Profiller'),
      ),
      body: _pageContent(provider),
    );
  }

  _pageContent(RandomUsersProvider provider) {
    return ((provider.randomUsers == null ||
            provider.randomUsers?.users.length == 0))
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
            'Hiç Profil Listelenemedi!',
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

  CustomScrollView _buildGridView(RandomUsersProvider provider) {
    var childCount = provider.randomUsers?.users.length ?? 0;
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
                  'Aşağıdaki profiller rastgele listelenmiştir, hemen görüntüleyebilirsiniz.',
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
                child: storyWidget(
                  provider.randomUsers!.users[index],
                  provider.randomUsers?.access_token,
                  context,
                ),
              );
            }, childCount: childCount),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 0.70,
            ))
      ],
    );
  }

  InkWell storyWidget(
    PrivateUser user,
    String? access_token,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        _loadUser(user, access_token, context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(250),
            child: CachedImage(
              imageUrl: user.profile_picture,
              width: 90,
              height: 90,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${user.username}',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          (user.is_private == true)
              ? Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 16,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void _loadUser(
      PrivateUser user, String? accessToken, BuildContext ctx) async {
    _loadingDialog = LoadingDialog(context: context);
    try {
      _loadingDialog.showLoaderDialog();
      var result = await ApiService().getUserInfo(
        user.pk,
        access_token: accessToken,
      );
      _loadingDialog.hideDialog();

      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (ctx) => UserScreen(
            naviagorKey: widget.navigatorKey,
            response: result,
          ),
        ),
      );
    } on APIException catch (e) {
      _loadingDialog.hideDialog();
      ScaffoldSnackbar(context: context, message: e.message);
    }
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
