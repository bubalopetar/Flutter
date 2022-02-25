import 'package:drift/drift.dart';

class Cases extends Table {
  static const textFieldsLenght = 50;
  static const descriptionLenght = 2500;

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get attachmentDate => dateTime()();
  DateTimeColumn get deadlineDate => dateTime()();
  IntColumn get deadline =>
      integer().customConstraint('CHECK (deadline >= 0) NOT NULL')();
  TextColumn get businessNumber => text().withLength(max: textFieldsLenght)();
  TextColumn get internalNumber => text().withLength(max: textFieldsLenght)();
  TextColumn get client => text().withLength(max: textFieldsLenght)();
  TextColumn get description => text().withLength(max: descriptionLenght)();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}
