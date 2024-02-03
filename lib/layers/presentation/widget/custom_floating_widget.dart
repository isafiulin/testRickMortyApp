import 'package:flutter/material.dart';

class CustomFloatingWidget extends StatelessWidget {
  const CustomFloatingWidget({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.jumpTo(0);
      },
      foregroundColor: Colors.black,
      backgroundColor: Colors.green,
      shape: const CircleBorder(),
      child: const Icon(Icons.navigation),
    );
  }
}
