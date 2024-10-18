import 'package:flutter/material.dart';
import 'package:responsi/bloc/penerbit_bloc.dart';
import 'package:responsi/model/penerbit.dart';
import 'package:responsi/ui/penerbit_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class PenerbitForm extends StatefulWidget {
  Penerbit? penerbit;

  PenerbitForm({Key? key, this.penerbit}) : super(key: key);

  @override
  _PenerbitFormState createState() => _PenerbitFormState();
}

class _PenerbitFormState extends State<PenerbitForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Penerbit";
  String tombolSubmit = "SIMPAN";

  final _publisherNameTextboxController = TextEditingController();
  final _establishedYearTextboxController = TextEditingController();
  final _countryTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.penerbit != null) {
      setState(() {
        judul = "Ubah Penerbit";
        tombolSubmit = "UBAH";
        _publisherNameTextboxController.text = widget.penerbit!.publisher_name!;
        _establishedYearTextboxController.text =
            widget.penerbit!.established_year.toString();
        _countryTextboxController.text = widget.penerbit!.country!;
      });
    } else {
      judul = "Tambah Penerbit";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900], // Warna background biru
      appBar: AppBar(
        title: Text(judul,
            style: const TextStyle(
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
                _buildCardForm(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Card(
      color: Colors.blue[800], // Sesuaikan dengan tema
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8, // Tambahkan bayangan untuk efek kedalaman
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding di dalam card
        child: Column(
          children: [
            _publisherNameTextField(),
            const SizedBox(height: 20),
            _establishedYearTextField(),
            const SizedBox(height: 20),
            _countryTextField(),
          ],
        ),
      ),
    );
  }

  Widget _publisherNameTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Publisher Name",
        labelStyle: TextStyle(color: Colors.blue[300]),
        filled: true,
        fillColor: Colors.blue[700],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[600]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: _publisherNameTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Publisher Name harus diisi";
        }
        return null;
      },
    );
  }

  Widget _establishedYearTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Established Year",
        labelStyle: TextStyle(color: Colors.blue[300]),
        filled: true,
        fillColor: Colors.blue[700],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[600]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: _establishedYearTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Established Year harus diisi";
        }
        return null;
      },
    );
  }

  Widget _countryTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Country",
        labelStyle: TextStyle(color: Colors.blue[300]),
        filled: true,
        fillColor: Colors.blue[700],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[600]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: _countryTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Country harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  tombolSubmit,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
          onPressed: () {
            var validate = _formKey.currentState!.validate();
            if (validate) {
              if (!_isLoading) {
                if (widget.penerbit != null) {
                  ubah();
                } else {
                  simpan();
                }
              }
            }
          },
        ),
      ),
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Penerbit createPenerbit = Penerbit(id: null);
    createPenerbit.publisher_name = _publisherNameTextboxController.text;
    createPenerbit.established_year =
        int.tryParse(_establishedYearTextboxController.text) ?? 0;
    createPenerbit.country = _countryTextboxController.text;

    PenerbitBloc.addPenerbit(penerbit: createPenerbit).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PenerbitPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Penerbit updatePenerbit = Penerbit(id: widget.penerbit!.id!);
    updatePenerbit.publisher_name = _publisherNameTextboxController.text;
    updatePenerbit.established_year =
        int.tryParse(_establishedYearTextboxController.text) ?? 0;
    updatePenerbit.country = _countryTextboxController.text;

    PenerbitBloc.updatePenerbit(penerbit: updatePenerbit).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PenerbitPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permbaruan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
