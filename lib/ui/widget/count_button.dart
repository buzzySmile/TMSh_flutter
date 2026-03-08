import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final int count;

  const CountButton({
    super.key,
    required this.child,
    required this.count,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 0.0,
      child: TextButton(
        onPressed: onPressed,
        // elevation: 0,
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
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
                    count.toString(),
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
