import 'package:blog/routes/routes.dart';
import 'package:blog/screens/screen_create_blog/screen_create_blog.dart';
import 'package:blog/screens/screen_home/screen_home.dart';
import 'package:blog/screens/screen_view_blog/screen_view_blog.dart';
import 'package:blog/service/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BlogService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogs',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: route,
        routes: {
          route: (context) => const ScreenHome(),
          routeCreateBlog: (context) => ScreenCreateBlog(),
          routeViewBlog: (context) => const ScreenViewBlog(),
        },
      ),
    );
  }
}
