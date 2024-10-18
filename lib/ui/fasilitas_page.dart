import 'package:flutter/material.dart';
import 'package:responsi1/bloc/logout_bloc.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/fasilitas_detail.dart';
import 'package:responsi1/ui/fasilitas_form.dart';
import 'theme.dart';

class FasilitasPage extends StatefulWidget {
  const FasilitasPage({Key? key}) : super(key: key);
  @override
  _FasilitasPageState createState() => _FasilitasPageState();
}

class _FasilitasPageState extends State<FasilitasPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: brightYellowTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Fasilitas'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.add, size: 26.0),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FasilitasForm()));
                },
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                ),
                child: Text(
                  'Menu Fasilitas Pariwisata',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Helvetica',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder<List>(
          future: FasilitasBloc.getFasilitas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListFasilitas(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    ),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FasilitasForm()));
          },
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.yellow[700],
        ),
      ),
    );
  }
}

class ListFasilitas extends StatelessWidget {
  final List? list;
  const ListFasilitas({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemFasilitas(
          fasilitas: list![i],
        );
      },
    );
  }
}

class ItemFasilitas extends StatelessWidget {
  final Fasilitas fasilitas;
  const ItemFasilitas({Key? key, required this.fasilitas}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(
          Icons.business,
          color: Colors.yellow[700],
        ),
        title: Text(
          fasilitas.facility!,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${fasilitas.type!} - ${fasilitas.status!}",
          style: TextStyle(fontFamily: 'Helvetica'),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow[700]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FasilitasDetail(fasilitas: fasilitas),
            ),
          );
        },
      ),
    );
  }
}
