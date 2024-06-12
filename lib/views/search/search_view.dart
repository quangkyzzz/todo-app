import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SearchView(),
      );
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
