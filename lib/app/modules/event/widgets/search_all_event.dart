import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchAll extends StatelessWidget {
  final FocusNode focusNode;

  final VoidCallback onTap;

  SearchAll({required this.focusNode, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: const Color(0xfff2f2f2)),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 192, 187, 187).withOpacity(1),
                  offset: const Offset(0, 5),
                  blurRadius: 3,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Icon(
              FontAwesomeIcons.cube,
              color: Theme.of(context).colorScheme.secondary,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              minLines: 1,
              decoration: InputDecoration(
                label: InkWell(
                  onTap: onTap,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.magnifyingGlass),
                      Text("\t\tAll Event"),
                    ],
                  ),
                ),
                hintText: 'Search...',
                isCollapsed: true,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
                // icon: Icon(FontAwesomeIcons.searchengin),
                contentPadding: const EdgeInsets.all(14),
                alignLabelWithHint: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0XFFf2f2f2),
                    width: 1.5,
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
