import 'package:sergio_hernandez_nunez_btc/controlador.dart';
import 'package:sergio_hernandez_nunez_btc/ordre.dart';
import 'package:sergio_hernandez_nunez_btc/listaOrdre_vista.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddOrdre extends StatefulWidget {
  const AddOrdre({Key? key}) : super(key: key);

  @override
  State<AddOrdre> createState() => _AddOrdreState();
}

class _AddOrdreState extends State<AddOrdre> {

  late String tipus;
  late int quantitat;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afegir Ordre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Introdueix el tipus de ordre(compra/venta) i data '
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Siusplau introdueix el tipus i data';
                    }

                    tipus = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Quantitat € per aquesta ordre'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Siusplau la quantitat de €';
                    }

                    quantitat = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                ElevatedButton(onPressed: () async {

                  if( formKey.currentState!.validate()){

                    var dbHelper =  DatabaseHelper.instance;
                    // int result = await dbHelper.insertDog(dog);
                    dbHelper.setOrdre(tipus, quantitat);
                    // if( result > 0 ){
                    //   Fluttertoast.showToast(msg: 'Dog Saved');
                    // }
                  }


                }, child: const Text('Guarda')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ListaOrdre();
                  }));
                }, child: const Text('Mostra tot')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
