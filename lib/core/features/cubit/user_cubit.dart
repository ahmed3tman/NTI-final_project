import 'package:api_cubit_task/core/features/cubit/user_state.dart';
import 'package:api_cubit_task/core/features/model/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LapCubit extends Cubit<LapState> {
  LapCubit() : super(LapInitial());

  getLaps() async {
    emit(LapLoading());
    final data = await getLapData();
    emit(LapLoaded(data));
  }
}
