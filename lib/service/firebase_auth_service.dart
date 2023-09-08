import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<User?> loginWithEmailAndPassword(String email, String password);
  Future<User?> signupWithEmailAndPassword(String email, String password);
  Future<User?> currentUser();
  Future<bool> signout();
}

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> currentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print(userCredential.user?.email);
    return userCredential.user;
  }

  @override
  Future<User?> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'invalid-email':
          log('Error message: ${exception.code} 1');
          break;
        case 'email-already-in-use':
          log('Error message: ${exception.code} 2');
          break;
        default:
          log('Error message: ${exception.code} 3');
          break;
      }
      return null;
    } catch (exception) {
      log('Error message: $exception');
      return null;
    }
  }

  @override
  Future<bool> signout() async {
    await _firebaseAuth.signOut();
    return true;
  }
}
