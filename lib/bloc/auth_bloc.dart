// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:main/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  AuthBloc() : super(AuthInitial()) {
    on<AutoLogin>((event, emit) async {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) {
        return emit(NoUserFound());
      } else {
        final data = await supabase
            .from('user_info')
            .select()
            .eq('email', user.email.toString());
        if (data.isEmpty) {
          return emit(NoUserFound());
        } else {
          return emit(AuthSuccess());
        }
      }
    });

    on<UserRegister>((event, emit) async {
      emit(AuthLoading());
      final registerResponse = await AuthService(
              username: event.username,
              email: event.email,
              password: event.password)
          .signUp();
      switch (registerResponse) {
        case 0:
          return emit(AuthFailed(error: 'something went wrong'));
        case 1:
          return emit(AuthFailed(error: 'username already exists'));
        case 2:
          return emit(AuthFailed(error: 'wrong email or password'));
        case 3:
          return emit(AuthSuccess());
      }
    });
    on<UserLogin>((event, emit) async {
      emit(AuthLoading());
      final registerResponse =
          await AuthService(email: event.email, password: event.password)
              .signIn();
      switch (registerResponse) {
        case 0:
          return emit(AuthFailed(error: 'something went wrong'));
        case 2:
          return emit(AuthFailed(error: 'wrong email or password'));
        case 1:
          return emit(AuthSuccess());
      }
    });
  }
}
