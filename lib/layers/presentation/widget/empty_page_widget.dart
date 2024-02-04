import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testrickmortyapp/layers/core/constants/assets.dart';

class EmptyListContainer extends StatelessWidget {
  const EmptyListContainer({super.key, this.isFull = true});

  final bool isFull;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Center(child: SvgPicture.asset(ImageAsset.ic404))),
      ],
    );
  }
}
