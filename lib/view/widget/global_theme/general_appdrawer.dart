import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneralAppDrawer extends StatelessWidget {
  const GeneralAppDrawer({Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
                height: 100,
                child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text(
                      "Foodbank App",
                      style: TextStyle(color: Colors.white),
                    ))),
            ListTile(
                title: const Text("Foodbank"),
                onTap: () {
                  context.go('/FoodbankPage');
                }),
            ListTile(
                title: const Text("Search By Location"),
                onTap: () {
                  context.go('/FoodbankSearchByLocationPage');
                }),
            ListTile(
                title: const Text("Donate Food"),
                onTap: () {
                  context.go('/FoodbankNeedsPage');
                }),
          ],
        )));
  }
}
