// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrickmortyapp/injectable.dart';
import 'package:testrickmortyapp/layers/core/router/router.dart';
import 'package:testrickmortyapp/layers/core/theme/theme.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_episodes.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getIt<GetAllCharacters>()),
        RepositoryProvider.value(value: getIt<GetAllEpisodes>()),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.dark,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
      ),
    );
  }
}
