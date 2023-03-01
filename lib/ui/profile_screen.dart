import 'package:exchange/providers/theme_provider.dart';
import 'package:exchange/ui/singup_screen.dart';
import 'package:exchange/ui/ui_helper/line_switcher.dart';
import 'package:exchange/ui/ui_helper/profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textTheme = Theme.of(context).textTheme;
    var background = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(AppLocalizations.of(context)!.profile),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 20, vertical: height / 50),
            child: Row(
              children: [
                Container(
                  height: height / 10,
                  width: width / 5,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/poya.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: width / 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Poya Aghajani',
                      style: textTheme.bodyLarge,
                    ),
                    SizedBox(height: height / 100),
                    Text(
                      'Programmer',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height / 50),
          const LineSwitcher(),
          SizedBox(height: height / 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Column(
              children: [
                ProfileDetail(
                  text: AppLocalizations.of(context)!.personalData,
                  icon: Icons.person,
                ),
                ProfileDetail(
                  text: AppLocalizations.of(context)!.orders,
                  icon: Icons.calendar_month_sharp,
                ),
                ProfileDetail(
                  text: AppLocalizations.of(context)!.setting,
                  icon: Icons.settings,
                ),
                ProfileDetail(
                  text: AppLocalizations.of(context)!.authen,
                  icon: Icons.mark_email_read,
                ),
                SizedBox(height: height / 80),
                const LineSwitcher(),
                SizedBox(height: height / 35),
                ProfileDetail(
                  text: AppLocalizations.of(context)!.about,
                  icon: Icons.book_sharp,
                ),
                ProfileDetail(
                  text: AppLocalizations.of(context)!.community,
                  icon: Icons.people,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
