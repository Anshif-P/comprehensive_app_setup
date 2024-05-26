import 'package:finfresh_machin_task/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'products.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            title TEXT,
            category TEXT,
            price REAL,
            image TEXT,
            localImagePath TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertProduct(ProductModel product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }
}
