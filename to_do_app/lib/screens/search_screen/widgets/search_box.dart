import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class SearchBox extends StatefulWidget {
  final Function onFilter;

  const SearchBox({super.key, required this.onFilter});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: green1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => widget.onFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: white,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: white,
          ),
        ),
      ),
    );
  }
}
