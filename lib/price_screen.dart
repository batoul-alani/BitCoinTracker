import 'package:bitcoin_tracker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({this.selectCurrency,this.value,this.cryptoCurrency});
  final String selectCurrency;
  final String value;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='AUD';

  DropdownButton<String> getDropDownBuuton(){
    List<DropdownMenuItem<String>>dropdownItems=[];
    for(String i in currenciesList){
      String currency=i;
      var newItem=DropdownMenuItem(child: Text(currency), value: currency,);
      dropdownItems.add(newItem);}
    return DropdownButton<String> (
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value){
        setState(() {
          selectedCurrency=value;
          getData();
          print('SelectCurrency in drop down button is $selectedCurrency');});},
      );}

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems=[];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));}
    return CupertinoPicker(
      backgroundColor:Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);

        setState(() {
          print('get data from ios');
          selectedCurrency=currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map coinValue={};
  bool isWaiting=false;

  void getData() async{
    isWaiting=true;
    try{
      var data=await CoinData().getCoinData(selectedCurrency);
      isWaiting=false;
      setState(() {
        coinValue=data;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            CryptoCard(
              cryptoCurrency: 'BTC',
              value: isWaiting? '?':coinValue['BTC'],
              selectCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting? '?':coinValue['ETH'],
                selectCurrency: selectedCurrency,
                ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting? '?':coinValue['LTC'],
                selectCurrency: selectedCurrency,),
      ]
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //for test it in ios and android uncomment this command:
            //child: Platform.isIOS? iOSPicker():getDropDownBuuton(), //check platform is ios or android
            child: getDropDownBuuton(),
          ),

        ],
      ),
    );
  }
}