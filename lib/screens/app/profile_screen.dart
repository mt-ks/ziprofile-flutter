import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../icons/nav_icons.dart';
import '../../providers/user_provider.dart';
import './purchase_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen(
      {super.key, required this.navigatorKey, required this.navIndex});
  final navigatorKey;
  final ValueChanged<int> navIndex;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var user = provider.user!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("@${user.user.username}"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Text(
                'Hoşgeldin!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                'Aşağıdaki menüden artık aktif şekilde gezinebilirsin!',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              IntrinsicHeight(
                child: Row(
                  children: [
                    userAction(
                      icon: NavIcons.search_icon,
                      description: 'Arşivlenmiş Profilleri Görüntüle',
                      onClick: () {
                        navIndex(1);
                      },
                    ),
                    userAction(
                      icon: NavIcons.stories,
                      description: 'Rastgele Profiller',
                      onClick: () {
                        navIndex(2);
                      },
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    userAction(
                        icon: Icons.touch_app_outlined,
                        description: 'Aboneliklerim',
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PurchaseScreen(),
                          ));
                        }),
                    userAction(
                      icon: Icons.settings,
                      description: 'Ayarlar',
                      onClick: () {
                        navIndex(3);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialPageRoute<dynamic> content() {
    return MaterialPageRoute(builder: ((context) {
      return Container();
    }));
  }
}

class userAction extends StatelessWidget {
  const userAction({
    super.key,
    required this.icon,
    required this.description,
    required this.onClick,
  });
  final IconData icon;
  final String description;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        color: Color.fromARGB(255, 24, 24, 24),
        margin: EdgeInsets.all(10),
        elevation: 0.4,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onClick();
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
