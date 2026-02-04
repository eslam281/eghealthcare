import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome back, John"),CircleAvatar(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },shape: CircleBorder(),backgroundColor: Colors.green,
        child:Icon(LucideIcons.messageCircle,color: Colors.white,) ,),

      drawer: Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Alerts"),
        ],
      ),
      body: Placeholder(),
    );
  }
}
