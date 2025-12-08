import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginPage extends StatefulWidget {
  const FacebookLoginPage({super.key});

  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<void> signInWithFacebook() async {
    try {
      // Facebook Login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Create a credential for Firebase
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Sign in with Firebase
        final UserCredential userCredential = await _auth.signInWithCredential(
          facebookAuthCredential,
        );

        setState(() {
          _user = userCredential.user;
        });

        print('Нэвтэрсэн хэрэглэгч: ${_user!.displayName}');
      } else {
        print('Facebook login failed: ${result.status}');
      }
    } catch (e) {
      print('Алдаа гарлаа: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await FacebookAuth.instance.logOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Facebook Login')),
      body: Center(
        child: _user == null
            ? ElevatedButton(
                onPressed: signInWithFacebook,
                child: Text('Login with Facebook'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_user!.displayName}'),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: signOut, child: Text('Logout')),
                ],
              ),
      ),
    );
  }
}
