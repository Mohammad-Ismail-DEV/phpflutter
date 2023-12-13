import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String baseUrl = 'disloyal-bowl.000webhostapp.com';

List<Product> _products = [];


class Product {
  final int _pid;
  final String _name;
  final int _quantity;
  final double _price;
  final String _category;

  Product(this._pid, this._name, this._quantity, this._price, this._category);

  @override
  String toString(){
    return 'PID: $_pid, Name: $_name\nQuantity: $_quantity, Price \$$_price\nCategory: $_category';
  }
}

void updateProducts(Function(bool success) update) async{
  try{
    var url = Uri.https(baseUrl, 'getProducts.php');
    var response = await http.get(url).timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      _products.clear();
      var data = convert.jsonDecode(response.body);
      for(var row in data){
        int pid = int.parse(row['pid']); 
        String name = row['name']; 
        int quantity = int.parse(row['name']); 
        double price = double.parse(row['name']); 
        String category = row['category']; 
        _products.add(Product(pid, name, quantity, price, category));
      }
    }
    else{
      update(false);
    }
  }
  catch(e){
    update(false);
  }
}