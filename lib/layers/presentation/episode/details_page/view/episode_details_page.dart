import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/presentation/episode/details_page/bloc/episode_details_bloc.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({super.key, required this.episode});

  final Episode episode;

  // static Route<void> route({required Episode episode}) {
  //   return MaterialPageRoute(
  //     builder: (context) {
  //       return BlocProvider(
  //         create: (_) => EpisodeDetailsBloc(episode: episode),
  //         child: const EpisodeDetailsPage(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EpisodeDetailsBloc(episode: episode),
      child: const EpisodeDetailsView(),
    );
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class EpisodeDetailsView extends StatelessWidget {
  const EpisodeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        title: const Text('Details'),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Builder(
        builder: (ctx) {
          final episode = ctx.select(
            (EpisodeDetailsBloc b) => b.state.episode,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero(
              //   tag: episode.id!,
              //   child: CachedNetworkImage(
              //     imageUrl: episode.image!,
              //     fit: BoxFit.cover,
              //     height: 300,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        episode.name ?? '',
                        style: textTheme.displaySmall!.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'Status: ${episode.isAlive ? 'ALIVE!' : 'DEAD!'}',
                      //   style: textTheme.titleMedium!.copyWith(
                      //     color: episode.isAlive
                      //         ? Colors.lightGreen
                      //         : Colors.redAccent,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      const Divider(height: 1),
                      const SizedBox(height: 16),
                      // Text(
                      //   'Origin: ${episode.origin?.name ?? ''}',
                      //   style: textTheme.bodyMedium!.copyWith(
                      //     color: colorScheme.onSurfaceVariant,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // Text(
                      //   'Last location: ${episode.location?.name ?? ''}',
                      //   style: textTheme.bodyMedium!.copyWith(
                      //     color: colorScheme.onSurfaceVariant,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'Species: ${episode.species ?? ''}',
                      //   style: textTheme.bodyMedium!.copyWith(
                      //     color: colorScheme.onSurfaceVariant,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'Type: ${episode.type ?? '?'}',
                      //   style: textTheme.bodyMedium!.copyWith(
                      //     color: colorScheme.onSurfaceVariant,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'Gender: ${episode.gender ?? ''}',
                      //   style: textTheme.bodyMedium!.copyWith(
                      //     color: colorScheme.onSurfaceVariant,
                      //   ),
                      // ),
                      // const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Episodes:',
                  style: textTheme.bodyLarge!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: episode.episode?.length ?? 0,
                  itemBuilder: (context, index) {
                    final ep = episode.episode![index];
                    return EpisodeItem(ep: ep);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Episode
// -----------------------------------------------------------------------------
class EpisodeItem extends StatelessWidget {
  const EpisodeItem({super.key, required this.ep});

  final String ep;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final name = ep.split('/').last;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: colorScheme.surfaceVariant,
        ),
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            name,
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
