import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/routes/route_generator.dart';
import 'package:news_flutter_block/ui/news_home/news_list_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: context.resources.color.colorPrimary,
      ),
      initialRoute: NewsListScreen.id,
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
