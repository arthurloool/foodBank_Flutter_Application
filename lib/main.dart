import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/view/Page/foodbankNeedsPage.dart';
import 'package:test_provider/view/Page/foodbankPage.dart';
import 'package:test_provider/view/Page/foodbankSearchByLocationPage.dart';
import 'package:test_provider/viewmodel/foodbanksvm.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(initialLocation: '/FoodbankPage', routes: [
    GoRoute(
      path: '/FoodbankPage',
      builder: (context, state) => const FoodbankPage(),
    ),
    GoRoute(
      path: '/FoodbankSearchByLocationPage',
      builder: (context, state) => const FoodbankSearchByLocationPage(),
    ),
    GoRoute(
      path: '/FoodbankNeedsPage',
      builder: (context, state) => const FoodbankNeedsPage(),
    ),
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FoodBankModel()),
        ],
        child: MaterialApp.router(
          routerConfig: router(),
        ));
  }
}
