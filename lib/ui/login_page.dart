import 'package:flutter/material.dart';
import 'package:responsi/bloc/login_bloc.dart';
import 'package:responsi/helpers/user_info.dart';
import 'package:responsi/ui/penerbit_page.dart';
import 'package:responsi/ui/registrasi_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

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
    return Scaffold(
      backgroundColor: Colors.blue[900], // Background warna biru gelap
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.blue[800], // Warna AppBar
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Lebih banyak padding
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Silakan login untuk melanjutkan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[200],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 60),
                _buttonLogin(),
                const SizedBox(height: 20),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox email dengan tema biru
  Widget _emailTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Warna teks
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.blue[300]), // Warna label teks
        filled: true,
        fillColor: Colors.blue[800], // Warna background field
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
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

  // Membuat Textbox password dengan tema biru
  Widget _passwordTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Warna teks
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.blue[300]), // Warna label teks
        filled: true,
        fillColor: Colors.blue[800], // Warna background field
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
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

  // Membuat Tombol Login dengan tema biru
  Widget _buttonLogin() {
    return Align(
      alignment: Alignment.center, // Mengatur tombol di tengah
      child: SizedBox(
        width: 200, // Lebar tombol diatur menjadi 200
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600], // Warna tombol
            padding: const EdgeInsets.symmetric(vertical: 16), // Padding tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Membulatkan tombol
            ),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16), // Ukuran font lebih kecil
                ),
          onPressed: () {
            var validate = _formKey.currentState!.validate();
            if (validate) {
              if (!_isLoading) _submit();
            }
          },
        ),
      ),
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
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PenerbitPage()));
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
  }

  // Membuat menu untuk membuka halaman registrasi dengan tema biru
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
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
