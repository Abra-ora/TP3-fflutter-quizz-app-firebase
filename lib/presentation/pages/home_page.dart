import 'package:flutter/material.dart';
import 'package:quizz_app_with_firebase_db/presentation/widgets/button_widget.dart';
import '../widgets/switch_widget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dark_mode, size: 60),
            const SwitchButton(),
            const SizedBox(height: 10),
            buttonWidget(
                  text: "Commencer le quizz",
                  textColor: Colors.white,
                  onPressed: () => {
                    Navigator.pushNamed(context, '/quizz')
                  }),
            
            const SizedBox(height: 10),
            buttonWidget(
                text: "Ajouter une question",
                textColor: Colors.white,
                onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        "/addQuestion",
                      )
                    }),
          ],
        ),
      ),
    );
  }
}
