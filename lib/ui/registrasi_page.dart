import 'package:flutter/material.dart';
import 'package:responsi/bloc/registrasi_bloc.dart';
import 'package:responsi/widget/success_dialog.dart';
import 'package:responsi/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900], // Background warna biru gelap
      appBar: AppBar(
        title: const Text('Registrasi',
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Daftar Sekarang!',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Isi form di bawah untuk mendaftar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[200],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                _namaTextField(),
                const SizedBox(height: 20),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 20),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 60),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Nama dengan tema biru
  Widget _namaTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Warna teks
      decoration: InputDecoration(
        labelText: "Nama",
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
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Email dengan tema biru
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
        // Validasi email
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0 - 9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Password dengan tema biru
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
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Konfirmasi Password dengan tema biru
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Warna teks
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
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
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Registrasi dengan tema biru
  Widget _buttonRegistrasi() {
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
                  "Registrasi",
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
    RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context);
                },
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
              ));
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
