import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/lead_list_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/lead_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LeadProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).mode;
    return MaterialApp(
      title: 'Mini Lead Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.indigo),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.indigo),
      themeMode: themeMode,
      home: const LeadListScreen(),
    );
  }
}
