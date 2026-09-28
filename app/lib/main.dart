import 'package:flutter/material.dart';

import 'core/theme/netqira_theme.dart';
import 'features/shell/presentation/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NetqiraApp());
}

class NetqiraApp extends StatelessWidget {
  const NetqiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NETQIRA',
      debugShowCheckedModeBanner: false,
      theme: NetqiraTheme.light,
      darkTheme: NetqiraTheme.dark,
      themeMode: ThemeMode.system,
      home: const MainShell(),
    );
  }
}
