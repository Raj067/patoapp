import 'package:flutter/material.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/light_theme.dart';

class LanguageAccount extends StatefulWidget {
  const LanguageAccount({Key? key}) : super(key: key);

  @override
  State<LanguageAccount> createState() => _LanguageAccountState();
}

class _LanguageAccountState extends State<LanguageAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    // MaterialStateProperty<Color?>? backgroundColor,
                    backgroundColor: MaterialStateProperty.all(patowavePrimary),
                    elevation: MaterialStateProperty.all(0),
                    minimumSize: MaterialStateProperty.all(
                      const Size(45, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('English')),
              Container(height: 10),
              ElevatedButton(
                  style: ButtonStyle(
                    // MaterialStateProperty<Color?>? backgroundColor,
                    backgroundColor:
                        MaterialStateProperty.all(patowaveGreen200),
                    elevation: MaterialStateProperty.all(0),
                    minimumSize: MaterialStateProperty.all(
                      const Size(45, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Kiswahili')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  backgroundColor: MaterialStateProperty.all(patowavePrimary),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                },
                child: const Text('English')),
            Container(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  backgroundColor: MaterialStateProperty.all(patowaveGreen200),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                },
                child: const Text('Kiswahili')),
          ],
        ),
      ),
    );
  }
}
