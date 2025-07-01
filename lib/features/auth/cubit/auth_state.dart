
import 'package:api_cubit_task/features/auth/model/response_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final ResponseModel data;

  AuthLoaded({required this.data});
 
}
