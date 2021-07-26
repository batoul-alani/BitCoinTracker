import 'package:http/http.dart'as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
//const apiKey = '561970B5-D8C0-44E4-B3D7-DEC9B8A5D730';
const apiKey='11F8EC33-C30F-4F93-AD27-B437E6BD69EA';
class CoinData {

   Future getCoinData(String selectCurrency)async{
     Map mapCrypt= {};
     for(String i in cryptoList){
       http.Response response=await http.get('$coinAPIURL/$i/$selectCurrency?apikey=$apiKey');
       if(response.statusCode==200){
         String data=response.body;
         print(response.statusCode);
         double coinDescription= jsonDecode(data)["rate"];
         print(coinDescription);
         mapCrypt[i]=coinDescription.toStringAsFixed(0);
       }
       else{ throw Exception('Failed to load'); }
      }
     return mapCrypt;
  }
}
