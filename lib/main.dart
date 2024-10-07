import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controller/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import '/widgets/route.dart';
import 'firebase_options.dart';
import 'package:seo/seo.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(ChangeNotifierProvider(child: const MyApp(), create: (BuildContext context)=>Ecom()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: MaterialApp(
        title: "MINSSAPP VENTURES",
        routes: pages,
        initialRoute: Routes.dashboard,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
