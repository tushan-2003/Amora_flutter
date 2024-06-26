part of 'swipe_bloc.dart';

sealed class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SwipeEvent {
  final User user;

  const LoadUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateSwipeScreen extends SwipeEvent {
  final List<User> users;

  const UpdateSwipeScreen({required this.users});

  @override
  List<Object> get props => [users];
}

class SwipeLeftEvent extends SwipeEvent {
  final User user;

  const SwipeLeftEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SwipeRightEvent extends SwipeEvent {
  final User user;

  const SwipeRightEvent({required this.user});

  @override
  List<Object> get props => [user];
}
