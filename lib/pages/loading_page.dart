import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    context.read<AuthBloc>().add(AutoLogin());

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is NoUserFound) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
            if (state is AuthSuccess) {
              context.read<AnimeBloc>().add(GetHomePage());
            }
            if (state is AuthFailed) {
              print('failed');
            }
          },
        ),
        BlocListener<AnimeBloc, AnimeState>(
          listener: (context, state) {
            if (state is AnimeHomeSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            if (state is AnimeHomeFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
              context.read<AnimeBloc>().add(GetHomePage());
            }
          },
        )
      ],
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
