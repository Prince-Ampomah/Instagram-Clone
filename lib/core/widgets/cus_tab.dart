import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({Key? key, required this.tabName}) : super(key: key);
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(tabName, style: const TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
