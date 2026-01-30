// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchKeywordsMeta = const VerificationMeta(
    'searchKeywords',
  );
  @override
  late final GeneratedColumn<String> searchKeywords = GeneratedColumn<String>(
    'search_keywords',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
    'term',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _editionYearMeta = const VerificationMeta(
    'editionYear',
  );
  @override
  late final GeneratedColumn<int> editionYear = GeneratedColumn<int>(
    'edition_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sellPriceMeta = const VerificationMeta(
    'sellPrice',
  );
  @override
  late final GeneratedColumn<double> sellPrice = GeneratedColumn<double>(
    'sell_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<int> currentStock = GeneratedColumn<int>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLimitMeta = const VerificationMeta(
    'minLimit',
  );
  @override
  late final GeneratedColumn<int> minLimit = GeneratedColumn<int>(
    'min_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnDeadlineMeta = const VerificationMeta(
    'returnDeadline',
  );
  @override
  late final GeneratedColumn<DateTime> returnDeadline =
      GeneratedColumn<DateTime>(
        'return_deadline',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _shelfLifeStatusMeta = const VerificationMeta(
    'shelfLifeStatus',
  );
  @override
  late final GeneratedColumn<String> shelfLifeStatus = GeneratedColumn<String>(
    'shelf_life_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalSoldQtyMeta = const VerificationMeta(
    'totalSoldQty',
  );
  @override
  late final GeneratedColumn<int> totalSoldQty = GeneratedColumn<int>(
    'total_sold_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reservedQuantityMeta = const VerificationMeta(
    'reservedQuantity',
  );
  @override
  late final GeneratedColumn<int> reservedQuantity = GeneratedColumn<int>(
    'reserved_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSaleDateMeta = const VerificationMeta(
    'lastSaleDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastSaleDate = GeneratedColumn<DateTime>(
    'last_sale_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSupplyDateMeta = const VerificationMeta(
    'lastSupplyDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastSupplyDate =
      GeneratedColumn<DateTime>(
        'last_supply_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    name,
    searchKeywords,
    stage,
    grade,
    term,
    subject,
    publisher,
    editionYear,
    sellPrice,
    costPrice,
    currentStock,
    minLimit,
    returnDeadline,
    shelfLifeStatus,
    totalSoldQty,
    reservedQuantity,
    lastSaleDate,
    lastSupplyDate,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('search_keywords')) {
      context.handle(
        _searchKeywordsMeta,
        searchKeywords.isAcceptableOrUnknown(
          data['search_keywords']!,
          _searchKeywordsMeta,
        ),
      );
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('edition_year')) {
      context.handle(
        _editionYearMeta,
        editionYear.isAcceptableOrUnknown(
          data['edition_year']!,
          _editionYearMeta,
        ),
      );
    }
    if (data.containsKey('sell_price')) {
      context.handle(
        _sellPriceMeta,
        sellPrice.isAcceptableOrUnknown(data['sell_price']!, _sellPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_sellPriceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_costPriceMeta);
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentStockMeta);
    }
    if (data.containsKey('min_limit')) {
      context.handle(
        _minLimitMeta,
        minLimit.isAcceptableOrUnknown(data['min_limit']!, _minLimitMeta),
      );
    } else if (isInserting) {
      context.missing(_minLimitMeta);
    }
    if (data.containsKey('return_deadline')) {
      context.handle(
        _returnDeadlineMeta,
        returnDeadline.isAcceptableOrUnknown(
          data['return_deadline']!,
          _returnDeadlineMeta,
        ),
      );
    }
    if (data.containsKey('shelf_life_status')) {
      context.handle(
        _shelfLifeStatusMeta,
        shelfLifeStatus.isAcceptableOrUnknown(
          data['shelf_life_status']!,
          _shelfLifeStatusMeta,
        ),
      );
    }
    if (data.containsKey('total_sold_qty')) {
      context.handle(
        _totalSoldQtyMeta,
        totalSoldQty.isAcceptableOrUnknown(
          data['total_sold_qty']!,
          _totalSoldQtyMeta,
        ),
      );
    }
    if (data.containsKey('reserved_quantity')) {
      context.handle(
        _reservedQuantityMeta,
        reservedQuantity.isAcceptableOrUnknown(
          data['reserved_quantity']!,
          _reservedQuantityMeta,
        ),
      );
    }
    if (data.containsKey('last_sale_date')) {
      context.handle(
        _lastSaleDateMeta,
        lastSaleDate.isAcceptableOrUnknown(
          data['last_sale_date']!,
          _lastSaleDateMeta,
        ),
      );
    }
    if (data.containsKey('last_supply_date')) {
      context.handle(
        _lastSupplyDateMeta,
        lastSupplyDate.isAcceptableOrUnknown(
          data['last_supply_date']!,
          _lastSupplyDateMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      searchKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_keywords'],
      ),
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      ),
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      ),
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      editionYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edition_year'],
      ),
      sellPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sell_price'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_stock'],
      )!,
      minLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_limit'],
      )!,
      returnDeadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_deadline'],
      ),
      shelfLifeStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shelf_life_status'],
      ),
      totalSoldQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_sold_qty'],
      )!,
      reservedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reserved_quantity'],
      )!,
      lastSaleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sale_date'],
      ),
      lastSupplyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_supply_date'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final String id;
  final String? libraryId;
  final String name;
  final String? searchKeywords;
  final String? stage;
  final String? grade;
  final String? term;
  final String? subject;
  final String? publisher;
  final int? editionYear;
  final double sellPrice;
  final double costPrice;
  final int currentStock;
  final int minLimit;
  final DateTime? returnDeadline;
  final String? shelfLifeStatus;
  final int totalSoldQty;
  final int reservedQuantity;
  final DateTime? lastSaleDate;
  final DateTime? lastSupplyDate;
  final bool isSynced;
  const Book({
    required this.id,
    this.libraryId,
    required this.name,
    this.searchKeywords,
    this.stage,
    this.grade,
    this.term,
    this.subject,
    this.publisher,
    this.editionYear,
    required this.sellPrice,
    required this.costPrice,
    required this.currentStock,
    required this.minLimit,
    this.returnDeadline,
    this.shelfLifeStatus,
    required this.totalSoldQty,
    required this.reservedQuantity,
    this.lastSaleDate,
    this.lastSupplyDate,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || searchKeywords != null) {
      map['search_keywords'] = Variable<String>(searchKeywords);
    }
    if (!nullToAbsent || stage != null) {
      map['stage'] = Variable<String>(stage);
    }
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || term != null) {
      map['term'] = Variable<String>(term);
    }
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || editionYear != null) {
      map['edition_year'] = Variable<int>(editionYear);
    }
    map['sell_price'] = Variable<double>(sellPrice);
    map['cost_price'] = Variable<double>(costPrice);
    map['current_stock'] = Variable<int>(currentStock);
    map['min_limit'] = Variable<int>(minLimit);
    if (!nullToAbsent || returnDeadline != null) {
      map['return_deadline'] = Variable<DateTime>(returnDeadline);
    }
    if (!nullToAbsent || shelfLifeStatus != null) {
      map['shelf_life_status'] = Variable<String>(shelfLifeStatus);
    }
    map['total_sold_qty'] = Variable<int>(totalSoldQty);
    map['reserved_quantity'] = Variable<int>(reservedQuantity);
    if (!nullToAbsent || lastSaleDate != null) {
      map['last_sale_date'] = Variable<DateTime>(lastSaleDate);
    }
    if (!nullToAbsent || lastSupplyDate != null) {
      map['last_supply_date'] = Variable<DateTime>(lastSupplyDate);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      name: Value(name),
      searchKeywords: searchKeywords == null && nullToAbsent
          ? const Value.absent()
          : Value(searchKeywords),
      stage: stage == null && nullToAbsent
          ? const Value.absent()
          : Value(stage),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      term: term == null && nullToAbsent ? const Value.absent() : Value(term),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      editionYear: editionYear == null && nullToAbsent
          ? const Value.absent()
          : Value(editionYear),
      sellPrice: Value(sellPrice),
      costPrice: Value(costPrice),
      currentStock: Value(currentStock),
      minLimit: Value(minLimit),
      returnDeadline: returnDeadline == null && nullToAbsent
          ? const Value.absent()
          : Value(returnDeadline),
      shelfLifeStatus: shelfLifeStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(shelfLifeStatus),
      totalSoldQty: Value(totalSoldQty),
      reservedQuantity: Value(reservedQuantity),
      lastSaleDate: lastSaleDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSaleDate),
      lastSupplyDate: lastSupplyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSupplyDate),
      isSynced: Value(isSynced),
    );
  }

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      name: serializer.fromJson<String>(json['name']),
      searchKeywords: serializer.fromJson<String?>(json['searchKeywords']),
      stage: serializer.fromJson<String?>(json['stage']),
      grade: serializer.fromJson<String?>(json['grade']),
      term: serializer.fromJson<String?>(json['term']),
      subject: serializer.fromJson<String?>(json['subject']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      editionYear: serializer.fromJson<int?>(json['editionYear']),
      sellPrice: serializer.fromJson<double>(json['sellPrice']),
      costPrice: serializer.fromJson<double>(json['costPrice']),
      currentStock: serializer.fromJson<int>(json['currentStock']),
      minLimit: serializer.fromJson<int>(json['minLimit']),
      returnDeadline: serializer.fromJson<DateTime?>(json['returnDeadline']),
      shelfLifeStatus: serializer.fromJson<String?>(json['shelfLifeStatus']),
      totalSoldQty: serializer.fromJson<int>(json['totalSoldQty']),
      reservedQuantity: serializer.fromJson<int>(json['reservedQuantity']),
      lastSaleDate: serializer.fromJson<DateTime?>(json['lastSaleDate']),
      lastSupplyDate: serializer.fromJson<DateTime?>(json['lastSupplyDate']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'name': serializer.toJson<String>(name),
      'searchKeywords': serializer.toJson<String?>(searchKeywords),
      'stage': serializer.toJson<String?>(stage),
      'grade': serializer.toJson<String?>(grade),
      'term': serializer.toJson<String?>(term),
      'subject': serializer.toJson<String?>(subject),
      'publisher': serializer.toJson<String?>(publisher),
      'editionYear': serializer.toJson<int?>(editionYear),
      'sellPrice': serializer.toJson<double>(sellPrice),
      'costPrice': serializer.toJson<double>(costPrice),
      'currentStock': serializer.toJson<int>(currentStock),
      'minLimit': serializer.toJson<int>(minLimit),
      'returnDeadline': serializer.toJson<DateTime?>(returnDeadline),
      'shelfLifeStatus': serializer.toJson<String?>(shelfLifeStatus),
      'totalSoldQty': serializer.toJson<int>(totalSoldQty),
      'reservedQuantity': serializer.toJson<int>(reservedQuantity),
      'lastSaleDate': serializer.toJson<DateTime?>(lastSaleDate),
      'lastSupplyDate': serializer.toJson<DateTime?>(lastSupplyDate),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Book copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? name,
    Value<String?> searchKeywords = const Value.absent(),
    Value<String?> stage = const Value.absent(),
    Value<String?> grade = const Value.absent(),
    Value<String?> term = const Value.absent(),
    Value<String?> subject = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<int?> editionYear = const Value.absent(),
    double? sellPrice,
    double? costPrice,
    int? currentStock,
    int? minLimit,
    Value<DateTime?> returnDeadline = const Value.absent(),
    Value<String?> shelfLifeStatus = const Value.absent(),
    int? totalSoldQty,
    int? reservedQuantity,
    Value<DateTime?> lastSaleDate = const Value.absent(),
    Value<DateTime?> lastSupplyDate = const Value.absent(),
    bool? isSynced,
  }) => Book(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    name: name ?? this.name,
    searchKeywords: searchKeywords.present
        ? searchKeywords.value
        : this.searchKeywords,
    stage: stage.present ? stage.value : this.stage,
    grade: grade.present ? grade.value : this.grade,
    term: term.present ? term.value : this.term,
    subject: subject.present ? subject.value : this.subject,
    publisher: publisher.present ? publisher.value : this.publisher,
    editionYear: editionYear.present ? editionYear.value : this.editionYear,
    sellPrice: sellPrice ?? this.sellPrice,
    costPrice: costPrice ?? this.costPrice,
    currentStock: currentStock ?? this.currentStock,
    minLimit: minLimit ?? this.minLimit,
    returnDeadline: returnDeadline.present
        ? returnDeadline.value
        : this.returnDeadline,
    shelfLifeStatus: shelfLifeStatus.present
        ? shelfLifeStatus.value
        : this.shelfLifeStatus,
    totalSoldQty: totalSoldQty ?? this.totalSoldQty,
    reservedQuantity: reservedQuantity ?? this.reservedQuantity,
    lastSaleDate: lastSaleDate.present ? lastSaleDate.value : this.lastSaleDate,
    lastSupplyDate: lastSupplyDate.present
        ? lastSupplyDate.value
        : this.lastSupplyDate,
    isSynced: isSynced ?? this.isSynced,
  );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      name: data.name.present ? data.name.value : this.name,
      searchKeywords: data.searchKeywords.present
          ? data.searchKeywords.value
          : this.searchKeywords,
      stage: data.stage.present ? data.stage.value : this.stage,
      grade: data.grade.present ? data.grade.value : this.grade,
      term: data.term.present ? data.term.value : this.term,
      subject: data.subject.present ? data.subject.value : this.subject,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      editionYear: data.editionYear.present
          ? data.editionYear.value
          : this.editionYear,
      sellPrice: data.sellPrice.present ? data.sellPrice.value : this.sellPrice,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      minLimit: data.minLimit.present ? data.minLimit.value : this.minLimit,
      returnDeadline: data.returnDeadline.present
          ? data.returnDeadline.value
          : this.returnDeadline,
      shelfLifeStatus: data.shelfLifeStatus.present
          ? data.shelfLifeStatus.value
          : this.shelfLifeStatus,
      totalSoldQty: data.totalSoldQty.present
          ? data.totalSoldQty.value
          : this.totalSoldQty,
      reservedQuantity: data.reservedQuantity.present
          ? data.reservedQuantity.value
          : this.reservedQuantity,
      lastSaleDate: data.lastSaleDate.present
          ? data.lastSaleDate.value
          : this.lastSaleDate,
      lastSupplyDate: data.lastSupplyDate.present
          ? data.lastSupplyDate.value
          : this.lastSupplyDate,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('searchKeywords: $searchKeywords, ')
          ..write('stage: $stage, ')
          ..write('grade: $grade, ')
          ..write('term: $term, ')
          ..write('subject: $subject, ')
          ..write('publisher: $publisher, ')
          ..write('editionYear: $editionYear, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('currentStock: $currentStock, ')
          ..write('minLimit: $minLimit, ')
          ..write('returnDeadline: $returnDeadline, ')
          ..write('shelfLifeStatus: $shelfLifeStatus, ')
          ..write('totalSoldQty: $totalSoldQty, ')
          ..write('reservedQuantity: $reservedQuantity, ')
          ..write('lastSaleDate: $lastSaleDate, ')
          ..write('lastSupplyDate: $lastSupplyDate, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    libraryId,
    name,
    searchKeywords,
    stage,
    grade,
    term,
    subject,
    publisher,
    editionYear,
    sellPrice,
    costPrice,
    currentStock,
    minLimit,
    returnDeadline,
    shelfLifeStatus,
    totalSoldQty,
    reservedQuantity,
    lastSaleDate,
    lastSupplyDate,
    isSynced,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.name == this.name &&
          other.searchKeywords == this.searchKeywords &&
          other.stage == this.stage &&
          other.grade == this.grade &&
          other.term == this.term &&
          other.subject == this.subject &&
          other.publisher == this.publisher &&
          other.editionYear == this.editionYear &&
          other.sellPrice == this.sellPrice &&
          other.costPrice == this.costPrice &&
          other.currentStock == this.currentStock &&
          other.minLimit == this.minLimit &&
          other.returnDeadline == this.returnDeadline &&
          other.shelfLifeStatus == this.shelfLifeStatus &&
          other.totalSoldQty == this.totalSoldQty &&
          other.reservedQuantity == this.reservedQuantity &&
          other.lastSaleDate == this.lastSaleDate &&
          other.lastSupplyDate == this.lastSupplyDate &&
          other.isSynced == this.isSynced);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> name;
  final Value<String?> searchKeywords;
  final Value<String?> stage;
  final Value<String?> grade;
  final Value<String?> term;
  final Value<String?> subject;
  final Value<String?> publisher;
  final Value<int?> editionYear;
  final Value<double> sellPrice;
  final Value<double> costPrice;
  final Value<int> currentStock;
  final Value<int> minLimit;
  final Value<DateTime?> returnDeadline;
  final Value<String?> shelfLifeStatus;
  final Value<int> totalSoldQty;
  final Value<int> reservedQuantity;
  final Value<DateTime?> lastSaleDate;
  final Value<DateTime?> lastSupplyDate;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.name = const Value.absent(),
    this.searchKeywords = const Value.absent(),
    this.stage = const Value.absent(),
    this.grade = const Value.absent(),
    this.term = const Value.absent(),
    this.subject = const Value.absent(),
    this.publisher = const Value.absent(),
    this.editionYear = const Value.absent(),
    this.sellPrice = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.minLimit = const Value.absent(),
    this.returnDeadline = const Value.absent(),
    this.shelfLifeStatus = const Value.absent(),
    this.totalSoldQty = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.lastSaleDate = const Value.absent(),
    this.lastSupplyDate = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String name,
    this.searchKeywords = const Value.absent(),
    this.stage = const Value.absent(),
    this.grade = const Value.absent(),
    this.term = const Value.absent(),
    this.subject = const Value.absent(),
    this.publisher = const Value.absent(),
    this.editionYear = const Value.absent(),
    required double sellPrice,
    required double costPrice,
    required int currentStock,
    required int minLimit,
    this.returnDeadline = const Value.absent(),
    this.shelfLifeStatus = const Value.absent(),
    this.totalSoldQty = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.lastSaleDate = const Value.absent(),
    this.lastSupplyDate = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       sellPrice = Value(sellPrice),
       costPrice = Value(costPrice),
       currentStock = Value(currentStock),
       minLimit = Value(minLimit);
  static Insertable<Book> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? name,
    Expression<String>? searchKeywords,
    Expression<String>? stage,
    Expression<String>? grade,
    Expression<String>? term,
    Expression<String>? subject,
    Expression<String>? publisher,
    Expression<int>? editionYear,
    Expression<double>? sellPrice,
    Expression<double>? costPrice,
    Expression<int>? currentStock,
    Expression<int>? minLimit,
    Expression<DateTime>? returnDeadline,
    Expression<String>? shelfLifeStatus,
    Expression<int>? totalSoldQty,
    Expression<int>? reservedQuantity,
    Expression<DateTime>? lastSaleDate,
    Expression<DateTime>? lastSupplyDate,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (name != null) 'name': name,
      if (searchKeywords != null) 'search_keywords': searchKeywords,
      if (stage != null) 'stage': stage,
      if (grade != null) 'grade': grade,
      if (term != null) 'term': term,
      if (subject != null) 'subject': subject,
      if (publisher != null) 'publisher': publisher,
      if (editionYear != null) 'edition_year': editionYear,
      if (sellPrice != null) 'sell_price': sellPrice,
      if (costPrice != null) 'cost_price': costPrice,
      if (currentStock != null) 'current_stock': currentStock,
      if (minLimit != null) 'min_limit': minLimit,
      if (returnDeadline != null) 'return_deadline': returnDeadline,
      if (shelfLifeStatus != null) 'shelf_life_status': shelfLifeStatus,
      if (totalSoldQty != null) 'total_sold_qty': totalSoldQty,
      if (reservedQuantity != null) 'reserved_quantity': reservedQuantity,
      if (lastSaleDate != null) 'last_sale_date': lastSaleDate,
      if (lastSupplyDate != null) 'last_supply_date': lastSupplyDate,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? name,
    Value<String?>? searchKeywords,
    Value<String?>? stage,
    Value<String?>? grade,
    Value<String?>? term,
    Value<String?>? subject,
    Value<String?>? publisher,
    Value<int?>? editionYear,
    Value<double>? sellPrice,
    Value<double>? costPrice,
    Value<int>? currentStock,
    Value<int>? minLimit,
    Value<DateTime?>? returnDeadline,
    Value<String?>? shelfLifeStatus,
    Value<int>? totalSoldQty,
    Value<int>? reservedQuantity,
    Value<DateTime?>? lastSaleDate,
    Value<DateTime?>? lastSupplyDate,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      name: name ?? this.name,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      stage: stage ?? this.stage,
      grade: grade ?? this.grade,
      term: term ?? this.term,
      subject: subject ?? this.subject,
      publisher: publisher ?? this.publisher,
      editionYear: editionYear ?? this.editionYear,
      sellPrice: sellPrice ?? this.sellPrice,
      costPrice: costPrice ?? this.costPrice,
      currentStock: currentStock ?? this.currentStock,
      minLimit: minLimit ?? this.minLimit,
      returnDeadline: returnDeadline ?? this.returnDeadline,
      shelfLifeStatus: shelfLifeStatus ?? this.shelfLifeStatus,
      totalSoldQty: totalSoldQty ?? this.totalSoldQty,
      reservedQuantity: reservedQuantity ?? this.reservedQuantity,
      lastSaleDate: lastSaleDate ?? this.lastSaleDate,
      lastSupplyDate: lastSupplyDate ?? this.lastSupplyDate,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (searchKeywords.present) {
      map['search_keywords'] = Variable<String>(searchKeywords.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (editionYear.present) {
      map['edition_year'] = Variable<int>(editionYear.value);
    }
    if (sellPrice.present) {
      map['sell_price'] = Variable<double>(sellPrice.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<int>(currentStock.value);
    }
    if (minLimit.present) {
      map['min_limit'] = Variable<int>(minLimit.value);
    }
    if (returnDeadline.present) {
      map['return_deadline'] = Variable<DateTime>(returnDeadline.value);
    }
    if (shelfLifeStatus.present) {
      map['shelf_life_status'] = Variable<String>(shelfLifeStatus.value);
    }
    if (totalSoldQty.present) {
      map['total_sold_qty'] = Variable<int>(totalSoldQty.value);
    }
    if (reservedQuantity.present) {
      map['reserved_quantity'] = Variable<int>(reservedQuantity.value);
    }
    if (lastSaleDate.present) {
      map['last_sale_date'] = Variable<DateTime>(lastSaleDate.value);
    }
    if (lastSupplyDate.present) {
      map['last_supply_date'] = Variable<DateTime>(lastSupplyDate.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('searchKeywords: $searchKeywords, ')
          ..write('stage: $stage, ')
          ..write('grade: $grade, ')
          ..write('term: $term, ')
          ..write('subject: $subject, ')
          ..write('publisher: $publisher, ')
          ..write('editionYear: $editionYear, ')
          ..write('sellPrice: $sellPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('currentStock: $currentStock, ')
          ..write('minLimit: $minLimit, ')
          ..write('returnDeadline: $returnDeadline, ')
          ..write('shelfLifeStatus: $shelfLifeStatus, ')
          ..write('totalSoldQty: $totalSoldQty, ')
          ..write('reservedQuantity: $reservedQuantity, ')
          ..write('lastSaleDate: $lastSaleDate, ')
          ..write('lastSupplyDate: $lastSupplyDate, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leadTimeMeta = const VerificationMeta(
    'leadTime',
  );
  @override
  late final GeneratedColumn<int> leadTime = GeneratedColumn<int>(
    'lead_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalPaidMeta = const VerificationMeta(
    'totalPaid',
  );
  @override
  late final GeneratedColumn<double> totalPaid = GeneratedColumn<double>(
    'total_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _aiScoreMeta = const VerificationMeta(
    'aiScore',
  );
  @override
  late final GeneratedColumn<double> aiScore = GeneratedColumn<double>(
    'ai_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReturnableMeta = const VerificationMeta(
    'isReturnable',
  );
  @override
  late final GeneratedColumn<bool> isReturnable = GeneratedColumn<bool>(
    'is_returnable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_returnable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _returnPolicyDaysMeta = const VerificationMeta(
    'returnPolicyDays',
  );
  @override
  late final GeneratedColumn<int> returnPolicyDays = GeneratedColumn<int>(
    'return_policy_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    name,
    phone,
    address,
    leadTime,
    balance,
    totalPaid,
    aiScore,
    lastUpdated,
    isReturnable,
    returnPolicyDays,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('lead_time')) {
      context.handle(
        _leadTimeMeta,
        leadTime.isAcceptableOrUnknown(data['lead_time']!, _leadTimeMeta),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('total_paid')) {
      context.handle(
        _totalPaidMeta,
        totalPaid.isAcceptableOrUnknown(data['total_paid']!, _totalPaidMeta),
      );
    }
    if (data.containsKey('ai_score')) {
      context.handle(
        _aiScoreMeta,
        aiScore.isAcceptableOrUnknown(data['ai_score']!, _aiScoreMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('is_returnable')) {
      context.handle(
        _isReturnableMeta,
        isReturnable.isAcceptableOrUnknown(
          data['is_returnable']!,
          _isReturnableMeta,
        ),
      );
    }
    if (data.containsKey('return_policy_days')) {
      context.handle(
        _returnPolicyDaysMeta,
        returnPolicyDays.isAcceptableOrUnknown(
          data['return_policy_days']!,
          _returnPolicyDaysMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      leadTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lead_time'],
      ),
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      totalPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_paid'],
      )!,
      aiScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ai_score'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
      isReturnable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_returnable'],
      )!,
      returnPolicyDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}return_policy_days'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String id;
  final String? libraryId;
  final String name;
  final String? phone;
  final String? address;
  final int? leadTime;
  final double balance;
  final double totalPaid;
  final double? aiScore;
  final DateTime lastUpdated;
  final bool isReturnable;
  final int returnPolicyDays;
  final bool isSynced;
  const Supplier({
    required this.id,
    this.libraryId,
    required this.name,
    this.phone,
    this.address,
    this.leadTime,
    required this.balance,
    required this.totalPaid,
    this.aiScore,
    required this.lastUpdated,
    required this.isReturnable,
    required this.returnPolicyDays,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || leadTime != null) {
      map['lead_time'] = Variable<int>(leadTime);
    }
    map['balance'] = Variable<double>(balance);
    map['total_paid'] = Variable<double>(totalPaid);
    if (!nullToAbsent || aiScore != null) {
      map['ai_score'] = Variable<double>(aiScore);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_returnable'] = Variable<bool>(isReturnable);
    map['return_policy_days'] = Variable<int>(returnPolicyDays);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      leadTime: leadTime == null && nullToAbsent
          ? const Value.absent()
          : Value(leadTime),
      balance: Value(balance),
      totalPaid: Value(totalPaid),
      aiScore: aiScore == null && nullToAbsent
          ? const Value.absent()
          : Value(aiScore),
      lastUpdated: Value(lastUpdated),
      isReturnable: Value(isReturnable),
      returnPolicyDays: Value(returnPolicyDays),
      isSynced: Value(isSynced),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      leadTime: serializer.fromJson<int?>(json['leadTime']),
      balance: serializer.fromJson<double>(json['balance']),
      totalPaid: serializer.fromJson<double>(json['totalPaid']),
      aiScore: serializer.fromJson<double?>(json['aiScore']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isReturnable: serializer.fromJson<bool>(json['isReturnable']),
      returnPolicyDays: serializer.fromJson<int>(json['returnPolicyDays']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'leadTime': serializer.toJson<int?>(leadTime),
      'balance': serializer.toJson<double>(balance),
      'totalPaid': serializer.toJson<double>(totalPaid),
      'aiScore': serializer.toJson<double?>(aiScore),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isReturnable': serializer.toJson<bool>(isReturnable),
      'returnPolicyDays': serializer.toJson<int>(returnPolicyDays),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Supplier copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<int?> leadTime = const Value.absent(),
    double? balance,
    double? totalPaid,
    Value<double?> aiScore = const Value.absent(),
    DateTime? lastUpdated,
    bool? isReturnable,
    int? returnPolicyDays,
    bool? isSynced,
  }) => Supplier(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    leadTime: leadTime.present ? leadTime.value : this.leadTime,
    balance: balance ?? this.balance,
    totalPaid: totalPaid ?? this.totalPaid,
    aiScore: aiScore.present ? aiScore.value : this.aiScore,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    isReturnable: isReturnable ?? this.isReturnable,
    returnPolicyDays: returnPolicyDays ?? this.returnPolicyDays,
    isSynced: isSynced ?? this.isSynced,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      leadTime: data.leadTime.present ? data.leadTime.value : this.leadTime,
      balance: data.balance.present ? data.balance.value : this.balance,
      totalPaid: data.totalPaid.present ? data.totalPaid.value : this.totalPaid,
      aiScore: data.aiScore.present ? data.aiScore.value : this.aiScore,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
      isReturnable: data.isReturnable.present
          ? data.isReturnable.value
          : this.isReturnable,
      returnPolicyDays: data.returnPolicyDays.present
          ? data.returnPolicyDays.value
          : this.returnPolicyDays,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('leadTime: $leadTime, ')
          ..write('balance: $balance, ')
          ..write('totalPaid: $totalPaid, ')
          ..write('aiScore: $aiScore, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isReturnable: $isReturnable, ')
          ..write('returnPolicyDays: $returnPolicyDays, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    name,
    phone,
    address,
    leadTime,
    balance,
    totalPaid,
    aiScore,
    lastUpdated,
    isReturnable,
    returnPolicyDays,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.leadTime == this.leadTime &&
          other.balance == this.balance &&
          other.totalPaid == this.totalPaid &&
          other.aiScore == this.aiScore &&
          other.lastUpdated == this.lastUpdated &&
          other.isReturnable == this.isReturnable &&
          other.returnPolicyDays == this.returnPolicyDays &&
          other.isSynced == this.isSynced);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<int?> leadTime;
  final Value<double> balance;
  final Value<double> totalPaid;
  final Value<double?> aiScore;
  final Value<DateTime> lastUpdated;
  final Value<bool> isReturnable;
  final Value<int> returnPolicyDays;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.leadTime = const Value.absent(),
    this.balance = const Value.absent(),
    this.totalPaid = const Value.absent(),
    this.aiScore = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isReturnable = const Value.absent(),
    this.returnPolicyDays = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.leadTime = const Value.absent(),
    this.balance = const Value.absent(),
    this.totalPaid = const Value.absent(),
    this.aiScore = const Value.absent(),
    required DateTime lastUpdated,
    this.isReturnable = const Value.absent(),
    this.returnPolicyDays = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       lastUpdated = Value(lastUpdated);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? leadTime,
    Expression<double>? balance,
    Expression<double>? totalPaid,
    Expression<double>? aiScore,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isReturnable,
    Expression<int>? returnPolicyDays,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (leadTime != null) 'lead_time': leadTime,
      if (balance != null) 'balance': balance,
      if (totalPaid != null) 'total_paid': totalPaid,
      if (aiScore != null) 'ai_score': aiScore,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isReturnable != null) 'is_returnable': isReturnable,
      if (returnPolicyDays != null) 'return_policy_days': returnPolicyDays,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<int?>? leadTime,
    Value<double>? balance,
    Value<double>? totalPaid,
    Value<double?>? aiScore,
    Value<DateTime>? lastUpdated,
    Value<bool>? isReturnable,
    Value<int>? returnPolicyDays,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      leadTime: leadTime ?? this.leadTime,
      balance: balance ?? this.balance,
      totalPaid: totalPaid ?? this.totalPaid,
      aiScore: aiScore ?? this.aiScore,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isReturnable: isReturnable ?? this.isReturnable,
      returnPolicyDays: returnPolicyDays ?? this.returnPolicyDays,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (leadTime.present) {
      map['lead_time'] = Variable<int>(leadTime.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (totalPaid.present) {
      map['total_paid'] = Variable<double>(totalPaid.value);
    }
    if (aiScore.present) {
      map['ai_score'] = Variable<double>(aiScore.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isReturnable.present) {
      map['is_returnable'] = Variable<bool>(isReturnable.value);
    }
    if (returnPolicyDays.present) {
      map['return_policy_days'] = Variable<int>(returnPolicyDays.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('leadTime: $leadTime, ')
          ..write('balance: $balance, ')
          ..write('totalPaid: $totalPaid, ')
          ..write('aiScore: $aiScore, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isReturnable: $isReturnable, ')
          ..write('returnPolicyDays: $returnPolicyDays, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseInvoicesTable extends PurchaseInvoices
    with TableInfo<$PurchaseInvoicesTable, PurchaseInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id)',
    ),
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta(
    'invoiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalBeforeDiscountMeta =
      const VerificationMeta('totalBeforeDiscount');
  @override
  late final GeneratedColumn<double> totalBeforeDiscount =
      GeneratedColumn<double>(
        'total_before_discount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _discountValueMeta = const VerificationMeta(
    'discountValue',
  );
  @override
  late final GeneratedColumn<double> discountValue = GeneratedColumn<double>(
    'discount_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalTotalMeta = const VerificationMeta(
    'finalTotal',
  );
  @override
  late final GeneratedColumn<double> finalTotal = GeneratedColumn<double>(
    'final_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceImagePathMeta = const VerificationMeta(
    'invoiceImagePath',
  );
  @override
  late final GeneratedColumn<String> invoiceImagePath = GeneratedColumn<String>(
    'invoice_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('received'),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    supplierId,
    invoiceDate,
    createdAt,
    totalBeforeDiscount,
    discountValue,
    finalTotal,
    paidAmount,
    invoiceImagePath,
    status,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoiceDateMeta,
        invoiceDate.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoiceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('total_before_discount')) {
      context.handle(
        _totalBeforeDiscountMeta,
        totalBeforeDiscount.isAcceptableOrUnknown(
          data['total_before_discount']!,
          _totalBeforeDiscountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalBeforeDiscountMeta);
    }
    if (data.containsKey('discount_value')) {
      context.handle(
        _discountValueMeta,
        discountValue.isAcceptableOrUnknown(
          data['discount_value']!,
          _discountValueMeta,
        ),
      );
    }
    if (data.containsKey('final_total')) {
      context.handle(
        _finalTotalMeta,
        finalTotal.isAcceptableOrUnknown(data['final_total']!, _finalTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_finalTotalMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('invoice_image_path')) {
      context.handle(
        _invoiceImagePathMeta,
        invoiceImagePath.isAcceptableOrUnknown(
          data['invoice_image_path']!,
          _invoiceImagePathMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PurchaseInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseInvoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      invoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoice_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      totalBeforeDiscount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_before_discount'],
      )!,
      discountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_value'],
      ),
      finalTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_total'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      ),
      invoiceImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_image_path'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $PurchaseInvoicesTable createAlias(String alias) {
    return $PurchaseInvoicesTable(attachedDatabase, alias);
  }
}

class PurchaseInvoice extends DataClass implements Insertable<PurchaseInvoice> {
  final String id;
  final String? libraryId;
  final String supplierId;
  final DateTime invoiceDate;
  final DateTime createdAt;
  final double totalBeforeDiscount;
  final double? discountValue;
  final double finalTotal;
  final double? paidAmount;
  final String? invoiceImagePath;
  final String status;
  final bool isSynced;
  const PurchaseInvoice({
    required this.id,
    this.libraryId,
    required this.supplierId,
    required this.invoiceDate,
    required this.createdAt,
    required this.totalBeforeDiscount,
    this.discountValue,
    required this.finalTotal,
    this.paidAmount,
    this.invoiceImagePath,
    required this.status,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['supplier_id'] = Variable<String>(supplierId);
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['total_before_discount'] = Variable<double>(totalBeforeDiscount);
    if (!nullToAbsent || discountValue != null) {
      map['discount_value'] = Variable<double>(discountValue);
    }
    map['final_total'] = Variable<double>(finalTotal);
    if (!nullToAbsent || paidAmount != null) {
      map['paid_amount'] = Variable<double>(paidAmount);
    }
    if (!nullToAbsent || invoiceImagePath != null) {
      map['invoice_image_path'] = Variable<String>(invoiceImagePath);
    }
    map['status'] = Variable<String>(status);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PurchaseInvoicesCompanion toCompanion(bool nullToAbsent) {
    return PurchaseInvoicesCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      supplierId: Value(supplierId),
      invoiceDate: Value(invoiceDate),
      createdAt: Value(createdAt),
      totalBeforeDiscount: Value(totalBeforeDiscount),
      discountValue: discountValue == null && nullToAbsent
          ? const Value.absent()
          : Value(discountValue),
      finalTotal: Value(finalTotal),
      paidAmount: paidAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAmount),
      invoiceImagePath: invoiceImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceImagePath),
      status: Value(status),
      isSynced: Value(isSynced),
    );
  }

  factory PurchaseInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseInvoice(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      totalBeforeDiscount: serializer.fromJson<double>(
        json['totalBeforeDiscount'],
      ),
      discountValue: serializer.fromJson<double?>(json['discountValue']),
      finalTotal: serializer.fromJson<double>(json['finalTotal']),
      paidAmount: serializer.fromJson<double?>(json['paidAmount']),
      invoiceImagePath: serializer.fromJson<String?>(json['invoiceImagePath']),
      status: serializer.fromJson<String>(json['status']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'supplierId': serializer.toJson<String>(supplierId),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'totalBeforeDiscount': serializer.toJson<double>(totalBeforeDiscount),
      'discountValue': serializer.toJson<double?>(discountValue),
      'finalTotal': serializer.toJson<double>(finalTotal),
      'paidAmount': serializer.toJson<double?>(paidAmount),
      'invoiceImagePath': serializer.toJson<String?>(invoiceImagePath),
      'status': serializer.toJson<String>(status),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PurchaseInvoice copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? supplierId,
    DateTime? invoiceDate,
    DateTime? createdAt,
    double? totalBeforeDiscount,
    Value<double?> discountValue = const Value.absent(),
    double? finalTotal,
    Value<double?> paidAmount = const Value.absent(),
    Value<String?> invoiceImagePath = const Value.absent(),
    String? status,
    bool? isSynced,
  }) => PurchaseInvoice(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    supplierId: supplierId ?? this.supplierId,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    createdAt: createdAt ?? this.createdAt,
    totalBeforeDiscount: totalBeforeDiscount ?? this.totalBeforeDiscount,
    discountValue: discountValue.present
        ? discountValue.value
        : this.discountValue,
    finalTotal: finalTotal ?? this.finalTotal,
    paidAmount: paidAmount.present ? paidAmount.value : this.paidAmount,
    invoiceImagePath: invoiceImagePath.present
        ? invoiceImagePath.value
        : this.invoiceImagePath,
    status: status ?? this.status,
    isSynced: isSynced ?? this.isSynced,
  );
  PurchaseInvoice copyWithCompanion(PurchaseInvoicesCompanion data) {
    return PurchaseInvoice(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      totalBeforeDiscount: data.totalBeforeDiscount.present
          ? data.totalBeforeDiscount.value
          : this.totalBeforeDiscount,
      discountValue: data.discountValue.present
          ? data.discountValue.value
          : this.discountValue,
      finalTotal: data.finalTotal.present
          ? data.finalTotal.value
          : this.finalTotal,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      invoiceImagePath: data.invoiceImagePath.present
          ? data.invoiceImagePath.value
          : this.invoiceImagePath,
      status: data.status.present ? data.status.value : this.status,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoice(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalBeforeDiscount: $totalBeforeDiscount, ')
          ..write('discountValue: $discountValue, ')
          ..write('finalTotal: $finalTotal, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('invoiceImagePath: $invoiceImagePath, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    supplierId,
    invoiceDate,
    createdAt,
    totalBeforeDiscount,
    discountValue,
    finalTotal,
    paidAmount,
    invoiceImagePath,
    status,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseInvoice &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.supplierId == this.supplierId &&
          other.invoiceDate == this.invoiceDate &&
          other.createdAt == this.createdAt &&
          other.totalBeforeDiscount == this.totalBeforeDiscount &&
          other.discountValue == this.discountValue &&
          other.finalTotal == this.finalTotal &&
          other.paidAmount == this.paidAmount &&
          other.invoiceImagePath == this.invoiceImagePath &&
          other.status == this.status &&
          other.isSynced == this.isSynced);
}

class PurchaseInvoicesCompanion extends UpdateCompanion<PurchaseInvoice> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> supplierId;
  final Value<DateTime> invoiceDate;
  final Value<DateTime> createdAt;
  final Value<double> totalBeforeDiscount;
  final Value<double?> discountValue;
  final Value<double> finalTotal;
  final Value<double?> paidAmount;
  final Value<String?> invoiceImagePath;
  final Value<String> status;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const PurchaseInvoicesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.totalBeforeDiscount = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.finalTotal = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.invoiceImagePath = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseInvoicesCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String supplierId,
    required DateTime invoiceDate,
    required DateTime createdAt,
    required double totalBeforeDiscount,
    this.discountValue = const Value.absent(),
    required double finalTotal,
    this.paidAmount = const Value.absent(),
    this.invoiceImagePath = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : supplierId = Value(supplierId),
       invoiceDate = Value(invoiceDate),
       createdAt = Value(createdAt),
       totalBeforeDiscount = Value(totalBeforeDiscount),
       finalTotal = Value(finalTotal);
  static Insertable<PurchaseInvoice> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? supplierId,
    Expression<DateTime>? invoiceDate,
    Expression<DateTime>? createdAt,
    Expression<double>? totalBeforeDiscount,
    Expression<double>? discountValue,
    Expression<double>? finalTotal,
    Expression<double>? paidAmount,
    Expression<String>? invoiceImagePath,
    Expression<String>? status,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (createdAt != null) 'created_at': createdAt,
      if (totalBeforeDiscount != null)
        'total_before_discount': totalBeforeDiscount,
      if (discountValue != null) 'discount_value': discountValue,
      if (finalTotal != null) 'final_total': finalTotal,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (invoiceImagePath != null) 'invoice_image_path': invoiceImagePath,
      if (status != null) 'status': status,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseInvoicesCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? supplierId,
    Value<DateTime>? invoiceDate,
    Value<DateTime>? createdAt,
    Value<double>? totalBeforeDiscount,
    Value<double?>? discountValue,
    Value<double>? finalTotal,
    Value<double?>? paidAmount,
    Value<String?>? invoiceImagePath,
    Value<String>? status,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return PurchaseInvoicesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      supplierId: supplierId ?? this.supplierId,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      createdAt: createdAt ?? this.createdAt,
      totalBeforeDiscount: totalBeforeDiscount ?? this.totalBeforeDiscount,
      discountValue: discountValue ?? this.discountValue,
      finalTotal: finalTotal ?? this.finalTotal,
      paidAmount: paidAmount ?? this.paidAmount,
      invoiceImagePath: invoiceImagePath ?? this.invoiceImagePath,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (totalBeforeDiscount.present) {
      map['total_before_discount'] = Variable<double>(
        totalBeforeDiscount.value,
      );
    }
    if (discountValue.present) {
      map['discount_value'] = Variable<double>(discountValue.value);
    }
    if (finalTotal.present) {
      map['final_total'] = Variable<double>(finalTotal.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (invoiceImagePath.present) {
      map['invoice_image_path'] = Variable<String>(invoiceImagePath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalBeforeDiscount: $totalBeforeDiscount, ')
          ..write('discountValue: $discountValue, ')
          ..write('finalTotal: $finalTotal, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('invoiceImagePath: $invoiceImagePath, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_invoices (id)',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    invoiceId,
    bookId,
    quantity,
    unitCost,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final String id;
  final String? libraryId;
  final String invoiceId;
  final String bookId;
  final int quantity;
  final double unitCost;
  final bool isSynced;
  const PurchaseItem({
    required this.id,
    this.libraryId,
    required this.invoiceId,
    required this.bookId,
    required this.quantity,
    required this.unitCost,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['invoice_id'] = Variable<String>(invoiceId);
    map['book_id'] = Variable<String>(bookId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_cost'] = Variable<double>(unitCost);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      invoiceId: Value(invoiceId),
      bookId: Value(bookId),
      quantity: Value(quantity),
      unitCost: Value(unitCost),
      isSynced: Value(isSynced),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'bookId': serializer.toJson<String>(bookId),
      'quantity': serializer.toJson<int>(quantity),
      'unitCost': serializer.toJson<double>(unitCost),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PurchaseItem copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? invoiceId,
    String? bookId,
    int? quantity,
    double? unitCost,
    bool? isSynced,
  }) => PurchaseItem(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    invoiceId: invoiceId ?? this.invoiceId,
    bookId: bookId ?? this.bookId,
    quantity: quantity ?? this.quantity,
    unitCost: unitCost ?? this.unitCost,
    isSynced: isSynced ?? this.isSynced,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    invoiceId,
    bookId,
    quantity,
    unitCost,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.invoiceId == this.invoiceId &&
          other.bookId == this.bookId &&
          other.quantity == this.quantity &&
          other.unitCost == this.unitCost &&
          other.isSynced == this.isSynced);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> invoiceId;
  final Value<String> bookId;
  final Value<int> quantity;
  final Value<double> unitCost;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String invoiceId,
    required String bookId,
    required int quantity,
    required double unitCost,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       bookId = Value(bookId),
       quantity = Value(quantity),
       unitCost = Value(unitCost);
  static Insertable<PurchaseItem> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? invoiceId,
    Expression<String>? bookId,
    Expression<int>? quantity,
    Expression<double>? unitCost,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (bookId != null) 'book_id': bookId,
      if (quantity != null) 'quantity': quantity,
      if (unitCost != null) 'unit_cost': unitCost,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? invoiceId,
    Value<String>? bookId,
    Value<int>? quantity,
    Value<double>? unitCost,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      invoiceId: invoiceId ?? this.invoiceId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.unitCost,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    name,
    phone,
    balance,
    lastUpdated,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String? libraryId;
  final String name;
  final String? phone;
  final double balance;
  final DateTime lastUpdated;
  final bool isSynced;
  const Customer({
    required this.id,
    this.libraryId,
    required this.name,
    this.phone,
    required this.balance,
    required this.lastUpdated,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['balance'] = Variable<double>(balance);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      balance: Value(balance),
      lastUpdated: Value(lastUpdated),
      isSynced: Value(isSynced),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      balance: serializer.fromJson<double>(json['balance']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'balance': serializer.toJson<double>(balance),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Customer copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    double? balance,
    DateTime? lastUpdated,
    bool? isSynced,
  }) => Customer(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    balance: balance ?? this.balance,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    isSynced: isSynced ?? this.isSynced,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      balance: data.balance.present ? data.balance.value : this.balance,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('balance: $balance, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, libraryId, name, phone, balance, lastUpdated, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.balance == this.balance &&
          other.lastUpdated == this.lastUpdated &&
          other.isSynced == this.isSynced);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<double> balance;
  final Value<DateTime> lastUpdated;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.balance = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.balance = const Value.absent(),
    required DateTime lastUpdated,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       lastUpdated = Value(lastUpdated);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<double>? balance,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (balance != null) 'balance': balance,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? name,
    Value<String?>? phone,
    Value<double>? balance,
    Value<DateTime>? lastUpdated,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('balance: $balance, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _saleDateMeta = const VerificationMeta(
    'saleDate',
  );
  @override
  late final GeneratedColumn<DateTime> saleDate = GeneratedColumn<DateTime>(
    'sale_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentTypeMeta = const VerificationMeta(
    'paymentType',
  );
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
    'payment_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountValueMeta = const VerificationMeta(
    'discountValue',
  );
  @override
  late final GeneratedColumn<double> discountValue = GeneratedColumn<double>(
    'discount_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingAmountMeta = const VerificationMeta(
    'remainingAmount',
  );
  @override
  late final GeneratedColumn<double> remainingAmount = GeneratedColumn<double>(
    'remaining_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalProfitMeta = const VerificationMeta(
    'totalProfit',
  );
  @override
  late final GeneratedColumn<double> totalProfit = GeneratedColumn<double>(
    'total_profit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    customerId,
    saleDate,
    paymentType,
    totalAmount,
    discountValue,
    paidAmount,
    remainingAmount,
    totalProfit,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('sale_date')) {
      context.handle(
        _saleDateMeta,
        saleDate.isAcceptableOrUnknown(data['sale_date']!, _saleDateMeta),
      );
    } else if (isInserting) {
      context.missing(_saleDateMeta);
    }
    if (data.containsKey('payment_type')) {
      context.handle(
        _paymentTypeMeta,
        paymentType.isAcceptableOrUnknown(
          data['payment_type']!,
          _paymentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentTypeMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('discount_value')) {
      context.handle(
        _discountValueMeta,
        discountValue.isAcceptableOrUnknown(
          data['discount_value']!,
          _discountValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountValueMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAmountMeta);
    }
    if (data.containsKey('remaining_amount')) {
      context.handle(
        _remainingAmountMeta,
        remainingAmount.isAcceptableOrUnknown(
          data['remaining_amount']!,
          _remainingAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingAmountMeta);
    }
    if (data.containsKey('total_profit')) {
      context.handle(
        _totalProfitMeta,
        totalProfit.isAcceptableOrUnknown(
          data['total_profit']!,
          _totalProfitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalProfitMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      saleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sale_date'],
      )!,
      paymentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_type'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      discountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_value'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      remainingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_amount'],
      )!,
      totalProfit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_profit'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final String? libraryId;
  final String? customerId;
  final DateTime saleDate;
  final String paymentType;
  final double totalAmount;
  final double discountValue;
  final double paidAmount;
  final double remainingAmount;
  final double totalProfit;
  final bool isSynced;
  const Sale({
    required this.id,
    this.libraryId,
    this.customerId,
    required this.saleDate,
    required this.paymentType,
    required this.totalAmount,
    required this.discountValue,
    required this.paidAmount,
    required this.remainingAmount,
    required this.totalProfit,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['sale_date'] = Variable<DateTime>(saleDate);
    map['payment_type'] = Variable<String>(paymentType);
    map['total_amount'] = Variable<double>(totalAmount);
    map['discount_value'] = Variable<double>(discountValue);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['remaining_amount'] = Variable<double>(remainingAmount);
    map['total_profit'] = Variable<double>(totalProfit);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      saleDate: Value(saleDate),
      paymentType: Value(paymentType),
      totalAmount: Value(totalAmount),
      discountValue: Value(discountValue),
      paidAmount: Value(paidAmount),
      remainingAmount: Value(remainingAmount),
      totalProfit: Value(totalProfit),
      isSynced: Value(isSynced),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      saleDate: serializer.fromJson<DateTime>(json['saleDate']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      discountValue: serializer.fromJson<double>(json['discountValue']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      remainingAmount: serializer.fromJson<double>(json['remainingAmount']),
      totalProfit: serializer.fromJson<double>(json['totalProfit']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'customerId': serializer.toJson<String?>(customerId),
      'saleDate': serializer.toJson<DateTime>(saleDate),
      'paymentType': serializer.toJson<String>(paymentType),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'discountValue': serializer.toJson<double>(discountValue),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'remainingAmount': serializer.toJson<double>(remainingAmount),
      'totalProfit': serializer.toJson<double>(totalProfit),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Sale copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    Value<String?> customerId = const Value.absent(),
    DateTime? saleDate,
    String? paymentType,
    double? totalAmount,
    double? discountValue,
    double? paidAmount,
    double? remainingAmount,
    double? totalProfit,
    bool? isSynced,
  }) => Sale(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    customerId: customerId.present ? customerId.value : this.customerId,
    saleDate: saleDate ?? this.saleDate,
    paymentType: paymentType ?? this.paymentType,
    totalAmount: totalAmount ?? this.totalAmount,
    discountValue: discountValue ?? this.discountValue,
    paidAmount: paidAmount ?? this.paidAmount,
    remainingAmount: remainingAmount ?? this.remainingAmount,
    totalProfit: totalProfit ?? this.totalProfit,
    isSynced: isSynced ?? this.isSynced,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      saleDate: data.saleDate.present ? data.saleDate.value : this.saleDate,
      paymentType: data.paymentType.present
          ? data.paymentType.value
          : this.paymentType,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      discountValue: data.discountValue.present
          ? data.discountValue.value
          : this.discountValue,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      remainingAmount: data.remainingAmount.present
          ? data.remainingAmount.value
          : this.remainingAmount,
      totalProfit: data.totalProfit.present
          ? data.totalProfit.value
          : this.totalProfit,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('customerId: $customerId, ')
          ..write('saleDate: $saleDate, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountValue: $discountValue, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('totalProfit: $totalProfit, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    customerId,
    saleDate,
    paymentType,
    totalAmount,
    discountValue,
    paidAmount,
    remainingAmount,
    totalProfit,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.customerId == this.customerId &&
          other.saleDate == this.saleDate &&
          other.paymentType == this.paymentType &&
          other.totalAmount == this.totalAmount &&
          other.discountValue == this.discountValue &&
          other.paidAmount == this.paidAmount &&
          other.remainingAmount == this.remainingAmount &&
          other.totalProfit == this.totalProfit &&
          other.isSynced == this.isSynced);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String?> customerId;
  final Value<DateTime> saleDate;
  final Value<String> paymentType;
  final Value<double> totalAmount;
  final Value<double> discountValue;
  final Value<double> paidAmount;
  final Value<double> remainingAmount;
  final Value<double> totalProfit;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.totalProfit = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.customerId = const Value.absent(),
    required DateTime saleDate,
    required String paymentType,
    required double totalAmount,
    required double discountValue,
    required double paidAmount,
    required double remainingAmount,
    required double totalProfit,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : saleDate = Value(saleDate),
       paymentType = Value(paymentType),
       totalAmount = Value(totalAmount),
       discountValue = Value(discountValue),
       paidAmount = Value(paidAmount),
       remainingAmount = Value(remainingAmount),
       totalProfit = Value(totalProfit);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? customerId,
    Expression<DateTime>? saleDate,
    Expression<String>? paymentType,
    Expression<double>? totalAmount,
    Expression<double>? discountValue,
    Expression<double>? paidAmount,
    Expression<double>? remainingAmount,
    Expression<double>? totalProfit,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (customerId != null) 'customer_id': customerId,
      if (saleDate != null) 'sale_date': saleDate,
      if (paymentType != null) 'payment_type': paymentType,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discountValue != null) 'discount_value': discountValue,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (remainingAmount != null) 'remaining_amount': remainingAmount,
      if (totalProfit != null) 'total_profit': totalProfit,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String?>? customerId,
    Value<DateTime>? saleDate,
    Value<String>? paymentType,
    Value<double>? totalAmount,
    Value<double>? discountValue,
    Value<double>? paidAmount,
    Value<double>? remainingAmount,
    Value<double>? totalProfit,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      customerId: customerId ?? this.customerId,
      saleDate: saleDate ?? this.saleDate,
      paymentType: paymentType ?? this.paymentType,
      totalAmount: totalAmount ?? this.totalAmount,
      discountValue: discountValue ?? this.discountValue,
      paidAmount: paidAmount ?? this.paidAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      totalProfit: totalProfit ?? this.totalProfit,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (saleDate.present) {
      map['sale_date'] = Variable<DateTime>(saleDate.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (discountValue.present) {
      map['discount_value'] = Variable<double>(discountValue.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (remainingAmount.present) {
      map['remaining_amount'] = Variable<double>(remainingAmount.value);
    }
    if (totalProfit.present) {
      map['total_profit'] = Variable<double>(totalProfit.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('customerId: $customerId, ')
          ..write('saleDate: $saleDate, ')
          ..write('paymentType: $paymentType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountValue: $discountValue, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('totalProfit: $totalProfit, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id)',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostAtSaleMeta = const VerificationMeta(
    'unitCostAtSale',
  );
  @override
  late final GeneratedColumn<double> unitCostAtSale = GeneratedColumn<double>(
    'unit_cost_at_sale',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    saleId,
    bookId,
    quantity,
    unitPrice,
    unitCostAtSale,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('unit_cost_at_sale')) {
      context.handle(
        _unitCostAtSaleMeta,
        unitCostAtSale.isAcceptableOrUnknown(
          data['unit_cost_at_sale']!,
          _unitCostAtSaleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitCostAtSaleMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      unitCostAtSale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost_at_sale'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final String id;
  final String? libraryId;
  final String saleId;
  final String bookId;
  final int quantity;
  final double unitPrice;
  final double unitCostAtSale;
  final bool isSynced;
  const SaleItem({
    required this.id,
    this.libraryId,
    required this.saleId,
    required this.bookId,
    required this.quantity,
    required this.unitPrice,
    required this.unitCostAtSale,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['sale_id'] = Variable<String>(saleId);
    map['book_id'] = Variable<String>(bookId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['unit_cost_at_sale'] = Variable<double>(unitCostAtSale);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      saleId: Value(saleId),
      bookId: Value(bookId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      unitCostAtSale: Value(unitCostAtSale),
      isSynced: Value(isSynced),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      saleId: serializer.fromJson<String>(json['saleId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      unitCostAtSale: serializer.fromJson<double>(json['unitCostAtSale']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'saleId': serializer.toJson<String>(saleId),
      'bookId': serializer.toJson<String>(bookId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'unitCostAtSale': serializer.toJson<double>(unitCostAtSale),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SaleItem copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? saleId,
    String? bookId,
    int? quantity,
    double? unitPrice,
    double? unitCostAtSale,
    bool? isSynced,
  }) => SaleItem(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    saleId: saleId ?? this.saleId,
    bookId: bookId ?? this.bookId,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    unitCostAtSale: unitCostAtSale ?? this.unitCostAtSale,
    isSynced: isSynced ?? this.isSynced,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      unitCostAtSale: data.unitCostAtSale.present
          ? data.unitCostAtSale.value
          : this.unitCostAtSale,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('saleId: $saleId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unitCostAtSale: $unitCostAtSale, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    saleId,
    bookId,
    quantity,
    unitPrice,
    unitCostAtSale,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.saleId == this.saleId &&
          other.bookId == this.bookId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.unitCostAtSale == this.unitCostAtSale &&
          other.isSynced == this.isSynced);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> saleId;
  final Value<String> bookId;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> unitCostAtSale;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.unitCostAtSale = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String saleId,
    required String bookId,
    required int quantity,
    required double unitPrice,
    required double unitCostAtSale,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : saleId = Value(saleId),
       bookId = Value(bookId),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       unitCostAtSale = Value(unitCostAtSale);
  static Insertable<SaleItem> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? saleId,
    Expression<String>? bookId,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? unitCostAtSale,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (saleId != null) 'sale_id': saleId,
      if (bookId != null) 'book_id': bookId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (unitCostAtSale != null) 'unit_cost_at_sale': unitCostAtSale,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleItemsCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? saleId,
    Value<String>? bookId,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? unitCostAtSale,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      saleId: saleId ?? this.saleId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      unitCostAtSale: unitCostAtSale ?? this.unitCostAtSale,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (unitCostAtSale.present) {
      map['unit_cost_at_sale'] = Variable<double>(unitCostAtSale.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('saleId: $saleId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unitCostAtSale: $unitCostAtSale, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNotesMeta = const VerificationMeta(
    'userNotes',
  );
  @override
  late final GeneratedColumn<String> userNotes = GeneratedColumn<String>(
    'user_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    title,
    category,
    amount,
    date,
    userNotes,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('user_notes')) {
      context.handle(
        _userNotesMeta,
        userNotes.isAcceptableOrUnknown(data['user_notes']!, _userNotesMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      userNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_notes'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String? libraryId;
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final String? userNotes;
  final bool isSynced;
  const Expense({
    required this.id,
    this.libraryId,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.userNotes,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || userNotes != null) {
      map['user_notes'] = Variable<String>(userNotes);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      title: Value(title),
      category: Value(category),
      amount: Value(amount),
      date: Value(date),
      userNotes: userNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(userNotes),
      isSynced: Value(isSynced),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      userNotes: serializer.fromJson<String?>(json['userNotes']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'userNotes': serializer.toJson<String?>(userNotes),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Expense copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? title,
    String? category,
    double? amount,
    DateTime? date,
    Value<String?> userNotes = const Value.absent(),
    bool? isSynced,
  }) => Expense(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    title: title ?? this.title,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    userNotes: userNotes.present ? userNotes.value : this.userNotes,
    isSynced: isSynced ?? this.isSynced,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      userNotes: data.userNotes.present ? data.userNotes.value : this.userNotes,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('userNotes: $userNotes, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    title,
    category,
    amount,
    date,
    userNotes,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.title == this.title &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.userNotes == this.userNotes &&
          other.isSynced == this.isSynced);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> title;
  final Value<String> category;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> userNotes;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.userNotes = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String title,
    required String category,
    required double amount,
    required DateTime date,
    this.userNotes = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       category = Value(category),
       amount = Value(amount),
       date = Value(date);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? userNotes,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (userNotes != null) 'user_notes': userNotes,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? title,
    Value<String>? category,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String?>? userNotes,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      userNotes: userNotes ?? this.userNotes,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (userNotes.present) {
      map['user_notes'] = Variable<String>(userNotes.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('userNotes: $userNotes, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReservationsTable extends Reservations
    with TableInfo<$ReservationsTable, Reservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _depositMeta = const VerificationMeta(
    'deposit',
  );
  @override
  late final GeneratedColumn<double> deposit = GeneratedColumn<double>(
    'deposit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    customerName,
    phone,
    bookName,
    bookId,
    deposit,
    status,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reservations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('deposit')) {
      context.handle(
        _depositMeta,
        deposit.isAcceptableOrUnknown(data['deposit']!, _depositMeta),
      );
    } else if (isInserting) {
      context.missing(_depositMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Reservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      ),
      deposit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deposit'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $ReservationsTable createAlias(String alias) {
    return $ReservationsTable(attachedDatabase, alias);
  }
}

class Reservation extends DataClass implements Insertable<Reservation> {
  final String id;
  final String? libraryId;
  final String customerName;
  final String phone;
  final String bookName;
  final String? bookId;
  final double deposit;
  final String status;
  final DateTime createdAt;
  final bool isSynced;
  const Reservation({
    required this.id,
    this.libraryId,
    required this.customerName,
    required this.phone,
    required this.bookName,
    this.bookId,
    required this.deposit,
    required this.status,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['customer_name'] = Variable<String>(customerName);
    map['phone'] = Variable<String>(phone);
    map['book_name'] = Variable<String>(bookName);
    if (!nullToAbsent || bookId != null) {
      map['book_id'] = Variable<String>(bookId);
    }
    map['deposit'] = Variable<double>(deposit);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  ReservationsCompanion toCompanion(bool nullToAbsent) {
    return ReservationsCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      customerName: Value(customerName),
      phone: Value(phone),
      bookName: Value(bookName),
      bookId: bookId == null && nullToAbsent
          ? const Value.absent()
          : Value(bookId),
      deposit: Value(deposit),
      status: Value(status),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory Reservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reservation(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phone: serializer.fromJson<String>(json['phone']),
      bookName: serializer.fromJson<String>(json['bookName']),
      bookId: serializer.fromJson<String?>(json['bookId']),
      deposit: serializer.fromJson<double>(json['deposit']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'customerName': serializer.toJson<String>(customerName),
      'phone': serializer.toJson<String>(phone),
      'bookName': serializer.toJson<String>(bookName),
      'bookId': serializer.toJson<String?>(bookId),
      'deposit': serializer.toJson<double>(deposit),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Reservation copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? customerName,
    String? phone,
    String? bookName,
    Value<String?> bookId = const Value.absent(),
    double? deposit,
    String? status,
    DateTime? createdAt,
    bool? isSynced,
  }) => Reservation(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    customerName: customerName ?? this.customerName,
    phone: phone ?? this.phone,
    bookName: bookName ?? this.bookName,
    bookId: bookId.present ? bookId.value : this.bookId,
    deposit: deposit ?? this.deposit,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  Reservation copyWithCompanion(ReservationsCompanion data) {
    return Reservation(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      deposit: data.deposit.present ? data.deposit.value : this.deposit,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reservation(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('bookName: $bookName, ')
          ..write('bookId: $bookId, ')
          ..write('deposit: $deposit, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    customerName,
    phone,
    bookName,
    bookId,
    deposit,
    status,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reservation &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.customerName == this.customerName &&
          other.phone == this.phone &&
          other.bookName == this.bookName &&
          other.bookId == this.bookId &&
          other.deposit == this.deposit &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class ReservationsCompanion extends UpdateCompanion<Reservation> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> customerName;
  final Value<String> phone;
  final Value<String> bookName;
  final Value<String?> bookId;
  final Value<double> deposit;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const ReservationsCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.bookName = const Value.absent(),
    this.bookId = const Value.absent(),
    this.deposit = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReservationsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String customerName,
    required String phone,
    required String bookName,
    this.bookId = const Value.absent(),
    required double deposit,
    required String status,
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : customerName = Value(customerName),
       phone = Value(phone),
       bookName = Value(bookName),
       deposit = Value(deposit),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<Reservation> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? customerName,
    Expression<String>? phone,
    Expression<String>? bookName,
    Expression<String>? bookId,
    Expression<double>? deposit,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (customerName != null) 'customer_name': customerName,
      if (phone != null) 'phone': phone,
      if (bookName != null) 'book_name': bookName,
      if (bookId != null) 'book_id': bookId,
      if (deposit != null) 'deposit': deposit,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReservationsCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? customerName,
    Value<String>? phone,
    Value<String>? bookName,
    Value<String?>? bookId,
    Value<double>? deposit,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return ReservationsCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      bookName: bookName ?? this.bookName,
      bookId: bookId ?? this.bookId,
      deposit: deposit ?? this.deposit,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (deposit.present) {
      map['deposit'] = Variable<double>(deposit.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservationsCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('bookName: $bookName, ')
          ..write('bookId: $bookId, ')
          ..write('deposit: $deposit, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesReturnsTable extends SalesReturns
    with TableInfo<$SalesReturnsTable, SalesReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnDateMeta = const VerificationMeta(
    'returnDate',
  );
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
    'return_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    bookId,
    quantity,
    refundAmount,
    reason,
    returnDate,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesReturn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refundAmountMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('return_date')) {
      context.handle(
        _returnDateMeta,
        returnDate.isAcceptableOrUnknown(data['return_date']!, _returnDateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnDateMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SalesReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesReturn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      returnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_date'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $SalesReturnsTable createAlias(String alias) {
    return $SalesReturnsTable(attachedDatabase, alias);
  }
}

class SalesReturn extends DataClass implements Insertable<SalesReturn> {
  final String id;
  final String? libraryId;
  final String bookId;
  final int quantity;
  final double refundAmount;
  final String? reason;
  final DateTime returnDate;
  final bool isSynced;
  const SalesReturn({
    required this.id,
    this.libraryId,
    required this.bookId,
    required this.quantity,
    required this.refundAmount,
    this.reason,
    required this.returnDate,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['book_id'] = Variable<String>(bookId);
    map['quantity'] = Variable<int>(quantity);
    map['refund_amount'] = Variable<double>(refundAmount);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['return_date'] = Variable<DateTime>(returnDate);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SalesReturnsCompanion toCompanion(bool nullToAbsent) {
    return SalesReturnsCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      bookId: Value(bookId),
      quantity: Value(quantity),
      refundAmount: Value(refundAmount),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      returnDate: Value(returnDate),
      isSynced: Value(isSynced),
    );
  }

  factory SalesReturn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesReturn(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      refundAmount: serializer.fromJson<double>(json['refundAmount']),
      reason: serializer.fromJson<String?>(json['reason']),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'bookId': serializer.toJson<String>(bookId),
      'quantity': serializer.toJson<int>(quantity),
      'refundAmount': serializer.toJson<double>(refundAmount),
      'reason': serializer.toJson<String?>(reason),
      'returnDate': serializer.toJson<DateTime>(returnDate),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SalesReturn copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? bookId,
    int? quantity,
    double? refundAmount,
    Value<String?> reason = const Value.absent(),
    DateTime? returnDate,
    bool? isSynced,
  }) => SalesReturn(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    bookId: bookId ?? this.bookId,
    quantity: quantity ?? this.quantity,
    refundAmount: refundAmount ?? this.refundAmount,
    reason: reason.present ? reason.value : this.reason,
    returnDate: returnDate ?? this.returnDate,
    isSynced: isSynced ?? this.isSynced,
  );
  SalesReturn copyWithCompanion(SalesReturnsCompanion data) {
    return SalesReturn(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      reason: data.reason.present ? data.reason.value : this.reason,
      returnDate: data.returnDate.present
          ? data.returnDate.value
          : this.returnDate,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesReturn(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('reason: $reason, ')
          ..write('returnDate: $returnDate, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    bookId,
    quantity,
    refundAmount,
    reason,
    returnDate,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesReturn &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.bookId == this.bookId &&
          other.quantity == this.quantity &&
          other.refundAmount == this.refundAmount &&
          other.reason == this.reason &&
          other.returnDate == this.returnDate &&
          other.isSynced == this.isSynced);
}

class SalesReturnsCompanion extends UpdateCompanion<SalesReturn> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> bookId;
  final Value<int> quantity;
  final Value<double> refundAmount;
  final Value<String?> reason;
  final Value<DateTime> returnDate;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const SalesReturnsCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.reason = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesReturnsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String bookId,
    required int quantity,
    required double refundAmount,
    this.reason = const Value.absent(),
    required DateTime returnDate,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bookId = Value(bookId),
       quantity = Value(quantity),
       refundAmount = Value(refundAmount),
       returnDate = Value(returnDate);
  static Insertable<SalesReturn> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? bookId,
    Expression<int>? quantity,
    Expression<double>? refundAmount,
    Expression<String>? reason,
    Expression<DateTime>? returnDate,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (bookId != null) 'book_id': bookId,
      if (quantity != null) 'quantity': quantity,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (reason != null) 'reason': reason,
      if (returnDate != null) 'return_date': returnDate,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesReturnsCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? bookId,
    Value<int>? quantity,
    Value<double>? refundAmount,
    Value<String?>? reason,
    Value<DateTime>? returnDate,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return SalesReturnsCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      refundAmount: refundAmount ?? this.refundAmount,
      reason: reason ?? this.reason,
      returnDate: returnDate ?? this.returnDate,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesReturnsCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('reason: $reason, ')
          ..write('returnDate: $returnDate, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReturnInvoicesTable extends ReturnInvoices
    with TableInfo<$ReturnInvoicesTable, ReturnInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id)',
    ),
  );
  static const VerificationMeta _returnDateMeta = const VerificationMeta(
    'returnDate',
  );
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
    'return_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _finalAmountMeta = const VerificationMeta(
    'finalAmount',
  );
  @override
  late final GeneratedColumn<double> finalAmount = GeneratedColumn<double>(
    'final_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    supplierId,
    returnDate,
    totalAmount,
    discountPercentage,
    finalAmount,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
        _returnDateMeta,
        returnDate.isAcceptableOrUnknown(data['return_date']!, _returnDateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnDateMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discountPercentageMeta,
        discountPercentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discountPercentageMeta,
        ),
      );
    }
    if (data.containsKey('final_amount')) {
      context.handle(
        _finalAmountMeta,
        finalAmount.isAcceptableOrUnknown(
          data['final_amount']!,
          _finalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_finalAmountMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ReturnInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnInvoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      returnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_date'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      discountPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percentage'],
      )!,
      finalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_amount'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $ReturnInvoicesTable createAlias(String alias) {
    return $ReturnInvoicesTable(attachedDatabase, alias);
  }
}

class ReturnInvoice extends DataClass implements Insertable<ReturnInvoice> {
  final String id;
  final String? libraryId;
  final String supplierId;
  final DateTime returnDate;
  final double totalAmount;
  final double discountPercentage;
  final double finalAmount;
  final bool isSynced;
  const ReturnInvoice({
    required this.id,
    this.libraryId,
    required this.supplierId,
    required this.returnDate,
    required this.totalAmount,
    required this.discountPercentage,
    required this.finalAmount,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['supplier_id'] = Variable<String>(supplierId);
    map['return_date'] = Variable<DateTime>(returnDate);
    map['total_amount'] = Variable<double>(totalAmount);
    map['discount_percentage'] = Variable<double>(discountPercentage);
    map['final_amount'] = Variable<double>(finalAmount);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  ReturnInvoicesCompanion toCompanion(bool nullToAbsent) {
    return ReturnInvoicesCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      supplierId: Value(supplierId),
      returnDate: Value(returnDate),
      totalAmount: Value(totalAmount),
      discountPercentage: Value(discountPercentage),
      finalAmount: Value(finalAmount),
      isSynced: Value(isSynced),
    );
  }

  factory ReturnInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnInvoice(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      discountPercentage: serializer.fromJson<double>(
        json['discountPercentage'],
      ),
      finalAmount: serializer.fromJson<double>(json['finalAmount']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'supplierId': serializer.toJson<String>(supplierId),
      'returnDate': serializer.toJson<DateTime>(returnDate),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'discountPercentage': serializer.toJson<double>(discountPercentage),
      'finalAmount': serializer.toJson<double>(finalAmount),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  ReturnInvoice copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? supplierId,
    DateTime? returnDate,
    double? totalAmount,
    double? discountPercentage,
    double? finalAmount,
    bool? isSynced,
  }) => ReturnInvoice(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    supplierId: supplierId ?? this.supplierId,
    returnDate: returnDate ?? this.returnDate,
    totalAmount: totalAmount ?? this.totalAmount,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    finalAmount: finalAmount ?? this.finalAmount,
    isSynced: isSynced ?? this.isSynced,
  );
  ReturnInvoice copyWithCompanion(ReturnInvoicesCompanion data) {
    return ReturnInvoice(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      returnDate: data.returnDate.present
          ? data.returnDate.value
          : this.returnDate,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      discountPercentage: data.discountPercentage.present
          ? data.discountPercentage.value
          : this.discountPercentage,
      finalAmount: data.finalAmount.present
          ? data.finalAmount.value
          : this.finalAmount,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnInvoice(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('returnDate: $returnDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('finalAmount: $finalAmount, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    supplierId,
    returnDate,
    totalAmount,
    discountPercentage,
    finalAmount,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnInvoice &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.supplierId == this.supplierId &&
          other.returnDate == this.returnDate &&
          other.totalAmount == this.totalAmount &&
          other.discountPercentage == this.discountPercentage &&
          other.finalAmount == this.finalAmount &&
          other.isSynced == this.isSynced);
}

class ReturnInvoicesCompanion extends UpdateCompanion<ReturnInvoice> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> supplierId;
  final Value<DateTime> returnDate;
  final Value<double> totalAmount;
  final Value<double> discountPercentage;
  final Value<double> finalAmount;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const ReturnInvoicesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.finalAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReturnInvoicesCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String supplierId,
    required DateTime returnDate,
    required double totalAmount,
    this.discountPercentage = const Value.absent(),
    required double finalAmount,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : supplierId = Value(supplierId),
       returnDate = Value(returnDate),
       totalAmount = Value(totalAmount),
       finalAmount = Value(finalAmount);
  static Insertable<ReturnInvoice> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? supplierId,
    Expression<DateTime>? returnDate,
    Expression<double>? totalAmount,
    Expression<double>? discountPercentage,
    Expression<double>? finalAmount,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (returnDate != null) 'return_date': returnDate,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (finalAmount != null) 'final_amount': finalAmount,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReturnInvoicesCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? supplierId,
    Value<DateTime>? returnDate,
    Value<double>? totalAmount,
    Value<double>? discountPercentage,
    Value<double>? finalAmount,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return ReturnInvoicesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      supplierId: supplierId ?? this.supplierId,
      returnDate: returnDate ?? this.returnDate,
      totalAmount: totalAmount ?? this.totalAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      finalAmount: finalAmount ?? this.finalAmount,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (finalAmount.present) {
      map['final_amount'] = Variable<double>(finalAmount.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('returnDate: $returnDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('finalAmount: $finalAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReturnItemsTable extends ReturnItems
    with TableInfo<$ReturnItemsTable, ReturnItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnIdMeta = const VerificationMeta(
    'returnId',
  );
  @override
  late final GeneratedColumn<String> returnId = GeneratedColumn<String>(
    'return_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES return_invoices (id)',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostAtReturnMeta = const VerificationMeta(
    'unitCostAtReturn',
  );
  @override
  late final GeneratedColumn<double> unitCostAtReturn = GeneratedColumn<double>(
    'unit_cost_at_return',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    returnId,
    bookId,
    quantity,
    unitCostAtReturn,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('return_id')) {
      context.handle(
        _returnIdMeta,
        returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_returnIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_cost_at_return')) {
      context.handle(
        _unitCostAtReturnMeta,
        unitCostAtReturn.isAcceptableOrUnknown(
          data['unit_cost_at_return']!,
          _unitCostAtReturnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitCostAtReturnMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ReturnItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      returnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitCostAtReturn: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost_at_return'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $ReturnItemsTable createAlias(String alias) {
    return $ReturnItemsTable(attachedDatabase, alias);
  }
}

class ReturnItem extends DataClass implements Insertable<ReturnItem> {
  final String id;
  final String? libraryId;
  final String returnId;
  final String bookId;
  final int quantity;
  final double unitCostAtReturn;
  final bool isSynced;
  const ReturnItem({
    required this.id,
    this.libraryId,
    required this.returnId,
    required this.bookId,
    required this.quantity,
    required this.unitCostAtReturn,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['return_id'] = Variable<String>(returnId);
    map['book_id'] = Variable<String>(bookId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_cost_at_return'] = Variable<double>(unitCostAtReturn);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  ReturnItemsCompanion toCompanion(bool nullToAbsent) {
    return ReturnItemsCompanion(
      id: Value(id),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      returnId: Value(returnId),
      bookId: Value(bookId),
      quantity: Value(quantity),
      unitCostAtReturn: Value(unitCostAtReturn),
      isSynced: Value(isSynced),
    );
  }

  factory ReturnItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnItem(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      returnId: serializer.fromJson<String>(json['returnId']),
      bookId: serializer.fromJson<String>(json['bookId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitCostAtReturn: serializer.fromJson<double>(json['unitCostAtReturn']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String?>(libraryId),
      'returnId': serializer.toJson<String>(returnId),
      'bookId': serializer.toJson<String>(bookId),
      'quantity': serializer.toJson<int>(quantity),
      'unitCostAtReturn': serializer.toJson<double>(unitCostAtReturn),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  ReturnItem copyWith({
    String? id,
    Value<String?> libraryId = const Value.absent(),
    String? returnId,
    String? bookId,
    int? quantity,
    double? unitCostAtReturn,
    bool? isSynced,
  }) => ReturnItem(
    id: id ?? this.id,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    returnId: returnId ?? this.returnId,
    bookId: bookId ?? this.bookId,
    quantity: quantity ?? this.quantity,
    unitCostAtReturn: unitCostAtReturn ?? this.unitCostAtReturn,
    isSynced: isSynced ?? this.isSynced,
  );
  ReturnItem copyWithCompanion(ReturnItemsCompanion data) {
    return ReturnItem(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      returnId: data.returnId.present ? data.returnId.value : this.returnId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCostAtReturn: data.unitCostAtReturn.present
          ? data.unitCostAtReturn.value
          : this.unitCostAtReturn,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnItem(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('returnId: $returnId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostAtReturn: $unitCostAtReturn, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    returnId,
    bookId,
    quantity,
    unitCostAtReturn,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnItem &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.returnId == this.returnId &&
          other.bookId == this.bookId &&
          other.quantity == this.quantity &&
          other.unitCostAtReturn == this.unitCostAtReturn &&
          other.isSynced == this.isSynced);
}

class ReturnItemsCompanion extends UpdateCompanion<ReturnItem> {
  final Value<String> id;
  final Value<String?> libraryId;
  final Value<String> returnId;
  final Value<String> bookId;
  final Value<int> quantity;
  final Value<double> unitCostAtReturn;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const ReturnItemsCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.returnId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCostAtReturn = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReturnItemsCompanion.insert({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    required String returnId,
    required String bookId,
    required int quantity,
    required double unitCostAtReturn,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : returnId = Value(returnId),
       bookId = Value(bookId),
       quantity = Value(quantity),
       unitCostAtReturn = Value(unitCostAtReturn);
  static Insertable<ReturnItem> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? returnId,
    Expression<String>? bookId,
    Expression<int>? quantity,
    Expression<double>? unitCostAtReturn,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (returnId != null) 'return_id': returnId,
      if (bookId != null) 'book_id': bookId,
      if (quantity != null) 'quantity': quantity,
      if (unitCostAtReturn != null) 'unit_cost_at_return': unitCostAtReturn,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReturnItemsCompanion copyWith({
    Value<String>? id,
    Value<String?>? libraryId,
    Value<String>? returnId,
    Value<String>? bookId,
    Value<int>? quantity,
    Value<double>? unitCostAtReturn,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return ReturnItemsCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      returnId: returnId ?? this.returnId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      unitCostAtReturn: unitCostAtReturn ?? this.unitCostAtReturn,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (returnId.present) {
      map['return_id'] = Variable<String>(returnId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitCostAtReturn.present) {
      map['unit_cost_at_return'] = Variable<double>(unitCostAtReturn.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnItemsCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('returnId: $returnId, ')
          ..write('bookId: $bookId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostAtReturn: $unitCostAtReturn, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GradeTargetsTable extends GradeTargets
    with TableInfo<$GradeTargetsTable, GradeTarget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradeTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentCountMeta = const VerificationMeta(
    'studentCount',
  );
  @override
  late final GeneratedColumn<int> studentCount = GeneratedColumn<int>(
    'student_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    grade,
    studentCount,
    libraryId,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grade_targets';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradeTarget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('student_count')) {
      context.handle(
        _studentCountMeta,
        studentCount.isAcceptableOrUnknown(
          data['student_count']!,
          _studentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studentCountMeta);
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {grade},
  ];
  @override
  GradeTarget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradeTarget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      studentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_count'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $GradeTargetsTable createAlias(String alias) {
    return $GradeTargetsTable(attachedDatabase, alias);
  }
}

class GradeTarget extends DataClass implements Insertable<GradeTarget> {
  final String id;
  final String grade;
  final int studentCount;
  final String? libraryId;
  final bool isSynced;
  const GradeTarget({
    required this.id,
    required this.grade,
    required this.studentCount,
    this.libraryId,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['grade'] = Variable<String>(grade);
    map['student_count'] = Variable<int>(studentCount);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  GradeTargetsCompanion toCompanion(bool nullToAbsent) {
    return GradeTargetsCompanion(
      id: Value(id),
      grade: Value(grade),
      studentCount: Value(studentCount),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      isSynced: Value(isSynced),
    );
  }

  factory GradeTarget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradeTarget(
      id: serializer.fromJson<String>(json['id']),
      grade: serializer.fromJson<String>(json['grade']),
      studentCount: serializer.fromJson<int>(json['studentCount']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'grade': serializer.toJson<String>(grade),
      'studentCount': serializer.toJson<int>(studentCount),
      'libraryId': serializer.toJson<String?>(libraryId),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  GradeTarget copyWith({
    String? id,
    String? grade,
    int? studentCount,
    Value<String?> libraryId = const Value.absent(),
    bool? isSynced,
  }) => GradeTarget(
    id: id ?? this.id,
    grade: grade ?? this.grade,
    studentCount: studentCount ?? this.studentCount,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    isSynced: isSynced ?? this.isSynced,
  );
  GradeTarget copyWithCompanion(GradeTargetsCompanion data) {
    return GradeTarget(
      id: data.id.present ? data.id.value : this.id,
      grade: data.grade.present ? data.grade.value : this.grade,
      studentCount: data.studentCount.present
          ? data.studentCount.value
          : this.studentCount,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradeTarget(')
          ..write('id: $id, ')
          ..write('grade: $grade, ')
          ..write('studentCount: $studentCount, ')
          ..write('libraryId: $libraryId, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, grade, studentCount, libraryId, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeTarget &&
          other.id == this.id &&
          other.grade == this.grade &&
          other.studentCount == this.studentCount &&
          other.libraryId == this.libraryId &&
          other.isSynced == this.isSynced);
}

class GradeTargetsCompanion extends UpdateCompanion<GradeTarget> {
  final Value<String> id;
  final Value<String> grade;
  final Value<int> studentCount;
  final Value<String?> libraryId;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const GradeTargetsCompanion({
    this.id = const Value.absent(),
    this.grade = const Value.absent(),
    this.studentCount = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GradeTargetsCompanion.insert({
    this.id = const Value.absent(),
    required String grade,
    required int studentCount,
    this.libraryId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : grade = Value(grade),
       studentCount = Value(studentCount);
  static Insertable<GradeTarget> custom({
    Expression<String>? id,
    Expression<String>? grade,
    Expression<int>? studentCount,
    Expression<String>? libraryId,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (grade != null) 'grade': grade,
      if (studentCount != null) 'student_count': studentCount,
      if (libraryId != null) 'library_id': libraryId,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GradeTargetsCompanion copyWith({
    Value<String>? id,
    Value<String>? grade,
    Value<int>? studentCount,
    Value<String?>? libraryId,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return GradeTargetsCompanion(
      id: id ?? this.id,
      grade: grade ?? this.grade,
      studentCount: studentCount ?? this.studentCount,
      libraryId: libraryId ?? this.libraryId,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (studentCount.present) {
      map['student_count'] = Variable<int>(studentCount.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradeTargetsCompanion(')
          ..write('id: $id, ')
          ..write('grade: $grade, ')
          ..write('studentCount: $studentCount, ')
          ..write('libraryId: $libraryId, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _seasonEndDateMeta = const VerificationMeta(
    'seasonEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> seasonEndDate =
      GeneratedColumn<DateTime>(
        'season_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultLeadTimeMeta = const VerificationMeta(
    'defaultLeadTime',
  );
  @override
  late final GeneratedColumn<int> defaultLeadTime = GeneratedColumn<int>(
    'default_lead_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseKeyMeta = const VerificationMeta(
    'licenseKey',
  );
  @override
  late final GeneratedColumn<String> licenseKey = GeneratedColumn<String>(
    'license_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseExpiryDateMeta = const VerificationMeta(
    'licenseExpiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> licenseExpiryDate =
      GeneratedColumn<DateTime>(
        'license_expiry_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _licenseStatusMeta = const VerificationMeta(
    'licenseStatus',
  );
  @override
  late final GeneratedColumn<String> licenseStatus = GeneratedColumn<String>(
    'license_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('inactive'),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    seasonEndDate,
    defaultLeadTime,
    libraryId,
    licenseKey,
    licenseExpiryDate,
    licenseStatus,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_end_date')) {
      context.handle(
        _seasonEndDateMeta,
        seasonEndDate.isAcceptableOrUnknown(
          data['season_end_date']!,
          _seasonEndDateMeta,
        ),
      );
    }
    if (data.containsKey('default_lead_time')) {
      context.handle(
        _defaultLeadTimeMeta,
        defaultLeadTime.isAcceptableOrUnknown(
          data['default_lead_time']!,
          _defaultLeadTimeMeta,
        ),
      );
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    }
    if (data.containsKey('license_key')) {
      context.handle(
        _licenseKeyMeta,
        licenseKey.isAcceptableOrUnknown(data['license_key']!, _licenseKeyMeta),
      );
    }
    if (data.containsKey('license_expiry_date')) {
      context.handle(
        _licenseExpiryDateMeta,
        licenseExpiryDate.isAcceptableOrUnknown(
          data['license_expiry_date']!,
          _licenseExpiryDateMeta,
        ),
      );
    }
    if (data.containsKey('license_status')) {
      context.handle(
        _licenseStatusMeta,
        licenseStatus.isAcceptableOrUnknown(
          data['license_status']!,
          _licenseStatusMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      seasonEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}season_end_date'],
      ),
      defaultLeadTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_lead_time'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      ),
      licenseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_key'],
      ),
      licenseExpiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}license_expiry_date'],
      ),
      licenseStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_status'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String id;
  final DateTime? seasonEndDate;
  final int defaultLeadTime;
  final String? libraryId;
  final String? licenseKey;
  final DateTime? licenseExpiryDate;
  final String licenseStatus;
  final bool isSynced;
  const AppSetting({
    required this.id,
    this.seasonEndDate,
    required this.defaultLeadTime,
    this.libraryId,
    this.licenseKey,
    this.licenseExpiryDate,
    required this.licenseStatus,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || seasonEndDate != null) {
      map['season_end_date'] = Variable<DateTime>(seasonEndDate);
    }
    map['default_lead_time'] = Variable<int>(defaultLeadTime);
    if (!nullToAbsent || libraryId != null) {
      map['library_id'] = Variable<String>(libraryId);
    }
    if (!nullToAbsent || licenseKey != null) {
      map['license_key'] = Variable<String>(licenseKey);
    }
    if (!nullToAbsent || licenseExpiryDate != null) {
      map['license_expiry_date'] = Variable<DateTime>(licenseExpiryDate);
    }
    map['license_status'] = Variable<String>(licenseStatus);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      seasonEndDate: seasonEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonEndDate),
      defaultLeadTime: Value(defaultLeadTime),
      libraryId: libraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(libraryId),
      licenseKey: licenseKey == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseKey),
      licenseExpiryDate: licenseExpiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseExpiryDate),
      licenseStatus: Value(licenseStatus),
      isSynced: Value(isSynced),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<String>(json['id']),
      seasonEndDate: serializer.fromJson<DateTime?>(json['seasonEndDate']),
      defaultLeadTime: serializer.fromJson<int>(json['defaultLeadTime']),
      libraryId: serializer.fromJson<String?>(json['libraryId']),
      licenseKey: serializer.fromJson<String?>(json['licenseKey']),
      licenseExpiryDate: serializer.fromJson<DateTime?>(
        json['licenseExpiryDate'],
      ),
      licenseStatus: serializer.fromJson<String>(json['licenseStatus']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'seasonEndDate': serializer.toJson<DateTime?>(seasonEndDate),
      'defaultLeadTime': serializer.toJson<int>(defaultLeadTime),
      'libraryId': serializer.toJson<String?>(libraryId),
      'licenseKey': serializer.toJson<String?>(licenseKey),
      'licenseExpiryDate': serializer.toJson<DateTime?>(licenseExpiryDate),
      'licenseStatus': serializer.toJson<String>(licenseStatus),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  AppSetting copyWith({
    String? id,
    Value<DateTime?> seasonEndDate = const Value.absent(),
    int? defaultLeadTime,
    Value<String?> libraryId = const Value.absent(),
    Value<String?> licenseKey = const Value.absent(),
    Value<DateTime?> licenseExpiryDate = const Value.absent(),
    String? licenseStatus,
    bool? isSynced,
  }) => AppSetting(
    id: id ?? this.id,
    seasonEndDate: seasonEndDate.present
        ? seasonEndDate.value
        : this.seasonEndDate,
    defaultLeadTime: defaultLeadTime ?? this.defaultLeadTime,
    libraryId: libraryId.present ? libraryId.value : this.libraryId,
    licenseKey: licenseKey.present ? licenseKey.value : this.licenseKey,
    licenseExpiryDate: licenseExpiryDate.present
        ? licenseExpiryDate.value
        : this.licenseExpiryDate,
    licenseStatus: licenseStatus ?? this.licenseStatus,
    isSynced: isSynced ?? this.isSynced,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      seasonEndDate: data.seasonEndDate.present
          ? data.seasonEndDate.value
          : this.seasonEndDate,
      defaultLeadTime: data.defaultLeadTime.present
          ? data.defaultLeadTime.value
          : this.defaultLeadTime,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      licenseKey: data.licenseKey.present
          ? data.licenseKey.value
          : this.licenseKey,
      licenseExpiryDate: data.licenseExpiryDate.present
          ? data.licenseExpiryDate.value
          : this.licenseExpiryDate,
      licenseStatus: data.licenseStatus.present
          ? data.licenseStatus.value
          : this.licenseStatus,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('seasonEndDate: $seasonEndDate, ')
          ..write('defaultLeadTime: $defaultLeadTime, ')
          ..write('libraryId: $libraryId, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('licenseExpiryDate: $licenseExpiryDate, ')
          ..write('licenseStatus: $licenseStatus, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    seasonEndDate,
    defaultLeadTime,
    libraryId,
    licenseKey,
    licenseExpiryDate,
    licenseStatus,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.seasonEndDate == this.seasonEndDate &&
          other.defaultLeadTime == this.defaultLeadTime &&
          other.libraryId == this.libraryId &&
          other.licenseKey == this.licenseKey &&
          other.licenseExpiryDate == this.licenseExpiryDate &&
          other.licenseStatus == this.licenseStatus &&
          other.isSynced == this.isSynced);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> id;
  final Value<DateTime?> seasonEndDate;
  final Value<int> defaultLeadTime;
  final Value<String?> libraryId;
  final Value<String?> licenseKey;
  final Value<DateTime?> licenseExpiryDate;
  final Value<String> licenseStatus;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.seasonEndDate = const Value.absent(),
    this.defaultLeadTime = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.licenseExpiryDate = const Value.absent(),
    this.licenseStatus = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.seasonEndDate = const Value.absent(),
    this.defaultLeadTime = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.licenseExpiryDate = const Value.absent(),
    this.licenseStatus = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<String>? id,
    Expression<DateTime>? seasonEndDate,
    Expression<int>? defaultLeadTime,
    Expression<String>? libraryId,
    Expression<String>? licenseKey,
    Expression<DateTime>? licenseExpiryDate,
    Expression<String>? licenseStatus,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonEndDate != null) 'season_end_date': seasonEndDate,
      if (defaultLeadTime != null) 'default_lead_time': defaultLeadTime,
      if (libraryId != null) 'library_id': libraryId,
      if (licenseKey != null) 'license_key': licenseKey,
      if (licenseExpiryDate != null) 'license_expiry_date': licenseExpiryDate,
      if (licenseStatus != null) 'license_status': licenseStatus,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<DateTime?>? seasonEndDate,
    Value<int>? defaultLeadTime,
    Value<String?>? libraryId,
    Value<String?>? licenseKey,
    Value<DateTime?>? licenseExpiryDate,
    Value<String>? licenseStatus,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      seasonEndDate: seasonEndDate ?? this.seasonEndDate,
      defaultLeadTime: defaultLeadTime ?? this.defaultLeadTime,
      libraryId: libraryId ?? this.libraryId,
      licenseKey: licenseKey ?? this.licenseKey,
      licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (seasonEndDate.present) {
      map['season_end_date'] = Variable<DateTime>(seasonEndDate.value);
    }
    if (defaultLeadTime.present) {
      map['default_lead_time'] = Variable<int>(defaultLeadTime.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (licenseKey.present) {
      map['license_key'] = Variable<String>(licenseKey.value);
    }
    if (licenseExpiryDate.present) {
      map['license_expiry_date'] = Variable<DateTime>(licenseExpiryDate.value);
    }
    if (licenseStatus.present) {
      map['license_status'] = Variable<String>(licenseStatus.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('seasonEndDate: $seasonEndDate, ')
          ..write('defaultLeadTime: $defaultLeadTime, ')
          ..write('libraryId: $libraryId, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('licenseExpiryDate: $licenseExpiryDate, ')
          ..write('licenseStatus: $licenseStatus, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $PurchaseInvoicesTable purchaseInvoices = $PurchaseInvoicesTable(
    this,
  );
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ReservationsTable reservations = $ReservationsTable(this);
  late final $SalesReturnsTable salesReturns = $SalesReturnsTable(this);
  late final $ReturnInvoicesTable returnInvoices = $ReturnInvoicesTable(this);
  late final $ReturnItemsTable returnItems = $ReturnItemsTable(this);
  late final $GradeTargetsTable gradeTargets = $GradeTargetsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final BooksDao booksDao = BooksDao(this as AppDatabase);
  late final SuppliersDao suppliersDao = SuppliersDao(this as AppDatabase);
  late final CustomersDao customersDao = CustomersDao(this as AppDatabase);
  late final SalesDao salesDao = SalesDao(this as AppDatabase);
  late final ExpensesDao expensesDao = ExpensesDao(this as AppDatabase);
  late final SmartSettingsDao smartSettingsDao = SmartSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    suppliers,
    purchaseInvoices,
    purchaseItems,
    customers,
    sales,
    saleItems,
    expenses,
    reservations,
    salesReturns,
    returnInvoices,
    returnItems,
    gradeTargets,
    appSettings,
  ];
}

typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String name,
      Value<String?> searchKeywords,
      Value<String?> stage,
      Value<String?> grade,
      Value<String?> term,
      Value<String?> subject,
      Value<String?> publisher,
      Value<int?> editionYear,
      required double sellPrice,
      required double costPrice,
      required int currentStock,
      required int minLimit,
      Value<DateTime?> returnDeadline,
      Value<String?> shelfLifeStatus,
      Value<int> totalSoldQty,
      Value<int> reservedQuantity,
      Value<DateTime?> lastSaleDate,
      Value<DateTime?> lastSupplyDate,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> name,
      Value<String?> searchKeywords,
      Value<String?> stage,
      Value<String?> grade,
      Value<String?> term,
      Value<String?> subject,
      Value<String?> publisher,
      Value<int?> editionYear,
      Value<double> sellPrice,
      Value<double> costPrice,
      Value<int> currentStock,
      Value<int> minLimit,
      Value<DateTime?> returnDeadline,
      Value<String?> shelfLifeStatus,
      Value<int> totalSoldQty,
      Value<int> reservedQuantity,
      Value<DateTime?> lastSaleDate,
      Value<DateTime?> lastSupplyDate,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(db.books.id, db.purchaseItems.bookId),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.books.id, db.saleItems.bookId),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesReturnsTable, List<SalesReturn>>
  _salesReturnsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesReturns,
    aliasName: $_aliasNameGenerator(db.books.id, db.salesReturns.bookId),
  );

  $$SalesReturnsTableProcessedTableManager get salesReturnsRefs {
    final manager = $$SalesReturnsTableTableManager(
      $_db,
      $_db.salesReturns,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesReturnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReturnItemsTable, List<ReturnItem>>
  _returnItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.returnItems,
    aliasName: $_aliasNameGenerator(db.books.id, db.returnItems.bookId),
  );

  $$ReturnItemsTableProcessedTableManager get returnItemsRefs {
    final manager = $$ReturnItemsTableTableManager(
      $_db,
      $_db.returnItems,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_returnItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get editionYear => $composableBuilder(
    column: $table.editionYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellPrice => $composableBuilder(
    column: $table.sellPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLimit => $composableBuilder(
    column: $table.minLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDeadline => $composableBuilder(
    column: $table.returnDeadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shelfLifeStatus => $composableBuilder(
    column: $table.shelfLifeStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSoldQty => $composableBuilder(
    column: $table.totalSoldQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reservedQuantity => $composableBuilder(
    column: $table.reservedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSaleDate => $composableBuilder(
    column: $table.lastSaleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSupplyDate => $composableBuilder(
    column: $table.lastSupplyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesReturnsRefs(
    Expression<bool> Function($$SalesReturnsTableFilterComposer f) f,
  ) {
    final $$SalesReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesReturns,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesReturnsTableFilterComposer(
            $db: $db,
            $table: $db.salesReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> returnItemsRefs(
    Expression<bool> Function($$ReturnItemsTableFilterComposer f) f,
  ) {
    final $$ReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.returnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get editionYear => $composableBuilder(
    column: $table.editionYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellPrice => $composableBuilder(
    column: $table.sellPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLimit => $composableBuilder(
    column: $table.minLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDeadline => $composableBuilder(
    column: $table.returnDeadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shelfLifeStatus => $composableBuilder(
    column: $table.shelfLifeStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSoldQty => $composableBuilder(
    column: $table.totalSoldQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reservedQuantity => $composableBuilder(
    column: $table.reservedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSaleDate => $composableBuilder(
    column: $table.lastSaleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSupplyDate => $composableBuilder(
    column: $table.lastSupplyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<int> get editionYear => $composableBuilder(
    column: $table.editionYear,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellPrice =>
      $composableBuilder(column: $table.sellPrice, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minLimit =>
      $composableBuilder(column: $table.minLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get returnDeadline => $composableBuilder(
    column: $table.returnDeadline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shelfLifeStatus => $composableBuilder(
    column: $table.shelfLifeStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSoldQty => $composableBuilder(
    column: $table.totalSoldQty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reservedQuantity => $composableBuilder(
    column: $table.reservedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSaleDate => $composableBuilder(
    column: $table.lastSaleDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSupplyDate => $composableBuilder(
    column: $table.lastSupplyDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesReturnsRefs<T extends Object>(
    Expression<T> Function($$SalesReturnsTableAnnotationComposer a) f,
  ) {
    final $$SalesReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesReturns,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> returnItemsRefs<T extends Object>(
    Expression<T> Function($$ReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$ReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnItems,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.returnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, $$BooksTableReferences),
          Book,
          PrefetchHooks Function({
            bool purchaseItemsRefs,
            bool saleItemsRefs,
            bool salesReturnsRefs,
            bool returnItemsRefs,
          })
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> searchKeywords = const Value.absent(),
                Value<String?> stage = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> term = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> editionYear = const Value.absent(),
                Value<double> sellPrice = const Value.absent(),
                Value<double> costPrice = const Value.absent(),
                Value<int> currentStock = const Value.absent(),
                Value<int> minLimit = const Value.absent(),
                Value<DateTime?> returnDeadline = const Value.absent(),
                Value<String?> shelfLifeStatus = const Value.absent(),
                Value<int> totalSoldQty = const Value.absent(),
                Value<int> reservedQuantity = const Value.absent(),
                Value<DateTime?> lastSaleDate = const Value.absent(),
                Value<DateTime?> lastSupplyDate = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                libraryId: libraryId,
                name: name,
                searchKeywords: searchKeywords,
                stage: stage,
                grade: grade,
                term: term,
                subject: subject,
                publisher: publisher,
                editionYear: editionYear,
                sellPrice: sellPrice,
                costPrice: costPrice,
                currentStock: currentStock,
                minLimit: minLimit,
                returnDeadline: returnDeadline,
                shelfLifeStatus: shelfLifeStatus,
                totalSoldQty: totalSoldQty,
                reservedQuantity: reservedQuantity,
                lastSaleDate: lastSaleDate,
                lastSupplyDate: lastSupplyDate,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String name,
                Value<String?> searchKeywords = const Value.absent(),
                Value<String?> stage = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> term = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> editionYear = const Value.absent(),
                required double sellPrice,
                required double costPrice,
                required int currentStock,
                required int minLimit,
                Value<DateTime?> returnDeadline = const Value.absent(),
                Value<String?> shelfLifeStatus = const Value.absent(),
                Value<int> totalSoldQty = const Value.absent(),
                Value<int> reservedQuantity = const Value.absent(),
                Value<DateTime?> lastSaleDate = const Value.absent(),
                Value<DateTime?> lastSupplyDate = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                libraryId: libraryId,
                name: name,
                searchKeywords: searchKeywords,
                stage: stage,
                grade: grade,
                term: term,
                subject: subject,
                publisher: publisher,
                editionYear: editionYear,
                sellPrice: sellPrice,
                costPrice: costPrice,
                currentStock: currentStock,
                minLimit: minLimit,
                returnDeadline: returnDeadline,
                shelfLifeStatus: shelfLifeStatus,
                totalSoldQty: totalSoldQty,
                reservedQuantity: reservedQuantity,
                lastSaleDate: lastSaleDate,
                lastSupplyDate: lastSupplyDate,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BooksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                purchaseItemsRefs = false,
                saleItemsRefs = false,
                salesReturnsRefs = false,
                returnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseItemsRefs) db.purchaseItems,
                    if (saleItemsRefs) db.saleItems,
                    if (salesReturnsRefs) db.salesReturns,
                    if (returnItemsRefs) db.returnItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Book,
                          $BooksTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedData<Book, $BooksTable, SaleItem>(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesReturnsRefs)
                        await $_getPrefetchedData<
                          Book,
                          $BooksTable,
                          SalesReturn
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._salesReturnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).salesReturnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (returnItemsRefs)
                        await $_getPrefetchedData<
                          Book,
                          $BooksTable,
                          ReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._returnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).returnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, $$BooksTableReferences),
      Book,
      PrefetchHooks Function({
        bool purchaseItemsRefs,
        bool saleItemsRefs,
        bool salesReturnsRefs,
        bool returnItemsRefs,
      })
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<int?> leadTime,
      Value<double> balance,
      Value<double> totalPaid,
      Value<double?> aiScore,
      required DateTime lastUpdated,
      Value<bool> isReturnable,
      Value<int> returnPolicyDays,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<int?> leadTime,
      Value<double> balance,
      Value<double> totalPaid,
      Value<double?> aiScore,
      Value<DateTime> lastUpdated,
      Value<bool> isReturnable,
      Value<int> returnPolicyDays,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchaseInvoicesTable, List<PurchaseInvoice>>
  _purchaseInvoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseInvoices,
    aliasName: $_aliasNameGenerator(
      db.suppliers.id,
      db.purchaseInvoices.supplierId,
    ),
  );

  $$PurchaseInvoicesTableProcessedTableManager get purchaseInvoicesRefs {
    final manager = $$PurchaseInvoicesTableTableManager(
      $_db,
      $_db.purchaseInvoices,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseInvoicesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReturnInvoicesTable, List<ReturnInvoice>>
  _returnInvoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.returnInvoices,
    aliasName: $_aliasNameGenerator(
      db.suppliers.id,
      db.returnInvoices.supplierId,
    ),
  );

  $$ReturnInvoicesTableProcessedTableManager get returnInvoicesRefs {
    final manager = $$ReturnInvoicesTableTableManager(
      $_db,
      $_db.returnInvoices,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_returnInvoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leadTime => $composableBuilder(
    column: $table.leadTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPaid => $composableBuilder(
    column: $table.totalPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aiScore => $composableBuilder(
    column: $table.aiScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReturnable => $composableBuilder(
    column: $table.isReturnable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnPolicyDays => $composableBuilder(
    column: $table.returnPolicyDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseInvoicesRefs(
    Expression<bool> Function($$PurchaseInvoicesTableFilterComposer f) f,
  ) {
    final $$PurchaseInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> returnInvoicesRefs(
    Expression<bool> Function($$ReturnInvoicesTableFilterComposer f) f,
  ) {
    final $$ReturnInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnInvoices,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.returnInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leadTime => $composableBuilder(
    column: $table.leadTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPaid => $composableBuilder(
    column: $table.totalPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aiScore => $composableBuilder(
    column: $table.aiScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReturnable => $composableBuilder(
    column: $table.isReturnable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnPolicyDays => $composableBuilder(
    column: $table.returnPolicyDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get leadTime =>
      $composableBuilder(column: $table.leadTime, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<double> get totalPaid =>
      $composableBuilder(column: $table.totalPaid, builder: (column) => column);

  GeneratedColumn<double> get aiScore =>
      $composableBuilder(column: $table.aiScore, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isReturnable => $composableBuilder(
    column: $table.isReturnable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get returnPolicyDays => $composableBuilder(
    column: $table.returnPolicyDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  Expression<T> purchaseInvoicesRefs<T extends Object>(
    Expression<T> Function($$PurchaseInvoicesTableAnnotationComposer a) f,
  ) {
    final $$PurchaseInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> returnInvoicesRefs<T extends Object>(
    Expression<T> Function($$ReturnInvoicesTableAnnotationComposer a) f,
  ) {
    final $$ReturnInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnInvoices,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.returnInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, $$SuppliersTableReferences),
          Supplier,
          PrefetchHooks Function({
            bool purchaseInvoicesRefs,
            bool returnInvoicesRefs,
          })
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int?> leadTime = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<double> totalPaid = const Value.absent(),
                Value<double?> aiScore = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<bool> isReturnable = const Value.absent(),
                Value<int> returnPolicyDays = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                libraryId: libraryId,
                name: name,
                phone: phone,
                address: address,
                leadTime: leadTime,
                balance: balance,
                totalPaid: totalPaid,
                aiScore: aiScore,
                lastUpdated: lastUpdated,
                isReturnable: isReturnable,
                returnPolicyDays: returnPolicyDays,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int?> leadTime = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<double> totalPaid = const Value.absent(),
                Value<double?> aiScore = const Value.absent(),
                required DateTime lastUpdated,
                Value<bool> isReturnable = const Value.absent(),
                Value<int> returnPolicyDays = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                libraryId: libraryId,
                name: name,
                phone: phone,
                address: address,
                leadTime: leadTime,
                balance: balance,
                totalPaid: totalPaid,
                aiScore: aiScore,
                lastUpdated: lastUpdated,
                isReturnable: isReturnable,
                returnPolicyDays: returnPolicyDays,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({purchaseInvoicesRefs = false, returnInvoicesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseInvoicesRefs) db.purchaseInvoices,
                    if (returnInvoicesRefs) db.returnInvoices,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseInvoicesRefs)
                        await $_getPrefetchedData<
                          Supplier,
                          $SuppliersTable,
                          PurchaseInvoice
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences
                              ._purchaseInvoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseInvoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (returnInvoicesRefs)
                        await $_getPrefetchedData<
                          Supplier,
                          $SuppliersTable,
                          ReturnInvoice
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences
                              ._returnInvoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).returnInvoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, $$SuppliersTableReferences),
      Supplier,
      PrefetchHooks Function({
        bool purchaseInvoicesRefs,
        bool returnInvoicesRefs,
      })
    >;
typedef $$PurchaseInvoicesTableCreateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String supplierId,
      required DateTime invoiceDate,
      required DateTime createdAt,
      required double totalBeforeDiscount,
      Value<double?> discountValue,
      required double finalTotal,
      Value<double?> paidAmount,
      Value<String?> invoiceImagePath,
      Value<String> status,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$PurchaseInvoicesTableUpdateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> supplierId,
      Value<DateTime> invoiceDate,
      Value<DateTime> createdAt,
      Value<double> totalBeforeDiscount,
      Value<double?> discountValue,
      Value<double> finalTotal,
      Value<double?> paidAmount,
      Value<String?> invoiceImagePath,
      Value<String> status,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$PurchaseInvoicesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PurchaseInvoicesTable, PurchaseInvoice> {
  $$PurchaseInvoicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias(
        $_aliasNameGenerator(db.purchaseInvoices.supplierId, db.suppliers.id),
      );

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(
      db.purchaseInvoices.id,
      db.purchaseItems.invoiceId,
    ),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalBeforeDiscount => $composableBuilder(
    column: $table.totalBeforeDiscount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceImagePath => $composableBuilder(
    column: $table.invoiceImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalBeforeDiscount => $composableBuilder(
    column: $table.totalBeforeDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceImagePath => $composableBuilder(
    column: $table.invoiceImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get totalBeforeDiscount => $composableBuilder(
    column: $table.totalBeforeDiscount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceImagePath => $composableBuilder(
    column: $table.invoiceImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseInvoicesTable,
          PurchaseInvoice,
          $$PurchaseInvoicesTableFilterComposer,
          $$PurchaseInvoicesTableOrderingComposer,
          $$PurchaseInvoicesTableAnnotationComposer,
          $$PurchaseInvoicesTableCreateCompanionBuilder,
          $$PurchaseInvoicesTableUpdateCompanionBuilder,
          (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
          PurchaseInvoice,
          PrefetchHooks Function({bool supplierId, bool purchaseItemsRefs})
        > {
  $$PurchaseInvoicesTableTableManager(
    _$AppDatabase db,
    $PurchaseInvoicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> totalBeforeDiscount = const Value.absent(),
                Value<double?> discountValue = const Value.absent(),
                Value<double> finalTotal = const Value.absent(),
                Value<double?> paidAmount = const Value.absent(),
                Value<String?> invoiceImagePath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseInvoicesCompanion(
                id: id,
                libraryId: libraryId,
                supplierId: supplierId,
                invoiceDate: invoiceDate,
                createdAt: createdAt,
                totalBeforeDiscount: totalBeforeDiscount,
                discountValue: discountValue,
                finalTotal: finalTotal,
                paidAmount: paidAmount,
                invoiceImagePath: invoiceImagePath,
                status: status,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String supplierId,
                required DateTime invoiceDate,
                required DateTime createdAt,
                required double totalBeforeDiscount,
                Value<double?> discountValue = const Value.absent(),
                required double finalTotal,
                Value<double?> paidAmount = const Value.absent(),
                Value<String?> invoiceImagePath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseInvoicesCompanion.insert(
                id: id,
                libraryId: libraryId,
                supplierId: supplierId,
                invoiceDate: invoiceDate,
                createdAt: createdAt,
                totalBeforeDiscount: totalBeforeDiscount,
                discountValue: discountValue,
                finalTotal: finalTotal,
                paidAmount: paidAmount,
                invoiceImagePath: invoiceImagePath,
                status: status,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseInvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({supplierId = false, purchaseItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseItemsRefs) db.purchaseItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$PurchaseInvoicesTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$PurchaseInvoicesTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          PurchaseInvoice,
                          $PurchaseInvoicesTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseInvoicesTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseInvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseInvoicesTable,
      PurchaseInvoice,
      $$PurchaseInvoicesTableFilterComposer,
      $$PurchaseInvoicesTableOrderingComposer,
      $$PurchaseInvoicesTableAnnotationComposer,
      $$PurchaseInvoicesTableCreateCompanionBuilder,
      $$PurchaseInvoicesTableUpdateCompanionBuilder,
      (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
      PurchaseInvoice,
      PrefetchHooks Function({bool supplierId, bool purchaseItemsRefs})
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String invoiceId,
      required String bookId,
      required int quantity,
      required double unitCost,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> invoiceId,
      Value<String> bookId,
      Value<int> quantity,
      Value<double> unitCost,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$PurchaseItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem> {
  $$PurchaseItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseInvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.purchaseInvoices.createAlias(
        $_aliasNameGenerator(
          db.purchaseItems.invoiceId,
          db.purchaseInvoices.id,
        ),
      );

  $$PurchaseInvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$PurchaseInvoicesTableTableManager(
      $_db,
      $_db.purchaseInvoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.purchaseItems.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseInvoicesTableFilterComposer get invoiceId {
    final $$PurchaseInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseInvoicesTableOrderingComposer get invoiceId {
    final $$PurchaseInvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$PurchaseInvoicesTableAnnotationComposer get invoiceId {
    final $$PurchaseInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (PurchaseItem, $$PurchaseItemsTableReferences),
          PurchaseItem,
          PrefetchHooks Function({bool invoiceId, bool bookId})
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                libraryId: libraryId,
                invoiceId: invoiceId,
                bookId: bookId,
                quantity: quantity,
                unitCost: unitCost,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String invoiceId,
                required String bookId,
                required int quantity,
                required double unitCost,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion.insert(
                id: id,
                libraryId: libraryId,
                invoiceId: invoiceId,
                bookId: bookId,
                quantity: quantity,
                unitCost: unitCost,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (PurchaseItem, $$PurchaseItemsTableReferences),
      PurchaseItem,
      PrefetchHooks Function({bool invoiceId, bool bookId})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String name,
      Value<String?> phone,
      Value<double> balance,
      required DateTime lastUpdated,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> name,
      Value<String?> phone,
      Value<double> balance,
      Value<DateTime> lastUpdated,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SalesTable, List<Sale>> _salesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sales,
    aliasName: $_aliasNameGenerator(db.customers.id, db.sales.customerId),
  );

  $$SalesTableProcessedTableManager get salesRefs {
    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> salesRefs(
    Expression<bool> Function($$SalesTableFilterComposer f) f,
  ) {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  Expression<T> salesRefs<T extends Object>(
    Expression<T> Function($$SalesTableAnnotationComposer a) f,
  ) {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool salesRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                libraryId: libraryId,
                name: name,
                phone: phone,
                balance: balance,
                lastUpdated: lastUpdated,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<double> balance = const Value.absent(),
                required DateTime lastUpdated,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                libraryId: libraryId,
                name: name,
                phone: phone,
                balance: balance,
                lastUpdated: lastUpdated,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({salesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (salesRefs) db.sales],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesRefs)
                    await $_getPrefetchedData<Customer, $CustomersTable, Sale>(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._salesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(db, table, p0).salesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool salesRefs})
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String?> customerId,
      required DateTime saleDate,
      required String paymentType,
      required double totalAmount,
      required double discountValue,
      required double paidAmount,
      required double remainingAmount,
      required double totalProfit,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String?> customerId,
      Value<DateTime> saleDate,
      Value<String> paymentType,
      Value<double> totalAmount,
      Value<double> discountValue,
      Value<double> paidAmount,
      Value<double> remainingAmount,
      Value<double> totalProfit,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) => db.customers
      .createAlias($_aliasNameGenerator(db.sales.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<String>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.sales.id, db.saleItems.saleId),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalProfit => $composableBuilder(
    column: $table.totalProfit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalProfit => $composableBuilder(
    column: $table.totalProfit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<DateTime> get saleDate =>
      $composableBuilder(column: $table.saleDate, builder: (column) => column);

  GeneratedColumn<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalProfit => $composableBuilder(
    column: $table.totalProfit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool customerId, bool saleItemsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<DateTime> saleDate = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discountValue = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<double> totalProfit = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                libraryId: libraryId,
                customerId: customerId,
                saleDate: saleDate,
                paymentType: paymentType,
                totalAmount: totalAmount,
                discountValue: discountValue,
                paidAmount: paidAmount,
                remainingAmount: remainingAmount,
                totalProfit: totalProfit,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                required DateTime saleDate,
                required String paymentType,
                required double totalAmount,
                required double discountValue,
                required double paidAmount,
                required double remainingAmount,
                required double totalProfit,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                libraryId: libraryId,
                customerId: customerId,
                saleDate: saleDate,
                paymentType: paymentType,
                totalAmount: totalAmount,
                discountValue: discountValue,
                paidAmount: paidAmount,
                remainingAmount: remainingAmount,
                totalProfit: totalProfit,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({customerId = false, saleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (saleItemsRefs) db.saleItems],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$SalesTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$SalesTableReferences
                                    ._customerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (saleItemsRefs)
                    await $_getPrefetchedData<Sale, $SalesTable, SaleItem>(
                      currentTable: table,
                      referencedTable: $$SalesTableReferences
                          ._saleItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesTableReferences(db, table, p0).saleItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.saleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool customerId, bool saleItemsRefs})
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String saleId,
      required String bookId,
      required int quantity,
      required double unitPrice,
      required double unitCostAtSale,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> saleId,
      Value<String> bookId,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> unitCostAtSale,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$SaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem> {
  $$SaleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias(
    $_aliasNameGenerator(db.saleItems.saleId, db.sales.id),
  );

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.saleItems.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCostAtSale => $composableBuilder(
    column: $table.unitCostAtSale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCostAtSale => $composableBuilder(
    column: $table.unitCostAtSale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get unitCostAtSale => $composableBuilder(
    column: $table.unitCostAtSale,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, $$SaleItemsTableReferences),
          SaleItem,
          PrefetchHooks Function({bool saleId, bool bookId})
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> unitCostAtSale = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                libraryId: libraryId,
                saleId: saleId,
                bookId: bookId,
                quantity: quantity,
                unitPrice: unitPrice,
                unitCostAtSale: unitCostAtSale,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String saleId,
                required String bookId,
                required int quantity,
                required double unitPrice,
                required double unitCostAtSale,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                libraryId: libraryId,
                saleId: saleId,
                bookId: bookId,
                quantity: quantity,
                unitPrice: unitPrice,
                unitCostAtSale: unitCostAtSale,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false, bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._saleIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, $$SaleItemsTableReferences),
      SaleItem,
      PrefetchHooks Function({bool saleId, bool bookId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String title,
      required String category,
      required double amount,
      required DateTime date,
      Value<String?> userNotes,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> title,
      Value<String> category,
      Value<double> amount,
      Value<DateTime> date,
      Value<String?> userNotes,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userNotes => $composableBuilder(
    column: $table.userNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userNotes => $composableBuilder(
    column: $table.userNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get userNotes =>
      $composableBuilder(column: $table.userNotes, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> userNotes = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                libraryId: libraryId,
                title: title,
                category: category,
                amount: amount,
                date: date,
                userNotes: userNotes,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String title,
                required String category,
                required double amount,
                required DateTime date,
                Value<String?> userNotes = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                libraryId: libraryId,
                title: title,
                category: category,
                amount: amount,
                date: date,
                userNotes: userNotes,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$ReservationsTableCreateCompanionBuilder =
    ReservationsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String customerName,
      required String phone,
      required String bookName,
      Value<String?> bookId,
      required double deposit,
      required String status,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$ReservationsTableUpdateCompanionBuilder =
    ReservationsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> customerName,
      Value<String> phone,
      Value<String> bookName,
      Value<String?> bookId,
      Value<double> deposit,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$ReservationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deposit => $composableBuilder(
    column: $table.deposit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deposit => $composableBuilder(
    column: $table.deposit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<double> get deposit =>
      $composableBuilder(column: $table.deposit, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$ReservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReservationsTable,
          Reservation,
          $$ReservationsTableFilterComposer,
          $$ReservationsTableOrderingComposer,
          $$ReservationsTableAnnotationComposer,
          $$ReservationsTableCreateCompanionBuilder,
          $$ReservationsTableUpdateCompanionBuilder,
          (
            Reservation,
            BaseReferences<_$AppDatabase, $ReservationsTable, Reservation>,
          ),
          Reservation,
          PrefetchHooks Function()
        > {
  $$ReservationsTableTableManager(_$AppDatabase db, $ReservationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<String?> bookId = const Value.absent(),
                Value<double> deposit = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReservationsCompanion(
                id: id,
                libraryId: libraryId,
                customerName: customerName,
                phone: phone,
                bookName: bookName,
                bookId: bookId,
                deposit: deposit,
                status: status,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String customerName,
                required String phone,
                required String bookName,
                Value<String?> bookId = const Value.absent(),
                required double deposit,
                required String status,
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReservationsCompanion.insert(
                id: id,
                libraryId: libraryId,
                customerName: customerName,
                phone: phone,
                bookName: bookName,
                bookId: bookId,
                deposit: deposit,
                status: status,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReservationsTable,
      Reservation,
      $$ReservationsTableFilterComposer,
      $$ReservationsTableOrderingComposer,
      $$ReservationsTableAnnotationComposer,
      $$ReservationsTableCreateCompanionBuilder,
      $$ReservationsTableUpdateCompanionBuilder,
      (
        Reservation,
        BaseReferences<_$AppDatabase, $ReservationsTable, Reservation>,
      ),
      Reservation,
      PrefetchHooks Function()
    >;
typedef $$SalesReturnsTableCreateCompanionBuilder =
    SalesReturnsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String bookId,
      required int quantity,
      required double refundAmount,
      Value<String?> reason,
      required DateTime returnDate,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$SalesReturnsTableUpdateCompanionBuilder =
    SalesReturnsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> bookId,
      Value<int> quantity,
      Value<double> refundAmount,
      Value<String?> reason,
      Value<DateTime> returnDate,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$SalesReturnsTableReferences
    extends BaseReferences<_$AppDatabase, $SalesReturnsTable, SalesReturn> {
  $$SalesReturnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.salesReturns.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesReturnsTable,
          SalesReturn,
          $$SalesReturnsTableFilterComposer,
          $$SalesReturnsTableOrderingComposer,
          $$SalesReturnsTableAnnotationComposer,
          $$SalesReturnsTableCreateCompanionBuilder,
          $$SalesReturnsTableUpdateCompanionBuilder,
          (SalesReturn, $$SalesReturnsTableReferences),
          SalesReturn,
          PrefetchHooks Function({bool bookId})
        > {
  $$SalesReturnsTableTableManager(_$AppDatabase db, $SalesReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> returnDate = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesReturnsCompanion(
                id: id,
                libraryId: libraryId,
                bookId: bookId,
                quantity: quantity,
                refundAmount: refundAmount,
                reason: reason,
                returnDate: returnDate,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String bookId,
                required int quantity,
                required double refundAmount,
                Value<String?> reason = const Value.absent(),
                required DateTime returnDate,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesReturnsCompanion.insert(
                id: id,
                libraryId: libraryId,
                bookId: bookId,
                quantity: quantity,
                refundAmount: refundAmount,
                reason: reason,
                returnDate: returnDate,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesReturnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$SalesReturnsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$SalesReturnsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesReturnsTable,
      SalesReturn,
      $$SalesReturnsTableFilterComposer,
      $$SalesReturnsTableOrderingComposer,
      $$SalesReturnsTableAnnotationComposer,
      $$SalesReturnsTableCreateCompanionBuilder,
      $$SalesReturnsTableUpdateCompanionBuilder,
      (SalesReturn, $$SalesReturnsTableReferences),
      SalesReturn,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$ReturnInvoicesTableCreateCompanionBuilder =
    ReturnInvoicesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String supplierId,
      required DateTime returnDate,
      required double totalAmount,
      Value<double> discountPercentage,
      required double finalAmount,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$ReturnInvoicesTableUpdateCompanionBuilder =
    ReturnInvoicesCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> supplierId,
      Value<DateTime> returnDate,
      Value<double> totalAmount,
      Value<double> discountPercentage,
      Value<double> finalAmount,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$ReturnInvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $ReturnInvoicesTable, ReturnInvoice> {
  $$ReturnInvoicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias(
        $_aliasNameGenerator(db.returnInvoices.supplierId, db.suppliers.id),
      );

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReturnItemsTable, List<ReturnItem>>
  _returnItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.returnItems,
    aliasName: $_aliasNameGenerator(
      db.returnInvoices.id,
      db.returnItems.returnId,
    ),
  );

  $$ReturnItemsTableProcessedTableManager get returnItemsRefs {
    final manager = $$ReturnItemsTableTableManager(
      $_db,
      $_db.returnItems,
    ).filter((f) => f.returnId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_returnItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReturnInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> returnItemsRefs(
    Expression<bool> Function($$ReturnItemsTableFilterComposer f) f,
  ) {
    final $$ReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnItems,
      getReferencedColumn: (t) => t.returnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.returnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReturnInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReturnInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> returnItemsRefs<T extends Object>(
    Expression<T> Function($$ReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$ReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.returnItems,
      getReferencedColumn: (t) => t.returnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.returnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReturnInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnInvoicesTable,
          ReturnInvoice,
          $$ReturnInvoicesTableFilterComposer,
          $$ReturnInvoicesTableOrderingComposer,
          $$ReturnInvoicesTableAnnotationComposer,
          $$ReturnInvoicesTableCreateCompanionBuilder,
          $$ReturnInvoicesTableUpdateCompanionBuilder,
          (ReturnInvoice, $$ReturnInvoicesTableReferences),
          ReturnInvoice,
          PrefetchHooks Function({bool supplierId, bool returnItemsRefs})
        > {
  $$ReturnInvoicesTableTableManager(
    _$AppDatabase db,
    $ReturnInvoicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<DateTime> returnDate = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discountPercentage = const Value.absent(),
                Value<double> finalAmount = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnInvoicesCompanion(
                id: id,
                libraryId: libraryId,
                supplierId: supplierId,
                returnDate: returnDate,
                totalAmount: totalAmount,
                discountPercentage: discountPercentage,
                finalAmount: finalAmount,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String supplierId,
                required DateTime returnDate,
                required double totalAmount,
                Value<double> discountPercentage = const Value.absent(),
                required double finalAmount,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnInvoicesCompanion.insert(
                id: id,
                libraryId: libraryId,
                supplierId: supplierId,
                returnDate: returnDate,
                totalAmount: totalAmount,
                discountPercentage: discountPercentage,
                finalAmount: finalAmount,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReturnInvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({supplierId = false, returnItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (returnItemsRefs) db.returnItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$ReturnInvoicesTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$ReturnInvoicesTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (returnItemsRefs)
                        await $_getPrefetchedData<
                          ReturnInvoice,
                          $ReturnInvoicesTable,
                          ReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$ReturnInvoicesTableReferences
                              ._returnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReturnInvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).returnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.returnId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReturnInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnInvoicesTable,
      ReturnInvoice,
      $$ReturnInvoicesTableFilterComposer,
      $$ReturnInvoicesTableOrderingComposer,
      $$ReturnInvoicesTableAnnotationComposer,
      $$ReturnInvoicesTableCreateCompanionBuilder,
      $$ReturnInvoicesTableUpdateCompanionBuilder,
      (ReturnInvoice, $$ReturnInvoicesTableReferences),
      ReturnInvoice,
      PrefetchHooks Function({bool supplierId, bool returnItemsRefs})
    >;
typedef $$ReturnItemsTableCreateCompanionBuilder =
    ReturnItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      required String returnId,
      required String bookId,
      required int quantity,
      required double unitCostAtReturn,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$ReturnItemsTableUpdateCompanionBuilder =
    ReturnItemsCompanion Function({
      Value<String> id,
      Value<String?> libraryId,
      Value<String> returnId,
      Value<String> bookId,
      Value<int> quantity,
      Value<double> unitCostAtReturn,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$ReturnItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ReturnItemsTable, ReturnItem> {
  $$ReturnItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReturnInvoicesTable _returnIdTable(_$AppDatabase db) =>
      db.returnInvoices.createAlias(
        $_aliasNameGenerator(db.returnItems.returnId, db.returnInvoices.id),
      );

  $$ReturnInvoicesTableProcessedTableManager get returnId {
    final $_column = $_itemColumn<String>('return_id')!;

    final manager = $$ReturnInvoicesTableTableManager(
      $_db,
      $_db.returnInvoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_returnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.returnItems.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReturnItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnItemsTable> {
  $$ReturnItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCostAtReturn => $composableBuilder(
    column: $table.unitCostAtReturn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$ReturnInvoicesTableFilterComposer get returnId {
    final $$ReturnInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.returnInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.returnInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReturnItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnItemsTable> {
  $$ReturnItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCostAtReturn => $composableBuilder(
    column: $table.unitCostAtReturn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReturnInvoicesTableOrderingComposer get returnId {
    final $$ReturnInvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.returnInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnInvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.returnInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReturnItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnItemsTable> {
  $$ReturnItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitCostAtReturn => $composableBuilder(
    column: $table.unitCostAtReturn,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$ReturnInvoicesTableAnnotationComposer get returnId {
    final $$ReturnInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.returnInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReturnInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.returnInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReturnItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnItemsTable,
          ReturnItem,
          $$ReturnItemsTableFilterComposer,
          $$ReturnItemsTableOrderingComposer,
          $$ReturnItemsTableAnnotationComposer,
          $$ReturnItemsTableCreateCompanionBuilder,
          $$ReturnItemsTableUpdateCompanionBuilder,
          (ReturnItem, $$ReturnItemsTableReferences),
          ReturnItem,
          PrefetchHooks Function({bool returnId, bool bookId})
        > {
  $$ReturnItemsTableTableManager(_$AppDatabase db, $ReturnItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String> returnId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitCostAtReturn = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnItemsCompanion(
                id: id,
                libraryId: libraryId,
                returnId: returnId,
                bookId: bookId,
                quantity: quantity,
                unitCostAtReturn: unitCostAtReturn,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                required String returnId,
                required String bookId,
                required int quantity,
                required double unitCostAtReturn,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnItemsCompanion.insert(
                id: id,
                libraryId: libraryId,
                returnId: returnId,
                bookId: bookId,
                quantity: quantity,
                unitCostAtReturn: unitCostAtReturn,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReturnItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({returnId = false, bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (returnId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.returnId,
                                referencedTable: $$ReturnItemsTableReferences
                                    ._returnIdTable(db),
                                referencedColumn: $$ReturnItemsTableReferences
                                    ._returnIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$ReturnItemsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$ReturnItemsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReturnItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnItemsTable,
      ReturnItem,
      $$ReturnItemsTableFilterComposer,
      $$ReturnItemsTableOrderingComposer,
      $$ReturnItemsTableAnnotationComposer,
      $$ReturnItemsTableCreateCompanionBuilder,
      $$ReturnItemsTableUpdateCompanionBuilder,
      (ReturnItem, $$ReturnItemsTableReferences),
      ReturnItem,
      PrefetchHooks Function({bool returnId, bool bookId})
    >;
typedef $$GradeTargetsTableCreateCompanionBuilder =
    GradeTargetsCompanion Function({
      Value<String> id,
      required String grade,
      required int studentCount,
      Value<String?> libraryId,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$GradeTargetsTableUpdateCompanionBuilder =
    GradeTargetsCompanion Function({
      Value<String> id,
      Value<String> grade,
      Value<int> studentCount,
      Value<String?> libraryId,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$GradeTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $GradeTargetsTable> {
  $$GradeTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentCount => $composableBuilder(
    column: $table.studentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GradeTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $GradeTargetsTable> {
  $$GradeTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentCount => $composableBuilder(
    column: $table.studentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GradeTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradeTargetsTable> {
  $$GradeTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get studentCount => $composableBuilder(
    column: $table.studentCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$GradeTargetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradeTargetsTable,
          GradeTarget,
          $$GradeTargetsTableFilterComposer,
          $$GradeTargetsTableOrderingComposer,
          $$GradeTargetsTableAnnotationComposer,
          $$GradeTargetsTableCreateCompanionBuilder,
          $$GradeTargetsTableUpdateCompanionBuilder,
          (
            GradeTarget,
            BaseReferences<_$AppDatabase, $GradeTargetsTable, GradeTarget>,
          ),
          GradeTarget,
          PrefetchHooks Function()
        > {
  $$GradeTargetsTableTableManager(_$AppDatabase db, $GradeTargetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradeTargetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradeTargetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradeTargetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<int> studentCount = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GradeTargetsCompanion(
                id: id,
                grade: grade,
                studentCount: studentCount,
                libraryId: libraryId,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String grade,
                required int studentCount,
                Value<String?> libraryId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GradeTargetsCompanion.insert(
                id: id,
                grade: grade,
                studentCount: studentCount,
                libraryId: libraryId,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GradeTargetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradeTargetsTable,
      GradeTarget,
      $$GradeTargetsTableFilterComposer,
      $$GradeTargetsTableOrderingComposer,
      $$GradeTargetsTableAnnotationComposer,
      $$GradeTargetsTableCreateCompanionBuilder,
      $$GradeTargetsTableUpdateCompanionBuilder,
      (
        GradeTarget,
        BaseReferences<_$AppDatabase, $GradeTargetsTable, GradeTarget>,
      ),
      GradeTarget,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<DateTime?> seasonEndDate,
      Value<int> defaultLeadTime,
      Value<String?> libraryId,
      Value<String?> licenseKey,
      Value<DateTime?> licenseExpiryDate,
      Value<String> licenseStatus,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<DateTime?> seasonEndDate,
      Value<int> defaultLeadTime,
      Value<String?> libraryId,
      Value<String?> licenseKey,
      Value<DateTime?> licenseExpiryDate,
      Value<String> licenseStatus,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get seasonEndDate => $composableBuilder(
    column: $table.seasonEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultLeadTime => $composableBuilder(
    column: $table.defaultLeadTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get licenseExpiryDate => $composableBuilder(
    column: $table.licenseExpiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseStatus => $composableBuilder(
    column: $table.licenseStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get seasonEndDate => $composableBuilder(
    column: $table.seasonEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultLeadTime => $composableBuilder(
    column: $table.defaultLeadTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get licenseExpiryDate => $composableBuilder(
    column: $table.licenseExpiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseStatus => $composableBuilder(
    column: $table.licenseStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get seasonEndDate => $composableBuilder(
    column: $table.seasonEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultLeadTime => $composableBuilder(
    column: $table.defaultLeadTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get licenseExpiryDate => $composableBuilder(
    column: $table.licenseExpiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenseStatus => $composableBuilder(
    column: $table.licenseStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime?> seasonEndDate = const Value.absent(),
                Value<int> defaultLeadTime = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String?> licenseKey = const Value.absent(),
                Value<DateTime?> licenseExpiryDate = const Value.absent(),
                Value<String> licenseStatus = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                seasonEndDate: seasonEndDate,
                defaultLeadTime: defaultLeadTime,
                libraryId: libraryId,
                licenseKey: licenseKey,
                licenseExpiryDate: licenseExpiryDate,
                licenseStatus: licenseStatus,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime?> seasonEndDate = const Value.absent(),
                Value<int> defaultLeadTime = const Value.absent(),
                Value<String?> libraryId = const Value.absent(),
                Value<String?> licenseKey = const Value.absent(),
                Value<DateTime?> licenseExpiryDate = const Value.absent(),
                Value<String> licenseStatus = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                seasonEndDate: seasonEndDate,
                defaultLeadTime: defaultLeadTime,
                libraryId: libraryId,
                licenseKey: licenseKey,
                licenseExpiryDate: licenseExpiryDate,
                licenseStatus: licenseStatus,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$PurchaseInvoicesTableTableManager get purchaseInvoices =>
      $$PurchaseInvoicesTableTableManager(_db, _db.purchaseInvoices);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ReservationsTableTableManager get reservations =>
      $$ReservationsTableTableManager(_db, _db.reservations);
  $$SalesReturnsTableTableManager get salesReturns =>
      $$SalesReturnsTableTableManager(_db, _db.salesReturns);
  $$ReturnInvoicesTableTableManager get returnInvoices =>
      $$ReturnInvoicesTableTableManager(_db, _db.returnInvoices);
  $$ReturnItemsTableTableManager get returnItems =>
      $$ReturnItemsTableTableManager(_db, _db.returnItems);
  $$GradeTargetsTableTableManager get gradeTargets =>
      $$GradeTargetsTableTableManager(_db, _db.gradeTargets);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
