import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.grey[900],), label: 'Home', ),
        BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.grey[900],), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.grey[900],), label: 'add'),
        BottomNavigationBarItem(icon: Icon(Icons.schedule, color: Colors.grey[900],), label: 'timeline'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble, color: Colors.grey[900],), label: 'message'),
      ]
  );
}