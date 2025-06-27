
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';

abstract class LapState {}

class LapInitial extends LapState {}

class LapLoading extends LapState {}

class LapLoaded extends LapState {

  List <LapModel> lapList;
  LapLoaded( this.lapList);
}
class LapError extends LapState {
  LapError(String string);
}
