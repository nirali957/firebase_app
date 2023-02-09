import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignInAccount? currentUser;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    // TODO: implement initState
    successGoogle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  signInWithGoogle();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---- Social Google Login ------------>>>
  signInWithGoogle() {
    googleSignIn.signIn();
  }

  void successGoogle() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      currentUser = account;

      if (currentUser != null) {
        debugPrint('''
          Google Logged in!
          Google Id: ${currentUser!.id}
          Email: ${currentUser!.email};
          Name: ${currentUser!.displayName ?? ""};
          Profile Pic: ${currentUser!.photoUrl ?? ""};
      ''');

        final GoogleSignInAuthentication? googleAuth = await currentUser?.authentication;

        debugPrint("Google Auth accessToken ------------->>>${googleAuth!.accessToken}");
        debugPrint("Google Auth idToken ------------->>>${googleAuth.idToken}");

        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        debugPrint("credential ------------->>>$credential");

        await firebaseAuth.signInWithCredential(credential);

        // await account.clearAuthCache();
        // await googleSignIn.disconnect();
        // await googleSignIn.signOut();
        // currentUser = null;
      }
    });
  }

/*  signInWithGoogle() async {
    currentUser = await googleSignIn.signIn();

    if (currentUser != null) {
      debugPrint('''
          Google Logged in!
          Google Id: ${currentUser!.id}
          Email: ${currentUser!.email};
          Name: ${currentUser!.displayName ?? ""};
          Profile Pic: ${currentUser!.photoUrl ?? ""};
      ''');

        final GoogleSignInAuthentication? googleAuth = await currentUser?.authentication;

        debugPrint("Google Auth accessToken ------------->>>${googleAuth!.accessToken}");
        debugPrint("Google Auth idToken ------------->>>${googleAuth.idToken}");

        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        debugPrint("credential ------------->>>$credential");

        await firebaseAuth.signInWithCredential(credential);

    }
  }*/
}
