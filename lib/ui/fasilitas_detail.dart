import 'package:flutter/material.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/fasilitas_form.dart';
import 'package:responsi1/ui/fasilitas_page.dart';
import 'package:responsi1/widget/success_dialog.dart';
import 'package:responsi1/widget/warning_dialog.dart';
import 'theme.dart';

class FasilitasDetail extends StatefulWidget {
  final Fasilitas fasilitas;
  const FasilitasDetail({Key? key, required this.fasilitas}) : super(key: key);
  @override
  _FasilitasDetailState createState() => _FasilitasDetailState();
}

class _FasilitasDetailState extends State<FasilitasDetail> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: brightYellowTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Fasilitas'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                        "Nama Fasilitas", widget.fasilitas.facility),
                    _buildDetailItem("Tipe Fasilitas", widget.fasilitas.type),
                    _buildDetailItem(
                        "Status Fasilitas", widget.fasilitas.status),
                    const SizedBox(height: 20),
                    _tombolHapusEdit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'N/A',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("EDIT"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FasilitasForm(
                    fasilitas: widget.fasilitas,
                  ),
                ),
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text("DELETE"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => confirmHapus(),
          ),
        ],
      ),
    );
  }

  void confirmHapus() {
    if (widget.fasilitas.id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "ID Fasilitas tidak ditemukan, tidak bisa menghapus.",
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.yellow[700],
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text("Hapus"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              _deleteFasilitas();
            },
          ),
        ],
      ),
    );
  }

  void _deleteFasilitas() async {
    bool success = await FasilitasBloc.deleteFasilitas(
      id: widget.fasilitas.id!,
    );
    if (success) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Fasilitas berhasil dihapus",
          okClick: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const FasilitasPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Hapus gagal, silahkan coba lagi",
        ),
      );
    }
  }
}
