
import 'package:api_cubit_task/features/auth/cubit/auth_state.dart';
import 'package:api_cubit_task/features/auth/data/auth_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthData data = AuthData();

  registerCubit( {
    required String name,
    required String email,
    required String phone,
    required String nationalId,
    required String gender,
    required String password,
  })   async{
    emit(AuthLoading());

   var response = await data.register(
      name: name,
      email: email,
      phone: phone,
      nationalId: nationalId,
      gender: gender,
      password: password,
    );
    emit(AuthLoaded(  data:response));
  }
}
