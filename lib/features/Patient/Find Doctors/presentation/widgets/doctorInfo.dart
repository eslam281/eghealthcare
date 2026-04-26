import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final String name;
  const DoctorInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.greenAccent.withAlpha(30),
          child: Text(name[0],style:
          TextStyle(color: Colors.green.withGreen(190)),),
        ),
        title: Text("Dr. $name"),
      ),
    );
  }
}
