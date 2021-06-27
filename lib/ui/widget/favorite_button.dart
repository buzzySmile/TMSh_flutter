import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

class FavoriteButton extends StatelessWidget {
  final Widget icon;

  FavoriteButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return ButtonTheme(
          minWidth: 0.0,
          child: TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/shortlist',
            ),
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                this.icon,
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
                        '${store.state.movies!.length}',
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
      },
    );
  }
}
