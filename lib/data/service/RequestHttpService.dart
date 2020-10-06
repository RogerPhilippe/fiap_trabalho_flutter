import 'package:http/http.dart' as http;

class RequestHttpService {

  static Future<http.Response> requestExchangesGet() async {

    // https://docs.awesomeapi.com.br/api-de-moedas
    return await _requestGet("https://economia.awesomeapi.com.br/all/USD-BRL,EUR-BRL,BTC-BRL");
  }

  static Future<http.Response> _requestGet(String url) async {

    return await http.get(url);
  }

}