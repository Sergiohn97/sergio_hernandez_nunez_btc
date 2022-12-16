import 'package:sergio_hernandez_nunez_btc/controlador.dart';
import 'package:sergio_hernandez_nunez_btc/actualizar_vista_ordre.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sergio_hernandez_nunez_btc/ordre.dart';
import 'package:pie_chart/pie_chart.dart';
class ListaOrdre extends StatefulWidget {
  const ListaOrdre({Key? key}) : super(key: key);

  @override
  State<ListaOrdre> createState() => _ListaOrdreState();

}

class _ListaOrdreState extends State<ListaOrdre> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llista de Ordres'),
      ),
      body: FutureBuilder<List<Ordre>>(
        future: DatabaseHelper.instance.getAllOrdres(),
        builder: (BuildContext context, AsyncSnapshot<List<Ordre>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No hi han ordres a la base de dades'));
            } else {
              List<Ordre> ordres = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: ordres.length,
                    itemBuilder: (context, index) {
                      Ordre ordre = ordres[index];
                      return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ordre.tipus,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Quantitat: ${ordre.quantitat}')
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            var result =
                                            await Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return Actualizar(ordre: ordre);
                                                }));

                                            if (result == 'done') {
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirmació'),
                                                    content: const Text(
                                                        'Estas segur de que vols borrar? ?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child:
                                                          const Text('No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                context)
                                                                .pop();

                                                            // delete dog

                                                            int result =
                                                            await DatabaseHelper
                                                                .instance
                                                                .deleteOrdre(
                                                                ordre.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                  msg:
                                                                  'Ordre eliminada');
                                                              setState(() {});
                                                              // build function will be called
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Si')),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.delete)),



                                    ],
                                  )
                                ],
                              )));
                    }),
              );
            }
          }
        },

      ),
    );
  }

}
