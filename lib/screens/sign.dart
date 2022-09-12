import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../provider/fav_provider.dart';
import '../widgets/home_screen.dart';

class Sign extends StatelessWidget {

  static const String routeNamed = 'Sign';

  const Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<FavPro>(
      builder: (ctx, val, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  SvgPicture.asset(
                    'assets/login.svg',
                    height: 250,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: const Icon(Icons.mail)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      labelText: 'Email',
                      fillColor: const Color(0xFF3A3F47),
                      hintText: 'ex_mail@exmail.com',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: const Icon(Icons.key)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      labelText: 'Password',
                      fillColor: const Color(0xFF3A3F47),
                      hintText: '***************',
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      val.login();
                      Navigator.of(context).pushReplacementNamed(HomeScreen.routeNamed);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
