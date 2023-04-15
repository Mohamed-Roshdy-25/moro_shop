import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatefulWidget {
  final String searchBarTitle;
  const SearchBar({Key? key, required this.searchBarTitle})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.searchengin),
                const SizedBox(width: 10,),
                Text(widget.searchBarTitle,style: Theme.of(context).textTheme.titleSmall,)
              ],
            ),
          ),
      ],
    );
  }
}
