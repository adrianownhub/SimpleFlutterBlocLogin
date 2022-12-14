import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_app_bloc/auth_models/confirm_password.dart';
import 'package:simple_app_bloc/auth_models/email.dart';
import 'package:simple_app_bloc/auth_models/name.dart';
import 'package:simple_app_bloc/auth_models/password.dart';
import 'package:formz/formz.dart';
import '../db/time_database.dart';
import '../models/time.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());

  @override
  void onTransition(Transition<SignUpEvent, SignUpState> transition) {
    //print(transition);
    super.onTransition(transition);
  }

  Future addTime() async{
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    final time = Time(
      email: state.email.value,
      createdTime: now,
    );
    await TimeDatabase.instance.create(time);
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name.valid ? name : Name.pure(),
        status: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmPassword,
        ]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(),
        status: Formz.validate([
          state.name,
          email,
          state.password,
          state.confirmPassword,
        ]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      final confirm = ConfirmPassword.dirty(
          password: password.value,
          value: state.confirmPassword?.value,
      );
      yield state.copyWith(
        password: password.valid ? password : Password.pure(),
        status: Formz.validate([
          state.name,
          state.email,
          password,
          confirm,
        ]),
      );
    } else if (event is ConfirmPasswordChanged) {
      final password = ConfirmPassword.dirty(
          password: state.password.value,
          value: event.confirmPassword
      );
      //('confirm is valid ${password.valid}');
      yield state.copyWith(
        confirmPassword: password.valid ? password : ConfirmPassword.pure(),
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          password,
        ]),
      );
    } else if (event is ProfileImageChanged) {
      final String profileImage = event.image;
      yield state.copyWith(
        image: profileImage,
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          state.confirmPassword,
        ]),
      );
    } else if (event is FormSubmitted) {
      if (!state.status.isValidated) return;
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await addTime();
        await Future.delayed(Duration(seconds: 3));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}