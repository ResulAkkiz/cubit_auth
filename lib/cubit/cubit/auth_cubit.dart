import 'package:cubit_auth/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _firebaseAuthService;
  AuthCubit(this._firebaseAuthService) : super(AuthInitial(null)) {
    getCurrentUser();
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _firebaseAuthService.signout();
      emit(AuthSuccessful(null));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      User? user = await _firebaseAuthService.currentUser();
      emit(AuthSuccessful(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      User? user =
          await _firebaseAuthService.loginWithEmailAndPassword(email, password);
      emit(AuthSuccessful(user));
    } on FirebaseAuthException catch (error) {
      emit(AuthError('loginWithEmailAndPassword hatası:${error.toString()}'));
    }
  }

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      User? user = await _firebaseAuthService.signupWithEmailAndPassword(
          email, password);
      emit(AuthSuccessful(user));
    } on FirebaseAuthException catch (error) {
      emit(AuthError('signupWithEmailAndPassword hatası:${error.toString()}'));
    }
  }
}
