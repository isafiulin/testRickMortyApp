import 'package:flutter/material.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';

typedef OnEpisodeListItemTap = void Function(Episode episode);

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final Episode item;
  final OnEpisodeListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          // height: 124,
          child: Row(
            children: [
              _ItemDescription(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({required this.item});

  final Episode item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: colorScheme.surfaceVariant,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.name ?? '',
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Air Date: ${item.airDate}',
                  style: textTheme.labelSmall!.copyWith(
                    color: Colors.lightGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Episode: ${item.episode}',
                  style: textTheme.labelSmall!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
