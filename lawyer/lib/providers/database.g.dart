// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Case extends DataClass implements Insertable<Case> {
  final int id;
  final DateTime attachmentDate;
  final DateTime deadlineDate;
  final int deadline;
  final String businessNumber;
  final String internalNumber;
  final String client;
  final String description;
  final bool isArchived;
  Case(
      {required this.id,
      required this.attachmentDate,
      required this.deadlineDate,
      required this.deadline,
      required this.businessNumber,
      required this.internalNumber,
      required this.client,
      required this.description,
      required this.isArchived});
  factory Case.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Case(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      attachmentDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attachment_date'])!,
      deadlineDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline_date'])!,
      deadline: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline'])!,
      businessNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}business_number'])!,
      internalNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}internal_number'])!,
      client: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      isArchived: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_archived'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['attachment_date'] = Variable<DateTime>(attachmentDate);
    map['deadline_date'] = Variable<DateTime>(deadlineDate);
    map['deadline'] = Variable<int>(deadline);
    map['business_number'] = Variable<String>(businessNumber);
    map['internal_number'] = Variable<String>(internalNumber);
    map['client'] = Variable<String>(client);
    map['description'] = Variable<String>(description);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  CasesCompanion toCompanion(bool nullToAbsent) {
    return CasesCompanion(
      id: Value(id),
      attachmentDate: Value(attachmentDate),
      deadlineDate: Value(deadlineDate),
      deadline: Value(deadline),
      businessNumber: Value(businessNumber),
      internalNumber: Value(internalNumber),
      client: Value(client),
      description: Value(description),
      isArchived: Value(isArchived),
    );
  }

  factory Case.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Case(
      id: serializer.fromJson<int>(json['id']),
      attachmentDate: serializer.fromJson<DateTime>(json['attachmentDate']),
      deadlineDate: serializer.fromJson<DateTime>(json['deadlineDate']),
      deadline: serializer.fromJson<int>(json['deadline']),
      businessNumber: serializer.fromJson<String>(json['businessNumber']),
      internalNumber: serializer.fromJson<String>(json['internalNumber']),
      client: serializer.fromJson<String>(json['client']),
      description: serializer.fromJson<String>(json['description']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'attachmentDate': serializer.toJson<DateTime>(attachmentDate),
      'deadlineDate': serializer.toJson<DateTime>(deadlineDate),
      'deadline': serializer.toJson<int>(deadline),
      'businessNumber': serializer.toJson<String>(businessNumber),
      'internalNumber': serializer.toJson<String>(internalNumber),
      'client': serializer.toJson<String>(client),
      'description': serializer.toJson<String>(description),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Case copyWith(
          {int? id,
          DateTime? attachmentDate,
          DateTime? deadlineDate,
          int? deadline,
          String? businessNumber,
          String? internalNumber,
          String? client,
          String? description,
          bool? isArchived}) =>
      Case(
        id: id ?? this.id,
        attachmentDate: attachmentDate ?? this.attachmentDate,
        deadlineDate: deadlineDate ?? this.deadlineDate,
        deadline: deadline ?? this.deadline,
        businessNumber: businessNumber ?? this.businessNumber,
        internalNumber: internalNumber ?? this.internalNumber,
        client: client ?? this.client,
        description: description ?? this.description,
        isArchived: isArchived ?? this.isArchived,
      );
  @override
  String toString() {
    return (StringBuffer('Case(')
          ..write('id: $id, ')
          ..write('attachmentDate: $attachmentDate, ')
          ..write('deadlineDate: $deadlineDate, ')
          ..write('deadline: $deadline, ')
          ..write('businessNumber: $businessNumber, ')
          ..write('internalNumber: $internalNumber, ')
          ..write('client: $client, ')
          ..write('description: $description, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, attachmentDate, deadlineDate, deadline,
      businessNumber, internalNumber, client, description, isArchived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Case &&
          other.id == this.id &&
          other.attachmentDate == this.attachmentDate &&
          other.deadlineDate == this.deadlineDate &&
          other.deadline == this.deadline &&
          other.businessNumber == this.businessNumber &&
          other.internalNumber == this.internalNumber &&
          other.client == this.client &&
          other.description == this.description &&
          other.isArchived == this.isArchived);
}

class CasesCompanion extends UpdateCompanion<Case> {
  final Value<int> id;
  final Value<DateTime> attachmentDate;
  final Value<DateTime> deadlineDate;
  final Value<int> deadline;
  final Value<String> businessNumber;
  final Value<String> internalNumber;
  final Value<String> client;
  final Value<String> description;
  final Value<bool> isArchived;
  const CasesCompanion({
    this.id = const Value.absent(),
    this.attachmentDate = const Value.absent(),
    this.deadlineDate = const Value.absent(),
    this.deadline = const Value.absent(),
    this.businessNumber = const Value.absent(),
    this.internalNumber = const Value.absent(),
    this.client = const Value.absent(),
    this.description = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  CasesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime attachmentDate,
    required DateTime deadlineDate,
    required int deadline,
    required String businessNumber,
    required String internalNumber,
    required String client,
    required String description,
    this.isArchived = const Value.absent(),
  })  : attachmentDate = Value(attachmentDate),
        deadlineDate = Value(deadlineDate),
        deadline = Value(deadline),
        businessNumber = Value(businessNumber),
        internalNumber = Value(internalNumber),
        client = Value(client),
        description = Value(description);
  static Insertable<Case> custom({
    Expression<int>? id,
    Expression<DateTime>? attachmentDate,
    Expression<DateTime>? deadlineDate,
    Expression<int>? deadline,
    Expression<String>? businessNumber,
    Expression<String>? internalNumber,
    Expression<String>? client,
    Expression<String>? description,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (attachmentDate != null) 'attachment_date': attachmentDate,
      if (deadlineDate != null) 'deadline_date': deadlineDate,
      if (deadline != null) 'deadline': deadline,
      if (businessNumber != null) 'business_number': businessNumber,
      if (internalNumber != null) 'internal_number': internalNumber,
      if (client != null) 'client': client,
      if (description != null) 'description': description,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  CasesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? attachmentDate,
      Value<DateTime>? deadlineDate,
      Value<int>? deadline,
      Value<String>? businessNumber,
      Value<String>? internalNumber,
      Value<String>? client,
      Value<String>? description,
      Value<bool>? isArchived}) {
    return CasesCompanion(
      id: id ?? this.id,
      attachmentDate: attachmentDate ?? this.attachmentDate,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      deadline: deadline ?? this.deadline,
      businessNumber: businessNumber ?? this.businessNumber,
      internalNumber: internalNumber ?? this.internalNumber,
      client: client ?? this.client,
      description: description ?? this.description,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (attachmentDate.present) {
      map['attachment_date'] = Variable<DateTime>(attachmentDate.value);
    }
    if (deadlineDate.present) {
      map['deadline_date'] = Variable<DateTime>(deadlineDate.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<int>(deadline.value);
    }
    if (businessNumber.present) {
      map['business_number'] = Variable<String>(businessNumber.value);
    }
    if (internalNumber.present) {
      map['internal_number'] = Variable<String>(internalNumber.value);
    }
    if (client.present) {
      map['client'] = Variable<String>(client.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CasesCompanion(')
          ..write('id: $id, ')
          ..write('attachmentDate: $attachmentDate, ')
          ..write('deadlineDate: $deadlineDate, ')
          ..write('deadline: $deadline, ')
          ..write('businessNumber: $businessNumber, ')
          ..write('internalNumber: $internalNumber, ')
          ..write('client: $client, ')
          ..write('description: $description, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $CasesTable extends Cases with TableInfo<$CasesTable, Case> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CasesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _attachmentDateMeta =
      const VerificationMeta('attachmentDate');
  @override
  late final GeneratedColumn<DateTime?> attachmentDate =
      GeneratedColumn<DateTime?>('attachment_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _deadlineDateMeta =
      const VerificationMeta('deadlineDate');
  @override
  late final GeneratedColumn<DateTime?> deadlineDate =
      GeneratedColumn<DateTime?>('deadline_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<int?> deadline = GeneratedColumn<int?>(
      'deadline', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'CHECK (deadline >= 0) NOT NULL');
  final VerificationMeta _businessNumberMeta =
      const VerificationMeta('businessNumber');
  @override
  late final GeneratedColumn<String?> businessNumber = GeneratedColumn<String?>(
      'business_number', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _internalNumberMeta =
      const VerificationMeta('internalNumber');
  @override
  late final GeneratedColumn<String?> internalNumber = GeneratedColumn<String?>(
      'internal_number', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _clientMeta = const VerificationMeta('client');
  @override
  late final GeneratedColumn<String?> client = GeneratedColumn<String?>(
      'client', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _isArchivedMeta = const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool?> isArchived = GeneratedColumn<bool?>(
      'is_archived', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_archived IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        attachmentDate,
        deadlineDate,
        deadline,
        businessNumber,
        internalNumber,
        client,
        description,
        isArchived
      ];
  @override
  String get aliasedName => _alias ?? 'cases';
  @override
  String get actualTableName => 'cases';
  @override
  VerificationContext validateIntegrity(Insertable<Case> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('attachment_date')) {
      context.handle(
          _attachmentDateMeta,
          attachmentDate.isAcceptableOrUnknown(
              data['attachment_date']!, _attachmentDateMeta));
    } else if (isInserting) {
      context.missing(_attachmentDateMeta);
    }
    if (data.containsKey('deadline_date')) {
      context.handle(
          _deadlineDateMeta,
          deadlineDate.isAcceptableOrUnknown(
              data['deadline_date']!, _deadlineDateMeta));
    } else if (isInserting) {
      context.missing(_deadlineDateMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('business_number')) {
      context.handle(
          _businessNumberMeta,
          businessNumber.isAcceptableOrUnknown(
              data['business_number']!, _businessNumberMeta));
    } else if (isInserting) {
      context.missing(_businessNumberMeta);
    }
    if (data.containsKey('internal_number')) {
      context.handle(
          _internalNumberMeta,
          internalNumber.isAcceptableOrUnknown(
              data['internal_number']!, _internalNumberMeta));
    } else if (isInserting) {
      context.missing(_internalNumberMeta);
    }
    if (data.containsKey('client')) {
      context.handle(_clientMeta,
          client.isAcceptableOrUnknown(data['client']!, _clientMeta));
    } else if (isInserting) {
      context.missing(_clientMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Case map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Case.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CasesTable createAlias(String alias) {
    return $CasesTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CasesTable cases = $CasesTable(this);
  late final CaseDao caseDao = CaseDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cases];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$CaseDaoMixin on DatabaseAccessor<MyDatabase> {
  $CasesTable get cases => attachedDatabase.cases;
}
