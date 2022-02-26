import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';
import '../models/cases.dart';
import 'package:sqflite/sqflite.dart';
part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.

    final dbFolder = await getDatabasesPath();

    final file = File(p.join(dbFolder, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Cases], daos: [CaseDao])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [Cases])
class CaseDao extends DatabaseAccessor<MyDatabase> with _$CaseDaoMixin {
  final MyDatabase db;
  CaseDao(this.db) : super(db);

  Future<List<Case>> get allCaseEntries => (select(cases)
        ..where((t) => t.isArchived.equals(false))
        ..orderBy([
          (item) => OrderingTerm(
              expression: item.deadlineDate, mode: OrderingMode.asc)
        ]))
      .get();

  Stream<List<Case>> get allCaseEntriesStream => (select(cases)
        ..where((t) => t.isArchived.equals(false))
        ..orderBy([
          (item) => OrderingTerm(
              expression: item.deadlineDate, mode: OrderingMode.asc)
        ]))
      .watch();
  Stream<List<Case>> get archivedEntries => (select(cases)
        ..where((t) => t.isArchived.equals(true))
        ..orderBy([
          (item) => OrderingTerm(
              expression: item.deadlineDate, mode: OrderingMode.asc)
        ]))
      .watch();

  Future toggleCaseArchive(Case caseItem) {
    return (update(cases)..where((t) => t.id.equals(caseItem.id))).write(
      CasesCompanion(
        isArchived: Value(!caseItem.isArchived),
      ),
    );
  }

  Future deleteCase(Insertable<Case> caseItem) =>
      delete(cases).delete(caseItem);

  Future insertCase(CasesCompanion caseItem) => into(cases).insert(caseItem);

  Future updateCase(Insertable<Case> caseItem) =>
      update(cases).replace(caseItem);
}
