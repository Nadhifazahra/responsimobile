import 'package:flutter/material.dart';
import 'package:responsi/bloc/logout_bloc.dart';
import 'package:responsi/bloc/penerbit_bloc.dart';
import 'package:responsi/ui/login_page.dart';
import 'package:responsi/ui/penerbit_detail.dart';
import 'package:responsi/ui/penerbit_form.dart';

class PenerbitPage extends StatefulWidget {
  const PenerbitPage({Key? key}) : super(key: key);
  @override
  _PenerbitPageState createState() => _PenerbitPageState();
}

class _PenerbitPageState extends State<PenerbitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text(
          'List Penerbit',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PenerbitForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[800],
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[600],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ListTile(
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.logout, color: Colors.white),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: PenerbitBloc.getPenerbits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListPenerbit(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
        },
      ),
    );
  }
}

class ListPenerbit extends StatelessWidget {
  final List? list;
  const ListPenerbit({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DataTable(
              columnSpacing: 16.0,
              headingRowHeight: 60,
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    'Publisher Name',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Established Year',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: list!.map((penerbit) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        penerbit.publisher_name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PenerbitDetail(penerbit: penerbit),
                          ),
                        );
                      },
                    ),
                    DataCell(
                      Text(
                        penerbit.established_year.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        penerbit.country,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      MouseRegion(
                        onEnter: (event) => {},
                        onExit: (event) => {},
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PenerbitDetail(
                                  penerbit: penerbit,
                                ),
                              ),
                            );
                          },
                          splashRadius: 20,
                          tooltip: 'Lihat Detail',
                        ),
                      ),
                    ),
                  ],
                  color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blue[700];
                      }
                      return Colors.blue[800];
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
