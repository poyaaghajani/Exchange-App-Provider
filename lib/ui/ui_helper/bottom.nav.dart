import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key, required this.controller});

  PageController controller;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      color: primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        width: width,
        height: height / 13,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: width,
                height: height / 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.animateToPage(0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.home, size: 27),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.bar_chart, size: 27),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                height: height / 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.person, size: 27),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.animateToPage(3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.bookmark, size: 27),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
