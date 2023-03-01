import 'package:exchange/providers/crypto_data_provider.dart';
import 'package:exchange/providers/language_provider.dart';
import 'package:exchange/providers/market_view_provider.dart';
import 'package:exchange/providers/theme_provider.dart';
import 'package:exchange/providers/user_data_provider.dart';
import 'package:exchange/ui/main_wrapper.dart';
import 'package:exchange/ui/singup_screen.dart';
import 'package:exchange/ui/splash_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
      ChangeNotifierProvider(create: (context) => MarketViewProvider()),
      ChangeNotifierProvider(create: (context) => UserDataProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              locale: languageProvider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              home: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    SharedPreferences prefs = snapshot.data!;
                    var loggedIn = prefs.getBool('loggesIn') ?? false;

                    if (loggedIn) {
                      return const SplashScreen();
                    } else {
                      return SingupScreen();
                    }
                  }
                  {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Color(0xff4a64fe),
                        size: 35,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
