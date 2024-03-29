import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/constants/assets.dart';
import 'package:testrickmortyapp/layers/core/router/router_path.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => GoRouter.of(context).go(RouterPath.charactersPage));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(ImageAsset.splashImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
