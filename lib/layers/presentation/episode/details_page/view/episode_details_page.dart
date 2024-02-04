import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_characters_by_id.dart';
import 'package:testrickmortyapp/layers/presentation/episode/details_page/bloc/episode_details_bloc.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({super.key, required this.episode});
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EpisodeDetailsBloc(
          episode: episode,
          getCharactersByIDs: context.read<GetCharactersByIDs>())
        ..add(FetchCharactersEvent(episode: episode)),
      child: const EpisodeDetailsView(),
    );
  }
}

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
          // final episode = ctx.select(
          //   (EpisodeDetailsBloc b) => b.state.episode,
          // );

          return BlocBuilder<EpisodeDetailsBloc, EpisodeDetailsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            state.episode.name ?? '',
                            style: textTheme.displaySmall!.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 8),
                          const Divider(height: 1),
                          const SizedBox(height: 16),
                          Text(
                            'Air date: ${state.episode.airDate ?? ''}',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Episode: ${state.episode.episode ?? ''}',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Characters:',
                      style: textTheme.bodyLarge!.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.characters?.length ?? 0,
                      itemBuilder: (context, index) {
                        final character = state.characters![index];
                        return CharacterItem(character: character);
                        // final character = episode.episode![index];
                        // return SizedBox(
                        //   height: 122,
                        //   child: Hero(
                        //     tag: episode.id!,
                        //     child: CachedNetworkImage(
                        //       height: 122,
                        //       width: 122,
                        //       imageUrl: episode.image!,
                        //       fit: BoxFit.cover,
                        //       errorWidget: (ctx, url, err) =>
                        //           const Icon(Icons.error),
                        //       placeholder: (ctx, url) => const Icon(Icons.image),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            child: SizedBox(
          height: 80,
          child: Hero(
            tag: character.id!,
            child: CachedNetworkImage(
              height: 80,
              width: 80,
              imageUrl: character.image!,
              fit: BoxFit.cover,
              errorWidget: (ctx, url, err) => const Icon(Icons.error),
              placeholder: (ctx, url) => const Icon(Icons.image),
            ),
          ),
        )),
      ),
    );
  }
}
