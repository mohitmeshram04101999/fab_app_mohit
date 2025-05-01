import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:flutter/material.dart';



class PlanDetailScreen extends StatefulWidget {
  const PlanDetailScreen({super.key});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      
      //
      appBar: AppBar(
        title: Text("Plan Detail"),
      ),
      
    );
  }
}
