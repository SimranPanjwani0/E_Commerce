import 'package:e_com_rev/headers.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        MyRoutes.homepage: (context) => const HomePage(),
        MyRoutes.detailpage : (context) => const DetailPage(),
        MyRoutes.cartpage : (context) => const CartPage(),
      },
    );
  }
}
