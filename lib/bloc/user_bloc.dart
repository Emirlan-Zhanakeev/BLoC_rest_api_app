import 'dart:async';

// ignore_for_file: avoid_print
import 'package:bloc/bloc.dart';
import 'package:bloc_rest_api/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ///так как мы вызываем этот класс из ui, то он нам нужен
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getData();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
