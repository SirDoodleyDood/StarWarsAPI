import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SwapiProvider {
  final apiURL = 'https://swapi.dev/api';

  Future<LinkedHashMap<String, dynamic>?> getData({String? tipo, int? pagina}) async {
    if (pagina == null) {
      pagina = 1;
    }
    Uri url = Uri.parse('$apiURL/$tipo/?page=$pagina');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return null;
    }
  }

  Future<LinkedHashMap<String, dynamic>?> getDataUrl(String url) async {
    url = url.replaceAll('http', 'https');
    var uri = Uri.parse(url);
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return null;
    }
  }
}
