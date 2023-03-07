part of 'user_bloc.dart';

@immutable /// - we are not going to change initial code;
abstract class UserEvent extends Equatable{
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
