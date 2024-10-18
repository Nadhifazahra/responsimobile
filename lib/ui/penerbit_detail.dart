import 'package:flutter/material.dart';
import 'package:responsi/bloc/penerbit_bloc.dart';
import 'package:responsi/model/penerbit.dart';
import 'package:responsi/ui/penerbit_form.dart';
import 'package:responsi/ui/penerbit_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class PenerbitDetail extends StatefulWidget {
  final Penerbit? penerbit;

  PenerbitDetail({Key? key, this.penerbit}) : super(key: key);

  @override
  _PenerbitDetailState createState() => _PenerbitDetailState();
}

class _PenerbitDetailState extends State<PenerbitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900], // Warna background tema
      appBar: AppBar(
        title: const Text(
          'Detail Penerbit',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800], // Warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Memberi jarak di atas
            Card(
              color: Colors.blue[800], // Sesuaikan dengan tema
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8, // Tambahkan bayangan untuk efek kedalaman
              child: Container(
                width: MediaQuery.of(context).size.width *
                    1.0, // Lebar card 80% dari lebar layar
                padding: const EdgeInsets.all(20.0), // Padding di dalam card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Publisher Name:",
                      style: TextStyle(
                        color: Colors.blue[200], // Warna teks terang
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.penerbit!.publisher_name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0, // Memperbesar ukuran font
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Established Year:",
                      style: TextStyle(
                        color: Colors.blue[200],
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.penerbit!.established_year.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Country:",
                      style: TextStyle(
                        color: Colors.blue[200],
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.penerbit!.country!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30), // Memberi jarak di bawah card
            _tombolHapusEdit(), // Tombol di bawah card
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PenerbitForm(
                          penerbit: widget.penerbit!,
                        )));
          },
          icon: const Icon(Icons.edit),
          label: const Text("EDIT", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600], // Warna tombol edit
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        const SizedBox(width: 10),
        // Tombol Hapus
        ElevatedButton.icon(
          onPressed: () => confirmHapus(),
          icon: const Icon(Icons.delete),
          label: const Text("DELETE", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600], // Warna tombol hapus
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            PenerbitBloc.deletePenerbit(id: widget.penerbit!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PenerbitPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
