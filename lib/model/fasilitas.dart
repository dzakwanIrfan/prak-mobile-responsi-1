class Fasilitas {
  int? id;
  String? facility;
  String? type;
  String? status;
  Fasilitas({this.id, this.facility, this.type, this.status});
  factory Fasilitas.fromJson(Map<String, dynamic> obj) {
    return Fasilitas(
        id: obj['id'],
        facility: obj['facility'],
        type: obj['type'],
        status: obj['status']);
  }
}
