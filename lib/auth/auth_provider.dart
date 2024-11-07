import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<void> signIn(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } catch(e){
      rethrow;
    }
  }

   Future<void> signUp(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } catch(e){
      rethrow;
    }
  }

  void signOut() async{
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}