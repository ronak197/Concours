import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UserConfig {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  bool isSignedIn;

  UserConfig(){
    this.isSignedIn = false;
    this.setup();
  }

  setup() async {
    this.isSignedIn = await googleSignIn.isSignedIn();
    if(isSignedIn){
      this.user = await _auth.currentUser();
    } else {
      this.user = null;
    }
  }

  Future<Map> getUser() async {
    this.user = await _auth.currentUser();
    var data = {
      "displayName": this.user.displayName,
      "email": this.user.email,
      "photoUrl": this.user.photoUrl,
      "uid": this.user.uid,
      "phoneNumber": this.user.phoneNumber
    };

    return data;
  }

  Future<bool> isLoggedIn() async {
    this.isSignedIn = await googleSignIn.isSignedIn();
    return this.isSignedIn;
  }

  Future<void> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    this.user = await _auth.signInWithGoogle(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken
    );
    this.isSignedIn = await googleSignIn.isSignedIn();

    print("User Name: ${user.displayName}");
    
  }

  signOut(){
    googleSignIn.signOut();
    this.setup();
  }
}