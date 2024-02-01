import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/router/router_path.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart';
import 'package:testrickmortyapp/layers/presentation/character/list_page/bloc/character_page_bloc.dart';
import 'package:testrickmortyapp/layers/presentation/shared/character_list_item.dart';
import 'package:testrickmortyapp/layers/presentation/shared/character_list_item_header.dart';
import 'package:testrickmortyapp/layers/presentation/shared/character_list_item_loading.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterPageBloc(
        getAllCharacters: context.read<GetAllCharacters>(),
      )..add(const FetchNextPageEvent()),
      child: const SafeArea(child: CharacterView()),
    );
  }
}

class CharacterView extends StatefulWidget {
  const CharacterView({super.key});

  @override
  State<CharacterView> createState() => CharacterViewState();
}

class CharacterViewState extends State<CharacterView> {
  final _scrollController = ScrollController();

  CharacterPageBloc get pageBloc => context.read<CharacterPageBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterPageBloc, CharacterPageState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scrollController.jumpTo(0);
            },
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
            child: const Icon(Icons.navigation),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: RefreshIndicator(
              onRefresh: () async {
                pageBloc.add(const RefreshPageEvent());
              },
              child: state.status == CharacterPageStatus.initial ||
                      state.status == CharacterPageStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      key: const ValueKey('character_page_list_key'),
                      controller: _scrollController,
                      itemCount: state.hasReachedEnd
                          ? state.characters.length
                          : state.characters.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.characters.length) {
                          return !state.hasReachedEnd
                              ? const CharacterListItemLoading()
                              : const SizedBox();
                        }
                        final item = state.characters[index];
                        return index == 0
                            ? Column(
                                children: [
                                  const CharacterListItemHeader(
                                      titleText: 'All Characters'),
                                  CharacterListItem(
                                      item: item, onTap: _goToDetails),
                                ],
                              )
                            : CharacterListItem(
                                item: item, onTap: _goToDetails);
                      },
                    ),
            ),
          ),
        );
      },
    );
  }

  void _goToDetails(Character character) {
    context.go(RouterPath.characterDetailPagePath, extra: character);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      pageBloc.add(const FetchNextPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
