import 'package:api_cubit_task/core/features/home/cubit/lap_state.dart';
import 'package:api_cubit_task/core/features/home/model/lap_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LapCubit extends Cubit<LapState> {
  LapCubit() : super(LapInitial());

  Future<void> getLaps() async {
    if (isClosed) return;
    emit(LapLoading());

    try {
      final data = await getLapData();
      if (isClosed) return;
      emit(LapLoaded(data));
    } catch (e) {
      if (isClosed) return;
      emit(LapError(e.toString()));
    }
  }
}
