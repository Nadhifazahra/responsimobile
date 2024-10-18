import 'dart:convert';
import 'package:responsi/helpers/api.dart';
import 'package:responsi/helpers/api_url.dart';
import 'package:responsi/model/penerbit.dart';

class PenerbitBloc {
  static Future<List<Penerbit>> getPenerbits() async {
    String apiUrl = ApiUrl.listPenerbit;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listPenerbit = (jsonObj as Map<String, dynamic>)['data'];
    List<Penerbit> penerbits = [];
    for (int i = 0; i < listPenerbit.length; i++) {
      penerbits.add(Penerbit.fromJson(listPenerbit[i]));
    }
    return penerbits;
  }

  static Future addPenerbit({Penerbit? penerbit}) async {
    String apiUrl = ApiUrl.createPenerbit;
    var body = {
      "publisher_name": penerbit!.publisher_name,
      "established_year": penerbit.established_year.toString(),
      "country": penerbit.country
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updatePenerbit({required Penerbit penerbit}) async {
    // String apiUrl = ApiUrl.updatePenerbit(int.parse(penerbit.id!));
    String apiUrl = ApiUrl.updatePenerbit(penerbit.id!); // id sebagai int
    print(apiUrl);
    var body = {
      "publisher_name": penerbit.publisher_name,
      "established_year": penerbit.established_year.toString(),
      "country": penerbit.country
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deletePenerbit({int? id}) async {
    String apiUrl = ApiUrl.deletePenerbit(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
