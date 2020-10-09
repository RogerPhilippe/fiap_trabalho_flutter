import 'package:http/http.dart' as http;

class RequestHttpService {

  static Future<http.Response> requestExchangesGet() async {

    // https://docs.awesomeapi.com.br/api-de-moedas
    return await _requestGet("https://economia.awesomeapi.com.br/all/USD-BRL,EUR-BRL,BTC-BRL");
  }

  static Future<http.Response> requestUFs() async {

    // https://servicodados.ibge.gov.br/api/docs/localidades#api-UFs-estadosGet
    return await _requestGet("https://servicodados.ibge.gov.br/api/v1/localidades/estados");
  }

  static Future<http.Response> searchAddressByCep(String cep) async {

    // https://viacep.com.br/ws/01001000/json/
    return await _requestGet("https://viacep.com.br/ws/$cep/json/");

}

  static Future<http.Response> requestCitiesByState(String uf) async {

    // https://servicodados.ibge.gov.br/api/v1/localidades/estados/{UF}/municipios
    return await _requestGet("https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios");
  }

  static Future<http.Response> searchCepByAddress(String uf, String city, String street) async {

    // https://viacep.com.br/ws/SP/Santo%20André/Cruzeiro%20do%20Sul/json/
    return await _requestGet("https://viacep.com.br/ws/$uf/$city/$street/json/");
  }

  static Future<http.Response> _requestGet(String url) async {

    return await http.get(url);
  }

}