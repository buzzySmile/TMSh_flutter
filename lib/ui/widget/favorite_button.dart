import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final int count;

  FavoriteButton({
    Key key,
    @required this.child,
    this.onPressed,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 0.0,
      child: FlatButton(
        onPressed: this.onPressed,
        // elevation: 0,
        color: Theme.of(context).accentColor,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            this.child,
            Positioned(
              top: -12.0,
              right: -6.0,
              child: Material(
                type: MaterialType.circle,
                elevation: 2.0,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(4.5),
                  child: Text(
                    this.count.toString(), // assign "data:" for counter change
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
