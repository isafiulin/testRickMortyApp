import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/router/router_path.dart';
import 'package:testrickmortyapp/layers/core/utilits/extra_codec.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/presentation/character/details_page/view/character_details_page.dart';
import 'package:testrickmortyapp/layers/presentation/character/list_page/view/character_page.dart';
import 'package:testrickmortyapp/layers/presentation/episode/details_page/view/episode_details_page.dart';
import 'package:testrickmortyapp/layers/presentation/episode/list_page/view/episode_page.dart';
import 'package:testrickmortyapp/layers/presentation/main_tab/view/main_tab_page.dart';
import 'package:testrickmortyapp/layers/presentation/splash_page/view/splash_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// The route configuration.
final goRouter = GoRouter(
  initialLocation: '/',
  extraCodec: const MyExtraCodec(),

  navigatorKey: rootNavigatorKey,
  //navigatorKey: GlobalKey<NavigatorState>(),
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        }),

    ///BOTTOM BAR NAVIGATION
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainTabScreen(navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: RouterPath.charactersPage,
              builder: (context, state) => const CharacterPage(),
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.characterDetailPage,
                    builder: (BuildContext context, GoRouterState state) {
                      final Character character = state.extra as Character;

                      return CharacterDetailsPage(
                        character: character,
                      );
                    }),
              ],
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: RouterPath.episodesPage,
              builder: (context, state) => const EpisodePage(),
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.episodeDetailPage,
                    builder: (BuildContext context, GoRouterState state) {
                      final Episode episode = state.extra as Episode;

                      return EpisodeDetailsPage(
                        episode: episode,
                      );
                    }),
              ],
            )
          ]),
        ])
  ],
);
