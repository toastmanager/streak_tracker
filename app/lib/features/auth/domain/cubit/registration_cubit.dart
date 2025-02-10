import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'registration_state.dart';
part 'registration_cubit.freezed.dart';

@lazySingleton
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationState.initial());

  void setErrorMessage(String? message) =>
      emit(RegistrationState.initial(errorMessage: message));
}
