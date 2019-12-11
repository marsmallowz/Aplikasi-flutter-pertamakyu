import 'package:cobaaaa_dulu/app/home_page.dart';
import 'package:cobaaaa_dulu/app/sign_in/sign_in_page.dart';
import 'package:cobaaaa_dulu/services/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
//  @override
//  _LandingPageState createState() => _LandingPageState();
//}
//
//class _LandingPageState extends State<LandingPage> {
//  User _user;
//  @override
//  void initState() {
//    super.initState();
//    _checkCurrentUser();
//    widget.auth.onAuthStateChanged.listen((user) {
//      print('user: ${user?.uid}');
//    });
//  }
//
//  Future<void> _checkCurrentUser() async {
//    User user = await widget.auth.currentUser();
//    _updateUser(user);
//  }
//
//  void _updateUser(User user) {
//    setState(() {
//      _user = user;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
//                onSignIn: _updateUser,
              );
            }
            return HomePage(
              auth: auth,
//              onSignOut: () => _updateUser(null),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
