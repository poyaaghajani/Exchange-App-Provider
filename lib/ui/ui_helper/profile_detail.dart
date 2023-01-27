import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  IconData icon;
  String text;
  ProfileDetail({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textTheme = Theme.of(context).textTheme;

    var cardColor = Theme.of(context).cardColor;

    return Padding(
      padding: EdgeInsets.only(bottom: height / 70),
      child: Row(
        children: [
          Container(
            height: height / 15,
            width: width / 7,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28),
          ),
          SizedBox(
            width: width / 25,
          ),
          Text(text, style: textTheme.bodyLarge),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: cardColor,
            size: 20,
          )
        ],
      ),
    );
  }
}
