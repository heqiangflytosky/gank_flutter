
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:gank_flutter/model/GankItemBean.dart';


class DateBaseHelper {
  static DateBaseHelper _dateBaseHelper;
  static Database _db;

  // 工厂模式
  factory DateBaseHelper() =>getInstance();

  static DateBaseHelper getInstance() {
    if (_dateBaseHelper == null) {
      _dateBaseHelper = new DateBaseHelper._internal();
    }
    return _dateBaseHelper;
  }

  DateBaseHelper._internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, TAB.DB_NAME);

    Database database = await openDatabase(path, version: TAB.DB_VERSION,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''CREATE TABLE ${TAB.TAB_FAVOURITE_NAME} (${TAB.COLUMN_ID} TEXT PRIMARY KEY, 
              ${TAB.COLUMN_CREATE_AT} TEXT, ${TAB.COLUMN_DESC} TEXT,${TAB.COLUMN_PUBLISH_AT} TEXT,
              ${TAB.COLUMN_SOURCE} TEXT,${TAB.COLUMN_TYPE} TEXT,${TAB.COLUMN_URL} TEXT,
              ${TAB.COLUMN_USED} BOOLEAN,${TAB.COLUMN_WHO} TEXT,${TAB.COLUMN_COLLECT_DATE} INTEGER)''');
          await db.execute(
              '''CREATE TABLE ${TAB.TAB_HISTORY_NAME} (${TAB.COLUMN_ID} TEXT PRIMARY KEY, 
              ${TAB.COLUMN_CREATE_AT} TEXT, ${TAB.COLUMN_DESC} TEXT,${TAB.COLUMN_PUBLISH_AT} TEXT,
              ${TAB.COLUMN_SOURCE} TEXT,${TAB.COLUMN_TYPE} TEXT,${TAB.COLUMN_URL} TEXT,
              ${TAB.COLUMN_USED} BOOLEAN,${TAB.COLUMN_WHO} TEXT,${TAB.COLUMN_READ_DATE} INTEGER)''');
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < 2) {

          }
          if (oldVersion < 3) {

          }

        });

    return database;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  Map<String, dynamic> _toFavouriteMap( GankItemBean bean){
    var map = new Map<String, dynamic>();

    map[TAB.COLUMN_ID] = bean.id;
    map[TAB.COLUMN_CREATE_AT] = bean.createdAt;
    map[TAB.COLUMN_DESC] = bean.desc;
    map[TAB.COLUMN_PUBLISH_AT] = bean.publishedAt;
    map[TAB.COLUMN_SOURCE] = bean.source;
    map[TAB.COLUMN_TYPE] = bean.type;
    map[TAB.COLUMN_URL] = bean.url;
    map[TAB.COLUMN_USED] = bean.used;
    map[TAB.COLUMN_WHO] = bean.who;

    map[TAB.COLUMN_COLLECT_DATE] = new DateTime.now().millisecondsSinceEpoch;

    return map;
  }


  Map<String, dynamic> _toHistoryMap( GankItemBean bean){
    var map = new Map<String, dynamic>();

    map[TAB.COLUMN_ID] = bean.id;
    map[TAB.COLUMN_CREATE_AT] = bean.createdAt;
    map[TAB.COLUMN_DESC] = bean.desc;
    map[TAB.COLUMN_PUBLISH_AT] = bean.publishedAt;
    map[TAB.COLUMN_SOURCE] = bean.source;
    map[TAB.COLUMN_TYPE] = bean.type;
    map[TAB.COLUMN_URL] = bean.url;
    map[TAB.COLUMN_USED] = bean.used;
    map[TAB.COLUMN_WHO] = bean.who;

    map[TAB.COLUMN_READ_DATE] = new DateTime.now().millisecondsSinceEpoch;

    return map;
  }

  GankItemBean toGankBean(Map map) {
    if (map == null) {
      return null;
    }

    GankItemBean bean = new GankItemBean(map[TAB.COLUMN_ID], map[TAB.COLUMN_CREATE_AT],
        map[TAB.COLUMN_DESC], map[TAB.COLUMN_PUBLISH_AT], map[TAB.COLUMN_SOURCE],
        map[TAB.COLUMN_TYPE], map[TAB.COLUMN_URL], map[TAB.COLUMN_USED] == 1, map[TAB.COLUMN_WHO]);
    return bean;

  }


  Future<bool> hasFavouriteEntry(GankItemBean bean) async{
    var dbClient = await db;
    List<Map> result = await dbClient.query(TAB.TAB_FAVOURITE_NAME,
      columns: [TAB.COLUMN_ID],
      where: "${TAB.COLUMN_ID}=? AND ${TAB.COLUMN_TYPE}=?",
      whereArgs: [bean.id,bean.type]
    );

    return result.length > 0;
  }


  Future<int> saveFavourite(GankItemBean bean) async{
    var dbClient = await db;
    return await dbClient.insert(TAB.TAB_FAVOURITE_NAME, _toFavouriteMap(bean), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addHistory(GankItemBean bean) async{
    var dbClient = await db;
    return await dbClient.insert(TAB.TAB_HISTORY_NAME, _toHistoryMap(bean), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> getHistoryCount() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(TAB.TAB_HISTORY_NAME,
        columns: [TAB.COLUMN_ID],
    );
    return result.length;
  }

  Future<int> getFavouriteCount() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(TAB.TAB_FAVOURITE_NAME,
      columns: [TAB.COLUMN_ID],
    );
    return result.length;
  }

  Future<List> getFavourites() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(TAB.TAB_FAVOURITE_NAME,orderBy:TAB.COLUMN_COLLECT_DATE+" DESC");

    return result;
  }

  Future<List> getHistories() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(TAB.TAB_HISTORY_NAME,orderBy:TAB.COLUMN_READ_DATE+" DESC");

    return result;
  }
}


class TAB {
  static const int DB_VERSION = 1;
  static const String DB_NAME = "gank.db";

  static const String TAB_FAVOURITE_NAME = "favourite";
  static const String TAB_HISTORY_NAME = "history";

  static const String COLUMN_ID = "_id";
  static const String COLUMN_CREATE_AT = "createdAt";
  static const String COLUMN_DESC = "desc";
  static const String COLUMN_PUBLISH_AT = "publishedAt";
  static const String COLUMN_SOURCE = "source";
  static const String COLUMN_TYPE = "type";
  static const String COLUMN_URL = "url";
  static const String COLUMN_USED = "used";
  static const String COLUMN_WHO = "who";

  static const String COLUMN_READ_DATE = "readDate";
  static const String COLUMN_COLLECT_DATE = "collectDate";

}
