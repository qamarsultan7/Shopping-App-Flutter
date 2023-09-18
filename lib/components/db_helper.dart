import 'package:app_sql/components/cart_Model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Dbhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER,productColor  TEXT , image TEXT )');
  }

  Future<CartModel> insert(CartModel cart) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<CartModel>> getcartlist() async {
    try {
      var dbClient = await db;
      final List<Map<String, Object?>> queryResult =
          await dbClient!.query('cart');
      return queryResult.map((e) => CartModel.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }

  Future<int> updatequantity(CartModel cartModel) async {
    var dbClient = await db;
    return await dbClient!.update('cart', cartModel.toMap(),
        where: 'id=?', whereArgs: [cartModel.id]);
  }
  Future<int>deleteDate(int id)async{
    var dbClient=await db;
    return await dbClient!.delete('cart',where: 'id=?',whereArgs: [id]);
  }
}
