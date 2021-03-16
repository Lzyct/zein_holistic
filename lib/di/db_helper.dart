import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 2019-12-30 with ♥
/// (>’’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’’<)
///*********************************************
/// © 2019 | All Right Reserved
class DbHelper {
  Database? db;

  Future<Database?> get dataBase async {
    db = await initDb();
    return db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, Strings.dbName);

    logs("Path DB -> $path");
    sl<PrefManager>().setDbPath(path);
    var theDb = await databaseFactoryFfi.openDatabase(path);
    onCreate(theDb, 1);
    return theDb;
  }

  // Creating a table name Employee with fields
  void onCreate(Database db, int version) async {
    // When creating the db, create the table

    // Create table Patient
    await db.execute('''
    CREATE TABLE patient (
        id String PRIMARY KEY, 
        name TEXT,
        sex TEXT, 
        dateBirth TEXT, 
        address TEXT,
        phoneNumber TEXT,
        createAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updateAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');

    // Create table medicalRecord
    await db.execute('''
    CREATE TABLE medicalRecord (
        id INTEGER PRIMARY KEY,
        idPatient TEXT,
        mainComplaint TEXT,
        additionalComplaint TEXT, 
        historyOfDisease TEXT, 
        checkUpResult TEXT, 
        conclusionDiagnosis TEXT, 
        suggestion TEXT,  
        examiner TEXT,
        createAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updateAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');
    print("Created tables");
  }
}
