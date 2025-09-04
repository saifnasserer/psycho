import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Form Data State
class AuthFormData extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final DateTime? birthDate;

  const AuthFormData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.birthDate,
  });

  AuthFormData copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    DateTime? birthDate,
  }) {
    return AuthFormData(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    birthDate,
  ];
}

// Form State
abstract class AuthFormState extends Equatable {
  const AuthFormState();

  @override
  List<Object?> get props => [];
}

class AuthFormInitial extends AuthFormState {
  const AuthFormInitial();
}

class AuthFormLoading extends AuthFormState {
  const AuthFormLoading();
}

class AuthFormSuccess extends AuthFormState {
  const AuthFormSuccess();
}

class AuthFormError extends AuthFormState {
  final String message;

  const AuthFormError(this.message);

  @override
  List<Object?> get props => [message];
}

// Form Cubit
class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit() : super(const AuthFormInitial());

  AuthFormData _formData = const AuthFormData();

  AuthFormData get formData => _formData;

  void updateName(String name) {
    _formData = _formData.copyWith(name: name);
  }

  void updateEmail(String email) {
    _formData = _formData.copyWith(email: email);
  }

  void updatePassword(String password) {
    _formData = _formData.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    _formData = _formData.copyWith(confirmPassword: confirmPassword);
  }

  void updateBirthDate(DateTime? birthDate) {
    _formData = _formData.copyWith(birthDate: birthDate);
  }

  void resetForm() {
    _formData = const AuthFormData();
  }

  void submitForm() {
    emit(const AuthFormLoading());

    // TODO: Implement actual form submission logic
    // For now, just simulate success
    Future.delayed(const Duration(seconds: 1), () {
      emit(const AuthFormSuccess());
    });
  }
}
