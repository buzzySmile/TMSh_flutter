import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  // pass events from inner TextField
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SearchField({
    Key? key,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection =
            TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search movies',
        border: InputBorder.none,
        icon: Icon(
          Icons.search,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
