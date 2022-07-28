import 'package:equatable/equatable.dart';
import 'package:simple_app_bloc/auth_models/confirm_password.dart';
import 'package:simple_app_bloc/auth_models/email.dart';
import 'package:simple_app_bloc/auth_models/name.dart';
import 'package:simple_app_bloc/auth_models/password.dart';
import 'package:formz/formz.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.image,
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String image;
  final FormzStatus status;

  @override
  List<Object> get props => [
    image,
    name,
    email,
    password,
    confirmPassword,
    status
  ];

  SignUpState copyWith({
    String image,
    Name name,
    Email email,
    Password password,
    ConfirmPassword confirmPassword,
    FormzStatus status,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }
}