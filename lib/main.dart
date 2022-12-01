import 'package:flutter_localizations/flutter_localizations.dart';
import '../../res/app_context_extension.dart';
import '../../res/app_localizations_delegate.dart';
import '../../routes/route_generator.dart';
import '../../ui/news_home/news_list_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    print("MARAJ SELECT LANG -->> ${newLocale.countryCode} / ${newLocale.languageCode}");
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  late Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _locale = const Locale("en");
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: context.resources.color.colorPrimary,
      ),
      initialRoute: NewsListScreen.id,
      onGenerateRoute: RouteGenerator().generateRoute,
      locale: _locale,
      supportedLocales: const [
        Locale("en"),
        Locale("hi"),
        Locale("zh"),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for(var supportedLocal in supportedLocales) {
          if(supportedLocal.languageCode == locale?.languageCode && supportedLocal.countryCode == locale?.countryCode){
            return supportedLocal;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
