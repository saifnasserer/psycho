import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Auth Mode States
abstract class AuthModeState extends Equatable {
  const AuthModeState();

  @override
  List<Object?> get props => [];
}

class SignInMode extends AuthModeState {
  const SignInMode();
}

class SignUpMode extends AuthModeState {
  const SignUpMode();
}

// Auth Cubit
class AuthCubit extends Cubit<AuthModeState> {
  AuthCubit() : super(const SignInMode());

  void switchToSignIn() {
    emit(const SignInMode());
  }

  void switchToSignUp() {
    emit(const SignUpMode());
  }

  void toggleMode() {
    if (state is SignInMode) {
      emit(const SignUpMode());
    } else {
      emit(const SignInMode());
    }
  }
}
