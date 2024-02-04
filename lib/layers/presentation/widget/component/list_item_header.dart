import 'package:flutter/material.dart';
import 'package:testrickmortyapp/layers/presentation/widget/component/search_bar_widget.dart';

class ListItemHeader extends StatelessWidget {
  const ListItemHeader({
    super.key,
    required this.titleText,
    required this.controller,
    this.onSearch,
    this.onClear,
    this.onFilter,
  });

  final String titleText;
  final TextEditingController controller;
  final Function()? onSearch;
  final Function()? onClear;
  final Function()? onFilter;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Card(
          elevation: 0,
          color: cs.tertiaryContainer,
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(
                    Icons.person,
                    color: cs.onTertiaryContainer,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    titleText,
                    style: tt.titleMedium!.copyWith(
                      color: cs.onTertiaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {
                      if (onFilter != null) {
                        onFilter!();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: cs.tertiaryContainer,
          ),
        ),
        SearchBarWidget(
          controller: controller,
          onSearch: onSearch,
          onClear: onClear,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: cs.tertiaryContainer,
          ),
        ),
      ],
    );
  }
}
