import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/home.dart';
import 'package:qr_scanner/providers/index_provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qr_scanner/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IndexProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: Home.route,
        routes: getRoutes(),
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
