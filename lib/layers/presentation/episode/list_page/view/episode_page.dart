import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/router/router_path.dart';
import 'package:testrickmortyapp/layers/core/utilits/common_utils.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_episodes.dart';
import 'package:testrickmortyapp/layers/presentation/episode/list_page/bloc/episode_page_bloc.dart';
import 'package:testrickmortyapp/layers/presentation/shared/episode_list_item.dart';
import 'package:testrickmortyapp/layers/presentation/shared/list_item_header.dart';
import 'package:testrickmortyapp/layers/presentation/widget/custom_floating_widget.dart';
import 'package:testrickmortyapp/layers/presentation/widget/custom_progress_indicator.dart';
import 'package:testrickmortyapp/layers/presentation/widget/item_loading.dart';

class EpisodePage extends StatelessWidget {
  const EpisodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodePageBloc(
        getAllEpisodes: context.read<GetAllEpisodes>(),
      )..add(const FetchNextPageEvent()),
      child: const SafeArea(child: EpisodeView()),
    );
  }
}

class EpisodeView extends StatefulWidget {
  const EpisodeView({super.key});

  @override
  State<EpisodeView> createState() => EpisodeViewState();
}

class EpisodeViewState extends State<EpisodeView> {
  final _scrollController = ScrollController();

  EpisodePageBloc get pageBloc => context.read<EpisodePageBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EpisodePageBloc, EpisodePageState>(
      listener: (context, state) {
        if (state.status == EpisodePageStatus.failure) {
          CommonUtil.showSnackBar(context, 'Error message');
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton:
              CustomFloatingWidget(scrollController: _scrollController),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: state.status == EpisodePageStatus.initial
                ? const CustomProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () async {
                      pageBloc.add(const RefreshPageEvent());
                    },
                    child: ListView.builder(
                      key: const ValueKey('episode_page_list_key'),
                      controller: _scrollController,
                      itemCount: state.hasReachedEnd
                          ? state.episodes.length
                          : state.episodes.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.episodes.length) {
                          return !state.hasReachedEnd
                              ? const ItemLoading()
                              : const SizedBox();
                        }
                        final item = state.episodes[index];
                        return index == 0
                            ? Column(
                                children: [
                                  const ListItemHeader(
                                      titleText: 'All Episodes'),
                                  EpisodeListItem(
                                      item: item, onTap: _goToDetails),
                                ],
                              )
                            : EpisodeListItem(item: item, onTap: _goToDetails);
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _goToDetails(Episode episode) {
    context.go(RouterPath.episodeDetailPagePath, extra: episode);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageBloc.add(const FetchNextPageEvent());
    }
  }
}
