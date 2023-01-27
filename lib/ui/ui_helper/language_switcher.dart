import 'package:exchange/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;

    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                backgroundColor: primaryColor,
                title: Text(
                  AppLocalizations.of(context)!.language,
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: SizedBox(
                            width: width / 8,
                            height: height / 9,
                            child: Image.asset(
                              'assets/images/kingdom.png',
                              fit: BoxFit.fill,
                            )),
                        onTap: () {
                          languageProvider.toggleLanguageEn();
                        },
                        title: Text(
                          AppLocalizations.of(context)!.english,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SizedBox(
                          width: width / 8,
                          height: height / 9,
                          child: Image.asset(
                            'assets/images/iran.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          languageProvider.toggleLanguagePer();
                        },
                        title: Text(
                          AppLocalizations.of(context)!.persian,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.language),
    );
  }
}
