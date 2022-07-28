import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app_bloc/auth_models/email.dart';
import 'package:simple_app_bloc/auth_models/password.dart';
import 'package:simple_app_bloc/time_database.dart';
import 'package:formz/formz.dart';
import '../models/time.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password
      ]),
    ));
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

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await addTime();
      await Future.delayed(Duration(milliseconds: 500));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));

    } on Exception catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e.toString()));
    }
  }
}