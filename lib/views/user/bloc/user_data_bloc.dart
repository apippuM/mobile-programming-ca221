import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/repositories/contracts/abs_api_user_data_repository.dart';

import '../../../models/moment.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AbsApiUserDataRepository _apiUserDataRepository;
  List<Moment> _userMoments = [];
  UserDataBloc(this._apiUserDataRepository) : super(UserDataInitial()) {
    on<UserDataLoadEvent>(userDataLoadEvent);
  }

  List<Moment> get userMoments => _userMoments = [];

  FutureOr<void> userDataLoadEvent(UserDataLoadEvent event, Emitter<UserDataState> emit) async {
    emit(UserDataLoadingState());
    try {
      _userMoments = await _apiUserDataRepository.getAllMoments();
      emit(UserDataLoadedState(_userMoments));
    } catch (e) {
      log(e.toString(), name: 'UserDataBloc:userDataLoadEvent');
      emit(UserDataLoadErrorActionState(e.toString()));
    }
  }
}
