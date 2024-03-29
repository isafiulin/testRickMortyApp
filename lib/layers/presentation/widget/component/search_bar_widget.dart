// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {super.key, required this.controller, this.onSearch, this.onClear});
  final TextEditingController controller;
  final Function()? onSearch;
  final Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: const Color(0xFFDDDDDD)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (String value) {
                    if (onSearch != null) {
                      onSearch!();
                    }
                  },
                  decoration: const InputDecoration(
                    //TODO hardcode string
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      color: Color(0xFF727272),
                      fontFamily: 'Gilroy',
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 10,
                      right: 5,
                      left: 5,
                    ),
                  ),
                ),
              ),
              controller.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        controller.clear();
                        if (onClear != null) {
                          onClear!();
                        }
                      },
                      child: const Icon(
                        Icons.close_outlined,
                        color: Color(0xffCECECE),
                      ),
                    )
                  : const Icon(
                      Icons.search,
                      color: Color(0xffCECECE),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
