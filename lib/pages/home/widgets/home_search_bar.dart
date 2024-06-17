import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/localizations.dart';

import '../../../theme/colors.dart';
import 'city_list/cubit/city_list_cubit.dart';

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
  late TextEditingController _textController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialQuery);
    _searchFocusNode = FocusNode();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _searchFocusNode.addListener(_onSearchFocusChanged);
    _textController.addListener(_onTextChanged);

    _checkIfSearchBarIsFocused();
  }

  @override
  void didUpdateWidget(covariant HomeSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSearchBarFocused != widget.isSearchBarFocused) {
      _checkIfSearchBarIsFocused();
    }
  }

  void _onSearchFocusChanged() {
    bool isFocused = _searchFocusNode.hasFocus;
    widget.onSearchFocusEvent?.call(isFocused);

    if (isFocused) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void _onTextChanged() {
    widget.onSearchEvent?.call(_textController.text);
  }

  void _checkIfSearchBarIsFocused() {
    if (widget.isSearchBarFocused ?? false) {
      _searchFocusNode.requestFocus();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textController.clear();
        _searchFocusNode.unfocus();
        context.read<CityListCubit>().clearCitiesSearchResults();
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchBarFocused = _searchFocusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _searchFocusNode,
              controller: _textController,
              keyboardAppearance: Brightness.dark,
              onTapOutside: (event) {
                if (_textController.text.isEmpty) {
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
                  borderSide: const BorderSide(color: Color(0xFFAAAAAA)),
                ),
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: const Icon(Icons.search, color: Color(0xFF7F7F7F)),
                suffixIcon: _textController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Color(0xFFAAAAAA)),
                        onPressed: () {
                          _textController.clear();
                        },
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
              width: isSearchBarFocused ? null : 0,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: WeatherColors.white,
                        ),
                    overflow: TextOverflow.ellipsis,
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
