// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/utilits/enums.dart';

import 'package:testrickmortyapp/layers/presentation/widget/custom_button.dart';

class FilterCharacterScreen extends StatelessWidget {
  const FilterCharacterScreen({
    super.key,
    required this.onClearFilterTap,
    required this.onFilterProductsTap,
    required this.filter,
    required this.itemUpdate,
  });

  final Function() onClearFilterTap;
  final Function() onFilterProductsTap;
  //TODO не лучшее решение =(
  final Function() itemUpdate;
  final CharacterFilters filter;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 10),
              child: InputChipList(
                title: 'Select gender',
                filter: filter.gender,
                onChanged: (bool value, Enum? enumValue) {
                  itemUpdate();
                  filter.setOnlyOneGenderTrue(enumValue as CharacterGender);
                },
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 10),
              child: InputChipList(
                title: 'Select status',
                filter: filter.status,
                onChanged: (bool value, Enum? enumValue) {
                  itemUpdate();

                  filter.setOnlyOneStatusTrue(enumValue as CharacterStatus);
                },
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 10),
              child: InputChipList(
                title: 'Select species',
                filter: filter.species,
                onChanged: (bool value, Enum? enumValue) {
                  itemUpdate();

                  filter.setOnlyOneSpeciesTrue(enumValue as CharacterSpecies);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        margin: EdgeInsets.only(bottom: padding.bottom * 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 50,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    borderColor: Colors.white,
                    backgroundColor: Colors.white,
                    title: 'Clear filter',
                    onPressed: onClearFilterTap,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.zero,
                    borderColor: Colors.green,
                    backgroundColor: Colors.white,
                    title: 'Apply filter',
                    onPressed: onFilterProductsTap,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class InputChipList extends StatelessWidget {
  const InputChipList({
    super.key,
    required this.filter,
    required this.title,
    required this.onChanged,
  });

  final Map<Enum, bool>? filter;
  final String title;
  final Function(bool, Enum?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filter?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputChip(
                  selectedColor: Colors.red,
                  backgroundColor: Colors.cyan,
                  selected: filter?.values.elementAt(index) ?? false,
                  label: Text(filter?.keys.elementAt(index).name ?? ''),
                  onSelected: (bool value) {
                    onChanged(value, filter?.keys.elementAt(index));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
