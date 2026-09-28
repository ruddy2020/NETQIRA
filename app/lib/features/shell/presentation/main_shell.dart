import 'package:flutter/material.dart';

import '../../history/presentation/history_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../servers/presentation/servers_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const pages = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    ServersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.query_stats_rounded),
            label: 'Historial',
          ),
          NavigationDestination(
            icon: Icon(Icons.public_rounded),
            label: 'Servidores',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
