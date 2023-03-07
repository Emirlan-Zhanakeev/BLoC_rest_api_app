import 'package:bloc_rest_api/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserState extends Equatable {}

///если загрузилось то = true, если НЕ загрузилось то = false.
///три состояния загрузки: data loading state, data loaded state, data loading error state.

///first state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

///second state
class UserLoadedState extends UserState {
  ///if data loaded, that means we must save it here;
  UserLoadedState(this.users);
  final List<UserModel> users;
///принимаем данные

  @override
  List<Object?> get props => [users];
}
///third state
class UserErrorState extends UserState {
  ///if data loaded, that means we must save it here;
  UserErrorState(this.error);
  final String error;
  ///принимаем данные

  @override
  List<Object?> get props => [error];
}


