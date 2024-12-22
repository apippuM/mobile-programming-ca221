part of 'user_data_bloc.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();
  
  @override
  List<Object> get props => [];
}

final class UserDataInitial extends UserDataState {}
final class UserDataLoadingState extends UserDataState {}
final class UserDataActionState extends UserDataState {
  const UserDataActionState();
}

final class UserDataLoadedState extends UserDataState {
  final List<Moment> moments;
  const UserDataLoadedState(this.moments);

  @override
  // TODO: implement props
  List<Object> get props => [moments];
}

final class UserDataLoadErrorActionState extends UserDataActionState {
  final String message;
  const UserDataLoadErrorActionState(this.message);
}