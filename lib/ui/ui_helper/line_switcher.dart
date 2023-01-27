import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class LineSwitcher extends StatelessWidget {
  const LineSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeeProvider = Provider.of<ThemeProvider>(context);

    var switchLine = themeeProvider.isDarkMode
        ? Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                  Colors.white30,
                  Colors.white30,
                  Colors.white30,
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade200,
                  Colors.grey.shade600,
                  Colors.grey.shade600,
                  Colors.grey.shade600,
                  Colors.grey.shade200,
                  Colors.grey.shade200,
                ],
              ),
            ),
          );

    return switchLine;
  }
}
