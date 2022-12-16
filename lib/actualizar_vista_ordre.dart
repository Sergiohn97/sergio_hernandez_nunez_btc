import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sergio_hernandez_nunez_btc/controlador.dart';
import 'package:sergio_hernandez_nunez_btc/ordre.dart';

class Actualizar extends StatefulWidget {
  final Ordre ordre;

  const Actualizar({Key? key, required this.ordre}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  late String tipus;
  late int quantitat;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualitzar Ordre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.ordre.tipus,
                  decoration: const InputDecoration(hintText: 'Concepte de la Ordre(compra/venta) i data'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Introdueix el concepte';
                    }

                    tipus = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.ordre.quantitat.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Quantitat de € en aquest Ordre'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Introdueix la quantitat';
                    }

                    quantitat = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {

                        var dbHelper = DatabaseHelper.instance;
                        dbHelper.actualizarOrdre(tipus, quantitat);

                      }
                    },
                    child: const Text('Actualitzar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
