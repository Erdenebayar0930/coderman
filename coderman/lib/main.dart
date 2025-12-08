import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize
  await GoogleSignIn.instance.initialize(
    clientId:
        '701759229006-kapupa91o1ei4vojir0qqpor9be9mbhs.apps.googleusercontent.com', // iOS/web-д шаардлагатай
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign-In 7.2.0 Demo',
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      // Full authentication
      final GoogleSignInAccount user = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      setState(() {});
    } catch (e) {
      print('Sign-in error: $e');
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await GoogleSignIn.instance.signOut();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In 7.2.0')),
      body: Center(
        child: user == null
            ? ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign in with Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.photoURL ?? ''),
                  ),
                  SizedBox(height: 10),
                  Text('Hello, ${user.displayName}'),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: _signOut, child: Text('Sign Out')),
                ],
              ),
      ),
    );
  }
}
