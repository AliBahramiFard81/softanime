import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_details_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/bloc/more_bloc.dart';
import 'package:main/cubit/anime_details_cubit.dart';
import 'package:main/cubit/background_image_cubit.dart';
import 'package:main/cubit/carousel_cubit.dart';
import 'package:main/cubit/genre_grid_cubit.dart';
import 'package:main/cubit/login_cubit.dart';
import 'package:main/cubit/quotes_cubit.dart';
import 'package:main/pages/loading_page.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const supabaseUrl = 'https://ryxzovwudemndhnysevr.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ5eHpvdnd1ZGVtbmRobnlzZXZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxODY0NDEsImV4cCI6MjAyNTc2MjQ0MX0.p32akImxXIfW8wGC_ZfwTRhqb_Z67t-HMNT__cOCot4';
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AnimeBloc()),
        BlocProvider(create: (context) => CarouselCubit()),
        BlocProvider(create: (context) => GenreGridCubit()),
        BlocProvider(create: (context) => QuotesCubit()),
        BlocProvider(create: (context) => BackgroundImageCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AnimePageBloc()),
        BlocProvider(create: (context) => AnimeDetailsBloc()),
        BlocProvider(create: (context) => AnimeDetailsCubit()),
        BlocProvider(create: (context) => AnimeCharacterActorBloc()),
        BlocProvider(create: (context) => MangaBloc()),
        BlocProvider(create: (context) => MoreBloc()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: const LoadingPage(),
          );
        },
      ),
    );
  }
}
