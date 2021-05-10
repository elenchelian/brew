import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_6/models/user.dart';
import 'package:lab_6/services/database.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user obj basedon firebase
  User _userFromFirebaseUSer(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User>get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user)=> _userFromFirebaseUSer(user));
          .map(_userFromFirebaseUSer);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & passs
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
      return _userFromFirebaseUSer(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email & pass
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
      
      //create a new document for the user uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUSer(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}