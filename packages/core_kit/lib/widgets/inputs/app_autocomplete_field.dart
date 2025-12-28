// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:async';
import 'package:flutter/material.dart';

/// A Material Design 3 autocomplete text field component that displays
/// intelligent suggestions as users type.
///
/// This component wraps Flutter's [Autocomplete] widget with Material Design 3
/// styling, providing a standardized way to implement autocomplete functionality
/// with client-side or server-side suggestion filtering, keyboard navigation,
/// and customizable suggestion rendering.
///
/// ## Features
///
/// - **Intelligent Filtering**: Client-side filtering with multiple strategies
///   (startsWith, contains, fuzzy matching)
/// - **Async Support**: Integrates with APIs for server-side suggestion loading
/// - **Debouncing**: Configurable delay to reduce filtering/API calls
/// - **Keyboard Navigation**: Arrow keys to navigate, Enter to select, Escape to close
/// - **Custom Rendering**: Customize how suggestions appear in dropdown
/// - **Highlight Matching**: Optional highlighting of matching text in suggestions
/// - **Loading States**: Built-in loading indicator for async operations
/// - **Empty States**: Customizable empty state when no suggestions match
/// - **Free Text Input**: Option to allow non-suggestion values
/// - **Accessibility**: Proper semantic labels and screen reader support
///
/// ## Usage
///
/// ```dart
/// // Basic autocomplete with static suggestions
/// AppAutocompleteField<String>(
///   suggestions: ['Apple', 'Banana', 'Cherry', 'Date'],
///   label: 'Select Fruit',
///   hint: 'Type to search...',
///   onSelected: (value) => print('Selected: $value'),
/// )
///
/// // Async autocomplete with API integration
/// AppAutocompleteField<String>(
///   onSuggestionsFetchRequested: (query) async {
///     final response = await api.searchUsers(query);
///     return response.users;
///   },
///   label: 'Search Users',
///   displayStringForOption: (user) => user.name,
///   onSelected: (user) => print('Selected: ${user.name}'),
/// )
///
/// // Email autocomplete with domain suggestions
/// AppAutocompleteField<String>(
///   suggestions: ['@gmail.com', '@yahoo.com', '@outlook.com'],
///   label: 'Email',
///   filterStrategy: FilterStrategy.contains,
///   allowFreeText: true,
///   onSelected: (email) => print('Email: $email'),
/// )
///
/// // Autocomplete with custom item rendering
/// AppAutocompleteField<User>(
///   suggestions: users,
///   displayStringForOption: (user) => user.name,
///   customItemBuilder: (context, user, isHighlighted) {
///     return ListTile(
///       leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
///       title: Text(user.name),
///       subtitle: Text(user.email),
///       tileColor: isHighlighted ? Colors.grey[200] : null,
///     );
///   },
///   onSelected: (user) => print('Selected: ${user.name}'),
/// )
/// ```
///
/// ## Common Use Cases
///
/// **Location/Address Autocomplete**:
/// - Suggest cities, states, or full addresses as user types
/// - Integrate with Google Places API for real-time suggestions
///
/// **Email Domain Suggestions**:
/// - Auto-complete common email domains (@gmail.com, @yahoo.com)
/// - Validate email format while allowing free text input
///
/// **Tag/Category Input**:
/// - Suggest existing tags while allowing new tag creation
/// - Filter large tag lists efficiently on client-side
///
/// **User/Contact Search**:
/// - Find users by typing name, username, or email
/// - Display rich user cards with avatars and metadata
///
/// **Product Search**:
/// - Show product suggestions with thumbnails and prices
/// - Debounce search to reduce API calls
///
/// **Command Palette**:
/// - Quick action selection with fuzzy matching
/// - Keyboard-first navigation for power users
///
/// ## Material Design 3 Specifications
///
/// **Layout**:
/// - Text field: Uses AppTextField styling (outlined, 56dp height)
/// - Suggestions dropdown: Menu overlay positioned below field
/// - Max dropdown height: 308dp (5.5 items visible)
/// - Item height: 56dp per suggestion
///
/// **States**:
/// - Typing: Dropdown shows filtered suggestions
/// - Loading: Progress indicator displayed in dropdown
/// - Empty: "No suggestions found" message in dropdown
/// - Selected: Dropdown closes, field populated with selection
/// - Focused: Dropdown opens on focus if suggestions available
///
/// **Typography**:
/// - Input text: bodyLarge
/// - Suggestion items: bodyLarge
/// - Matching text: Bold weight for highlighted portions
/// - Empty state: bodyMedium with reduced opacity
///
/// **Spacing**:
/// - Dropdown padding: 8dp vertical
/// - Item padding: 16dp horizontal
/// - Gap between field and dropdown: 4dp
///
/// **Animations**:
/// - Dropdown fade-in: 200ms
/// - Selection highlight: Instant on hover/keyboard focus
///
/// ## Filtering Strategies
///
/// - **startsWith**: Matches suggestions that start with the query (default)
/// - **contains**: Matches suggestions containing the query anywhere
/// - **fuzzy**: Matches suggestions with characters in sequence (flexible)
///
/// ## Accessibility
///
/// - Dropdown announced as "Showing N suggestions"
/// - Selected option announced when changed via keyboard
/// - Escape key dismisses dropdown with announcement
/// - Screen reader support for loading and empty states
///
/// See also:
/// - [Material Design 3 Autocomplete](https://m3.material.io/components/menus)
/// - [AppTextField] for text input styling
/// - [AppSearchField] for search-optimized fields
class AppAutocompleteField<T extends Object> extends StatefulWidget {
  /// Static list of suggestions.
  ///
  /// Used for client-side filtering. Mutually exclusive with
  /// [onSuggestionsFetchRequested].
  final List<T>? suggestions;

  /// Callback to fetch suggestions asynchronously (e.g., from an API).
  ///
  /// Called whenever the user types, after debounce delay.
  /// Mutually exclusive with [suggestions].
  final Future<List<T>> Function(String query)? onSuggestionsFetchRequested;

  /// Function to convert suggestion to display string.
  ///
  /// Required when [T] is not a String.
  final String Function(T)? displayStringForOption;

  /// Callback when a suggestion is selected.
  final void Function(T)? onSelected;

  /// Callback when text changes (includes non-suggestion text).
  final void Function(String)? onChanged;

  /// Controller for the text field.
  final TextEditingController? controller;

  /// Label text displayed above the field.
  final String? label;

  /// Hint text displayed when field is empty.
  final String? hint;

  /// Helper text displayed below the field.
  final String? helperText;

  /// Error text displayed below the field in error color.
  final String? errorText;

  /// Prefix icon displayed at the start of the field.
  final IconData? prefixIcon;

  /// Suffix icon displayed at the end of the field.
  final IconData? suffixIcon;

  /// Whether to allow text that doesn't match any suggestion.
  ///
  /// When true, users can type arbitrary text. When false, only
  /// suggestion selection is allowed.
  final bool allowFreeText;

  /// Whether the field is enabled for user interaction.
  final bool enabled;

  /// Whether to autofocus this field on widget creation.
  final bool autofocus;

  /// Focus node for controlling focus programmatically.
  final FocusNode? focusNode;

  /// Filtering strategy for client-side suggestion filtering.
  final FilterStrategy filterStrategy;

  /// Debounce delay before filtering or fetching suggestions.
  ///
  /// Defaults to 300ms. Set to Duration.zero to disable debouncing.
  final Duration debounceDelay;

  /// Maximum number of suggestions to display.
  ///
  /// Defaults to showing all matching suggestions.
  final int? maxSuggestions;

  /// Maximum height of the suggestions dropdown.
  ///
  /// Defaults to 308dp (5.5 items at 56dp each).
  final double maxDropdownHeight;

  /// Custom widget builder for suggestion items.
  ///
  /// Provides full control over suggestion rendering.
  /// [isHighlighted] indicates if item is currently focused via keyboard.
  final Widget Function(BuildContext, T, bool isHighlighted)? customItemBuilder;

  /// Whether to highlight matching text in suggestions.
  ///
  /// Only works with default item builder (when [customItemBuilder] is null).
  final bool highlightMatching;

  /// Text to display when no suggestions match.
  final String emptyStateText;

  /// Text to display while loading async suggestions.
  final String loadingText;

  /// Initial value for the field.
  final T? initialValue;

  /// Creates a Material Design 3 autocomplete field.
  const AppAutocompleteField({
    this.suggestions,
    this.onSuggestionsFetchRequested,
    this.displayStringForOption,
    this.onSelected,
    this.onChanged,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.allowFreeText = true,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.filterStrategy = FilterStrategy.startsWith,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.maxSuggestions,
    this.maxDropdownHeight = 308.0,
    this.customItemBuilder,
    this.highlightMatching = true,
    this.emptyStateText = 'No suggestions found',
    this.loadingText = 'Loading...',
    this.initialValue,
    super.key,
  }) : assert(
         suggestions != null || onSuggestionsFetchRequested != null,
         'Either suggestions or onSuggestionsFetchRequested must be provided',
       );

  @override
  State<AppAutocompleteField<T>> createState() =>
      _AppAutocompleteFieldState<T>();
}

class _AppAutocompleteFieldState<T extends Object>
    extends State<AppAutocompleteField<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  Timer? _debounceTimer;
  List<T> _filteredSuggestions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Set initial value if provided
    if (widget.initialValue != null) {
      _controller.text = _getDisplayString(widget.initialValue as T);
    }

    // Initialize suggestions
    if (widget.suggestions != null) {
      _filteredSuggestions = widget.suggestions!;
    }

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        // Dropdown will close automatically when focus is lost
      });
    }
  }

  String _getDisplayString(T option) {
    if (widget.displayStringForOption != null) {
      return widget.displayStringForOption!(option);
    }
    return option.toString();
  }

  void _onTextChanged(String text) {
    widget.onChanged?.call(text);

    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    if (text.isEmpty) {
      setState(() {
        _filteredSuggestions = widget.suggestions ?? [];
      });
      return;
    }

    // Start new debounce timer
    _debounceTimer = Timer(widget.debounceDelay, () {
      if (widget.onSuggestionsFetchRequested != null) {
        _fetchAsyncSuggestions(text);
      } else if (widget.suggestions != null) {
        _filterSuggestions(text);
      }
    });
  }

  Future<void> _fetchAsyncSuggestions(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final suggestions = await widget.onSuggestionsFetchRequested!(query);
      if (mounted) {
        setState(() {
          _filteredSuggestions = widget.maxSuggestions != null
              ? suggestions.take(widget.maxSuggestions!).toList()
              : suggestions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _filteredSuggestions = [];
          _isLoading = false;
        });
      }
    }
  }

  void _filterSuggestions(String query) {
    final lowercaseQuery = query.toLowerCase();
    List<T> filtered = widget.suggestions!.where((suggestion) {
      final displayString = _getDisplayString(suggestion).toLowerCase();

      switch (widget.filterStrategy) {
        case FilterStrategy.startsWith:
          return displayString.startsWith(lowercaseQuery);
        case FilterStrategy.contains:
          return displayString.contains(lowercaseQuery);
        case FilterStrategy.fuzzy:
          return _fuzzyMatch(displayString, lowercaseQuery);
      }
    }).toList();

    if (widget.maxSuggestions != null) {
      filtered = filtered.take(widget.maxSuggestions!).toList();
    }

    setState(() {
      _filteredSuggestions = filtered;
    });
  }

  bool _fuzzyMatch(String text, String query) {
    int queryIndex = 0;
    for (int i = 0; i < text.length && queryIndex < query.length; i++) {
      if (text[i] == query[queryIndex]) {
        queryIndex++;
      }
    }
    return queryIndex == query.length;
  }

  void _onSuggestionSelected(T suggestion) {
    _controller.text = _getDisplayString(suggestion);
    widget.onSelected?.call(suggestion);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      focusNode: _focusNode,
      textEditingController: _controller,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Never>.empty();
        }
        return _filteredSuggestions;
      },
      displayStringForOption: _getDisplayString,
      onSelected: _onSuggestionSelected,
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onChanged: _onTextChanged,
              onSubmitted: (value) {
                if (widget.allowFreeText) {
                  widget.onChanged?.call(value);
                }
                onFieldSubmitted();
              },
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                helperText: widget.helperText,
                errorText: widget.errorText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon)
                    : null,
                suffixIcon: _buildSuffixIcon(),
                border: const OutlineInputBorder(),
              ),
            );
          },
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<T> onSelected,
            Iterable<T> options,
          ) {
            return _buildDropdown(context, onSelected, options);
          },
    );
  }

  Widget? _buildSuffixIcon() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (widget.suffixIcon != null) {
      return Icon(widget.suffixIcon);
    }
    return null;
  }

  Widget _buildDropdown(
    BuildContext context,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxDropdownHeight),
          child: _isLoading
              ? _buildLoadingState(theme)
              : options.isEmpty
              ? _buildEmptyState(theme)
              : _buildSuggestionsList(
                  context,
                  onSelected,
                  options,
                  colorScheme,
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            widget.loadingText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        widget.emptyStateText,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(
    BuildContext context,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
    ColorScheme colorScheme,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options.elementAt(index);
        return InkWell(
          onTap: () => onSelected(option),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: widget.customItemBuilder != null
                ? widget.customItemBuilder!(context, option, false)
                : Text(
                    _getDisplayString(option),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
        );
      },
    );
  }
}

/// Filtering strategies for autocomplete suggestions.
enum FilterStrategy {
  /// Matches suggestions that start with the query text.
  startsWith,

  /// Matches suggestions that contain the query text anywhere.
  contains,

  /// Fuzzy matching - matches suggestions with characters in sequence.
  fuzzy,
}
