import 'package:flutter/material.dart';

import "./create_closet_item.dart" as create_closet_item;

class ClosetView extends StatefulWidget {
  const ClosetView({super.key});

  @override
  State<ClosetView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => create_closet_item.CreateClosetItemPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
