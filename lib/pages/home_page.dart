import 'package:flutter/material.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/widgets/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key, 
    required this.moments,
    required this.onUpdate,
    required this.onDelete,});

  final List<Moment> moments;
  final Function(String id) onUpdate;
  final Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: moments.map(
          (momentItem) => PostItem(
            moment: momentItem, 
            onUpdate: onUpdate, 
            onDelete: onDelete),
        ).toList(),
      ),
);
  }
}
