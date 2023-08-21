import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_2023/home/home_page.dart';
import 'package:todo_list_2023/widget/custom_switcher_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('User is currently signed out!');
      } else {
        // ignore: avoid_print
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo list',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: const [
          CustomSwitcher(),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Image.asset('assets/images/login_page_image.png'),
              ),
              TextField(
                controller: _emailController,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    prefixIcon: const Icon(Icons.person_rounded),
                    labelText: 'Email',
                    hintText: "Digite E-mail"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _senhaController,
                obscureText: _showPassword == false ? true : false,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.key),
                  labelText: 'Senha',
                  hintText: 'Digite Senha',
                  suffixIcon: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Icon(
                        _showPassword == false
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                    child: const Text(
                      "Recuperar Senha",
                    ),
                    onPressed: () {}),
              ),

              const SizedBox(height: 15),

              // TESTE
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Colors.purple,
                        Colors.deepPurple,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: SizedBox.expand(
                  child: TextButton(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "   Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () => {login()},
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                  height: 40,
                  child: TextButton(
                    child: const Text(
                      "Cadastre-se",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Cadastro()));
                    },
                  ))
              // TESTE
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário nao encontrado"),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sua senha está errada"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
