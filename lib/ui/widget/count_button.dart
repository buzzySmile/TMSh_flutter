import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final int count;

  CountButton({
    Key? key,
    required this.child,
    required this.count,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 0.0,
      child: TextButton(
        onPressed: this.onPressed,
        // elevation: 0,
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
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
                    this.count.toString(),
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
