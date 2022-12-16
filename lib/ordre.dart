class Ordre {
  int? id;
  late String tipus;
  late int quantitat;


  static final Ordre _modelo = Ordre._internal();
  factory Ordre(){
    return _modelo;
  }
  Ordre._internal();

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipus': tipus,
      'quantitat': quantitat,
    };
  }

  // Convert a Map to a Dog Object
  Ordre.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tipus = map['tipus'];
    quantitat = map['quantitat'];
  }
  void setOrdre(String _tipus,int _quantitat){
    tipus = _tipus;
    quantitat = _quantitat;
  }

}