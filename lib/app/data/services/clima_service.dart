import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tenis/app/data/models/clima_response.dart';

class ClimaService {
  final apiKey = 'https://ups_ochoa:W2Tx05JsxH@api.meteomatics.com';

  getClima(String fecha) async {
    final resp = await http.get(
      Uri.parse("$apiKey/${fecha}T00:00:00Z/t_2m:C/52.520551,13.461804/json"),
    );
    final dataRaw = compute(climaResponseFromJson, resp.body);
    //print( usuario);
    print(dataRaw);
    return dataRaw;
  }
}
