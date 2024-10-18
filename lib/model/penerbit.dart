class Penerbit {
  int? id;
  String? publisher_name;
  int? established_year;
  String? country;
  Penerbit({this.id, this.publisher_name, this.established_year, this.country});
  factory Penerbit.fromJson(Map<String, dynamic> obj) {
    return Penerbit(
      id: int.tryParse(obj['id'].toString()) ?? 0,
      publisher_name: obj['publisher_name'],
      established_year: int.tryParse(obj['established_year'].toString()) ?? 0,
      country: obj['country'],
      // hargaPenerbit: obj['harga']);
      // country: int.tryParse(obj['country'].toString()) ?? 0,
    );
  }
}
