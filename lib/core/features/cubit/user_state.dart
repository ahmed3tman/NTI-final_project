import 'package:api_cubit_task/core/features/model/user_model.dart';

abstract class LapState {}

class LapInitial extends LapState {}

class LapLoading extends LapState {}

class LapLoaded extends LapState {

  List <LapModel> lapList;
  LapLoaded( this.lapList);
}
class LapError extends LapState {
}
