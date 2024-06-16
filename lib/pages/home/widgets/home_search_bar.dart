import 'package:flutter/material.dart';
import 'package:weather_app/utils/localizations.dart';

import '../../../theme/colors.dart';

typedef OnSearchEvent = void Function(String searchQuery);
typedef OnSearchFocusEvent = void Function(bool isSearchBarFocused);

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    this.initialQuery,
    this.isSearchBarFocused,
    this.onSearchEvent,
    this.onSearchFocusEvent,
    Key? key,
  }) : super(key: key);

  final String? initialQuery;
  final bool? isSearchBarFocused;
  final OnSearchEvent? onSearchEvent;
  final OnSearchFocusEvent? onSearchFocusEvent;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> with TickerProviderStateMixin {
  late FocusNode _searchFocusNode;

  late AnimationController _animationController;
  late AnimationController _searchAnimationController;
  late TextEditingController _textController;

  late String _searchQuery;

  late bool _isSearchBarFocused;

  @override
  void initState() {
    super.initState();

    _searchQuery = widget.initialQuery ?? '';

    _isSearchBarFocused = widget.isSearchBarFocused ?? false;

    _textController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _searchAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _animationController.forward();

    _searchFocusNode = FocusNode();

    _searchFocusNode.addListener(_onSearchFocusChanged);
    _textController.addListener(_onTextChanged);
  }

  void _onSearchFocusChanged() {
    setState(() {
      _isSearchBarFocused = _searchFocusNode.hasFocus;
    });

    widget.onSearchFocusEvent?.call(_isSearchBarFocused);
    animateSearchBar();
  }

  void _onTextChanged() {
    setState(() {
      _searchQuery = _textController.text;
    });

    widget.onSearchEvent?.call(_searchQuery);
  }

  void animateSearchBar() {
    if (_isSearchBarFocused) {
      _searchAnimationController.reverse();
    } else {
      _searchAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    _searchAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _searchFocusNode,
                controller: _textController,
                keyboardAppearance: Brightness.dark,
                onTapOutside: (event) {
                  if (_searchQuery.isEmpty) {
                    _searchFocusNode.unfocus();
                  }
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: WeatherColors.white),
                decoration: InputDecoration(
                  filled: true,
                  hintText: context.localizations.searchForACityOrAirport,
                  contentPadding: EdgeInsets.zero,
                  fillColor: WeatherColors.ev1,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFAAAAAA))),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF7F7F7F)),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? TextButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          child: const Icon(size: 18, Icons.cancel, color: Color(0xFFAAAAAA)),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                cursorColor: WeatherColors.white,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: SizedBox(
                width: _isSearchBarFocused ? null : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextButton(
                    onPressed: () {
                      _searchFocusNode.unfocus();
                      _textController.clear();
                    },
                    child: Text(
                      context.localizations.cancel,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w900, color: WeatherColors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
