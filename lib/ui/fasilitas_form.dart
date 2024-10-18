import 'package:flutter/material.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/fasilitas_page.dart';
import 'package:responsi1/widget/success_dialog.dart';
import 'package:responsi1/widget/warning_dialog.dart';
import 'theme.dart'; // Import the theme file

class FasilitasForm extends StatefulWidget {
  Fasilitas? fasilitas;
  FasilitasForm({Key? key, this.fasilitas}) : super(key: key);
  @override
  _FasilitasFormState createState() => _FasilitasFormState();
}

class _FasilitasFormState extends State<FasilitasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH FASILITAS";
  String tombolSubmit = "SIMPAN";
  final _facilityTextboxController = TextEditingController();
  final _typeTextboxController = TextEditingController();
  final _statusTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.fasilitas != null) {
      setState(() {
        judul = "UBAH FASILITAS";
        tombolSubmit = "UBAH";
        _facilityTextboxController.text = widget.fasilitas!.facility!;
        _typeTextboxController.text = widget.fasilitas!.type!;
        _statusTextboxController.text = widget.fasilitas!.status!;
      });
    } else {
      judul = "TAMBAH FASILITAS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: brightYellowTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(judul),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _facilityTextField(),
                  const SizedBox(height: 16),
                  _typeTextField(),
                  const SizedBox(height: 16),
                  _statusTextField(),
                  const SizedBox(height: 24),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _facilityTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Fasilitas",
        filled: true,
        fillColor: Colors.yellow[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _facilityTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama fasilitas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _typeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tipe Fasilitas",
        filled: true,
        fillColor: Colors.yellow[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _typeTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tipe fasilitas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _statusTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Status Fasilitas",
        filled: true,
        fillColor: Colors.yellow[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.yellow[700]!, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _statusTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Status fasilitas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        tombolSubmit,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.fasilitas != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Fasilitas createFasilitas = Fasilitas(id: null);
    createFasilitas.facility = _facilityTextboxController.text;
    createFasilitas.type = _typeTextboxController.text;
    createFasilitas.status = _statusTextboxController.text;
    FasilitasBloc.addFasilitas(fasilitas: createFasilitas).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Fasilitas berhasil ditambah",
          okClick: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const FasilitasPage(),
              ),
            );
          },
        ),
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const FasilitasPage(),
      //   ),
      // );
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

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Fasilitas updateFasilitas = Fasilitas(id: widget.fasilitas!.id!);
    updateFasilitas.facility = _facilityTextboxController.text;
    updateFasilitas.type = _typeTextboxController.text;
    updateFasilitas.status = _statusTextboxController.text;
    FasilitasBloc.updateFasilitas(fasilitas: updateFasilitas).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Fasilitas berhasil diubah",
          okClick: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const FasilitasPage(),
              ),
            );
          },
        ),
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const FasilitasPage(),
      //   ),
      // );
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
