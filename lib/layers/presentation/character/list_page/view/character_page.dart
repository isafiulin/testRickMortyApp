import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/router/router_path.dart';
import 'package:testrickmortyapp/layers/core/utilits/common_utils.dart';
import 'package:testrickmortyapp/layers/core/utilits/enums.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart';
import 'package:testrickmortyapp/layers/presentation/character/list_page/bloc/character_page_bloc.dart';
import 'package:testrickmortyapp/layers/presentation/widget/component/character_list_item.dart';
import 'package:testrickmortyapp/layers/presentation/widget/component/list_item_header.dart';
import 'package:testrickmortyapp/layers/presentation/widget/custom_floating_widget.dart';
import 'package:testrickmortyapp/layers/presentation/widget/custom_progress_indicator.dart';
import 'package:testrickmortyapp/layers/presentation/widget/empty_page_widget.dart';
import 'package:testrickmortyapp/layers/presentation/widget/filter_character_screen_widget.dart';
import 'package:testrickmortyapp/layers/presentation/widget/item_loading.dart';

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
  final _textController = TextEditingController();
  CharacterFilters filter = CharacterFilters(status: {
    CharacterStatus.alive: false,
    CharacterStatus.dead: false,
  }, species: {
    CharacterSpecies.alien: false,
    CharacterSpecies.human: false,
  }, gender: {
    CharacterGender.female: false,
    CharacterGender.male: false,
    CharacterGender.unknown: false,
  });

  CharacterPageBloc get pageBloc => context.read<CharacterPageBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterPageBloc, CharacterPageState>(
      listener: (context, state) {
        if (state.status == CharacterPageStatus.failure) {
          CommonUtil.showSnackBar(context, 'Error message');
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton:
              CustomFloatingWidget(scrollController: _scrollController),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                header(filter: filter),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      refreshList();
                    },
                    child: state.status == CharacterPageStatus.initial
                        ? const CustomProgressIndicator()
                        : state.characters.isEmpty
                            ? const EmptyListContainer()
                            : ListView.builder(
                                key: const ValueKey('character_page_list_key'),
                                controller: _scrollController,
                                itemCount: state.hasReachedEnd
                                    ? state.characters.length
                                    : state.characters.length + 1,
                                itemBuilder: (context, index) {
                                  if (index >= state.characters.length) {
                                    return !state.hasReachedEnd
                                        ? const ItemLoading()
                                        : const SizedBox();
                                  }
                                  final item = state.characters[index];
                                  return CharacterListItem(
                                      item: item, onTap: _goToDetails);
                                },
                              ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListItemHeader header({required CharacterFilters filter}) {
    return ListItemHeader(
      titleText: 'All Characters',
      controller: _textController,
      onFilter: () {
        filterBottomSheet(context, filter);
      },
      onClear: () {
        refreshList();
      },
      onSearch: () {
        setState(() {});
        pageBloc.add(RefreshPageEvent(
            filter: CharacterFilters(name: _textController.text.trim())));
      },
    );
  }

  void filterBottomSheet(BuildContext context, CharacterFilters filter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
          return FilterCharacterScreen(
            filter: filter,
            itemUpdate: () {
              stateSetter(() {});
            },
            onFilterProductsTap: () {
              Navigator.of(context).pop();
              pageBloc.add(RefreshPageEvent(filter: filter));
            },
            onClearFilterTap: () {
              filter.resetAll();
              Navigator.of(context).pop();

              refreshList();
            },
          );
        });
      },
    );
  }

  void refreshList() {
    pageBloc.add(const RefreshPageEvent());
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
      pageBloc.add(FetchNextPageEvent(filter: filter));
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
