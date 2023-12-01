import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckEvent>((event, emit) async {
      await _checkAuth(emit);
    });
    on<AuthLoginEvent>((event, emit) async {
      await _login(event, emit);
    });
    on<AuthLogoutEvent>((event, emit) async {
      await _logout(emit);
    });
    on<AuthRegisterEvent>((event, emit) async {
      await _register(event, emit);
    });
    on<ChangePasswordEvent>((event, emit) async {
      await _changePassword(event, emit);
    });
  }

  Future<void> _checkAuth(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      print(event);
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);
      print(userCredential);
      emit(AuthSuccess(user: userCredential.user!));
    } catch (e) {
      print(e);
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _logout(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthLogout());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      await userCredential.user!.updateDisplayName(event.name);
      emit(AuthSuccess(user: userCredential.user!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.updatePassword(event.password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
