import 'package:flutter/material.dart';
import 'package:responsi1/bloc/login_bloc.dart';
import 'package:responsi1/helpers/user_info.dart';
import 'package:responsi1/ui/fasilitas_page.dart';
import 'package:responsi1/ui/registrasi_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';
import '../widget/success_dialog.dart';
import 'theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: brightYellowTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  _emailTextField(),
                  const SizedBox(height: 20),
                  _passwordTextField(),
                  const SizedBox(height: 30),
                  _buttonLogin(),
                  const SizedBox(height: 30),
                  _menuRegistrasi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.email, color: Colors.black54),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock, color: Colors.black54),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 18),
        ),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        // Pastikan bahwa value.token tidak null, jika null gunakan string kosong sebagai default
        await UserInfo().setToken(value.token ?? "");

        // Pastikan bahwa value.userID dapat diubah menjadi int
        await UserInfo().setUserID(int.tryParse(value.userID.toString()) ?? 0);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const ProdukPage(),
        //   ),
        // );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Login berhasil",
            okClick: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FasilitasPage(),
                ),
              );
            },
          ),
        );
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.yellow[800],
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
