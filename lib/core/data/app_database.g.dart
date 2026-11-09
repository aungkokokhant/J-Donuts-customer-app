// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class Products extends Table with TableInfo<Products, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Products(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (price_mmk >= 0)',
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (discount_percent BETWEEN 1 AND 100)',
  );
  static const VerificationMeta _imageKeyMeta = const VerificationMeta(
    'imageKey',
  );
  late final GeneratedColumn<String> imageKey = GeneratedColumn<String>(
    'image_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageKey,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('image_key')) {
      context.handle(
        _imageKeyMeta,
        imageKey.isAcceptableOrUnknown(data['image_key']!, _imageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_imageKeyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      imageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_key'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  Products createAlias(String alias) {
    return Products(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageKey;
  final String description;
  const Product({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageKey,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['image_key'] = Variable<String>(imageKey);
    map['description'] = Variable<String>(description);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      imageKey: Value(imageKey),
      description: Value(description),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['price_mmk']),
      isNew: serializer.fromJson<bool>(json['is_new']),
      discountPercent: serializer.fromJson<int?>(json['discount_percent']),
      imageKey: serializer.fromJson<String>(json['image_key']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'price_mmk': serializer.toJson<int>(priceMmk),
      'is_new': serializer.toJson<bool>(isNew),
      'discount_percent': serializer.toJson<int?>(discountPercent),
      'image_key': serializer.toJson<String>(imageKey),
      'description': serializer.toJson<String>(description),
    };
  }

  Product copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? imageKey,
    String? description,
  }) => Product(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    imageKey: imageKey ?? this.imageKey,
    description: description ?? this.description,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      imageKey: data.imageKey.present ? data.imageKey.value : this.imageKey,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageKey: $imageKey, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageKey,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.imageKey == this.imageKey &&
          other.description == this.description);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> imageKey;
  final Value<String> description;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageKey = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,
    this.discountPercent = const Value.absent(),
    required String imageKey,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       isNew = Value(isNew),
       imageKey = Value(imageKey),
       description = Value(description);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? imageKey,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (imageKey != null) 'image_key': imageKey,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? imageKey,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      imageKey: imageKey ?? this.imageKey,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (imageKey.present) {
      map['image_key'] = Variable<String>(imageKey.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageKey: $imageKey, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Banners extends Table with TableInfo<Banners, Banner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Banners(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _imageKeyMeta = const VerificationMeta(
    'imageKey',
  );
  late final GeneratedColumn<String> imageKey = GeneratedColumn<String>(
    'image_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, label, imageKey, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<Banner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('image_key')) {
      context.handle(
        _imageKeyMeta,
        imageKey.isAcceptableOrUnknown(data['image_key']!, _imageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_imageKeyMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Banner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Banner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      imageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_key'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  Banners createAlias(String alias) {
    return Banners(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Banner extends DataClass implements Insertable<Banner> {
  final String id;
  final String title;
  final String label;
  final String imageKey;
  final int position;
  const Banner({
    required this.id,
    required this.title,
    required this.label,
    required this.imageKey,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['label'] = Variable<String>(label);
    map['image_key'] = Variable<String>(imageKey);
    map['position'] = Variable<int>(position);
    return map;
  }

  BannersCompanion toCompanion(bool nullToAbsent) {
    return BannersCompanion(
      id: Value(id),
      title: Value(title),
      label: Value(label),
      imageKey: Value(imageKey),
      position: Value(position),
    );
  }

  factory Banner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Banner(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      label: serializer.fromJson<String>(json['label']),
      imageKey: serializer.fromJson<String>(json['image_key']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'label': serializer.toJson<String>(label),
      'image_key': serializer.toJson<String>(imageKey),
      'position': serializer.toJson<int>(position),
    };
  }

  Banner copyWith({
    String? id,
    String? title,
    String? label,
    String? imageKey,
    int? position,
  }) => Banner(
    id: id ?? this.id,
    title: title ?? this.title,
    label: label ?? this.label,
    imageKey: imageKey ?? this.imageKey,
    position: position ?? this.position,
  );
  Banner copyWithCompanion(BannersCompanion data) {
    return Banner(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      label: data.label.present ? data.label.value : this.label,
      imageKey: data.imageKey.present ? data.imageKey.value : this.imageKey,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Banner(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('label: $label, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, label, imageKey, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Banner &&
          other.id == this.id &&
          other.title == this.title &&
          other.label == this.label &&
          other.imageKey == this.imageKey &&
          other.position == this.position);
}

class BannersCompanion extends UpdateCompanion<Banner> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> label;
  final Value<String> imageKey;
  final Value<int> position;
  final Value<int> rowid;
  const BannersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.label = const Value.absent(),
    this.imageKey = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BannersCompanion.insert({
    required String id,
    required String title,
    required String label,
    required String imageKey,
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       label = Value(label),
       imageKey = Value(imageKey),
       position = Value(position);
  static Insertable<Banner> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? label,
    Expression<String>? imageKey,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (label != null) 'label': label,
      if (imageKey != null) 'image_key': imageKey,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BannersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? label,
    Value<String>? imageKey,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return BannersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      label: label ?? this.label,
      imageKey: imageKey ?? this.imageKey,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (imageKey.present) {
      map['image_key'] = Variable<String>(imageKey.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('label: $label, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Sections extends Table with TableInfo<Sections, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Sections(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Section> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  Sections createAlias(String alias) {
    return Sections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Section extends DataClass implements Insertable<Section> {
  final String id;
  final String title;
  final int position;
  const Section({
    required this.id,
    required this.title,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['position'] = Variable<int>(position);
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      title: Value(title),
      position: Value(position),
    );
  }

  factory Section.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'position': serializer.toJson<int>(position),
    };
  }

  Section copyWith({String? id, String? title, int? position}) => Section(
    id: id ?? this.id,
    title: title ?? this.title,
    position: position ?? this.position,
  );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.title == this.title &&
          other.position == this.position);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> position;
  final Value<int> rowid;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionsCompanion.insert({
    required String id,
    required String title,
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       position = Value(position);
  static Insertable<Section> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SectionProducts extends Table
    with TableInfo<SectionProducts, SectionProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SectionProducts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES sections(id)',
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id)',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [sectionId, productId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'section_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sectionId, productId};
  @override
  SectionProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionProduct(
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  SectionProducts createAlias(String alias) {
    return SectionProducts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(section_id, product_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class SectionProduct extends DataClass implements Insertable<SectionProduct> {
  final String sectionId;
  final String productId;
  final int position;
  const SectionProduct({
    required this.sectionId,
    required this.productId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['section_id'] = Variable<String>(sectionId);
    map['product_id'] = Variable<String>(productId);
    map['position'] = Variable<int>(position);
    return map;
  }

  SectionProductsCompanion toCompanion(bool nullToAbsent) {
    return SectionProductsCompanion(
      sectionId: Value(sectionId),
      productId: Value(productId),
      position: Value(position),
    );
  }

  factory SectionProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionProduct(
      sectionId: serializer.fromJson<String>(json['section_id']),
      productId: serializer.fromJson<String>(json['product_id']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'section_id': serializer.toJson<String>(sectionId),
      'product_id': serializer.toJson<String>(productId),
      'position': serializer.toJson<int>(position),
    };
  }

  SectionProduct copyWith({
    String? sectionId,
    String? productId,
    int? position,
  }) => SectionProduct(
    sectionId: sectionId ?? this.sectionId,
    productId: productId ?? this.productId,
    position: position ?? this.position,
  );
  SectionProduct copyWithCompanion(SectionProductsCompanion data) {
    return SectionProduct(
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionProduct(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sectionId, productId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionProduct &&
          other.sectionId == this.sectionId &&
          other.productId == this.productId &&
          other.position == this.position);
}

class SectionProductsCompanion extends UpdateCompanion<SectionProduct> {
  final Value<String> sectionId;
  final Value<String> productId;
  final Value<int> position;
  final Value<int> rowid;
  const SectionProductsCompanion({
    this.sectionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionProductsCompanion.insert({
    required String sectionId,
    required String productId,
    required int position,
    this.rowid = const Value.absent(),
  }) : sectionId = Value(sectionId),
       productId = Value(productId),
       position = Value(position);
  static Insertable<SectionProduct> custom({
    Expression<String>? sectionId,
    Expression<String>? productId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sectionId != null) 'section_id': sectionId,
      if (productId != null) 'product_id': productId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionProductsCompanion copyWith({
    Value<String>? sectionId,
    Value<String>? productId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return SectionProductsCompanion(
      sectionId: sectionId ?? this.sectionId,
      productId: productId ?? this.productId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductsCompanion(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Shops extends Table with TableInfo<Shops, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Shops(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _imageKeyMeta = const VerificationMeta(
    'imageKey',
  );
  late final GeneratedColumn<String> imageKey = GeneratedColumn<String>(
    'image_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, address, imageKey, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_key')) {
      context.handle(
        _imageKeyMeta,
        imageKey.isAcceptableOrUnknown(data['image_key']!, _imageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_imageKeyMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_key'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  Shops createAlias(String alias) {
    return Shops(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Shop extends DataClass implements Insertable<Shop> {
  final String id;
  final String name;
  final String address;
  final String imageKey;
  final int position;
  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.imageKey,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['image_key'] = Variable<String>(imageKey);
    map['position'] = Variable<int>(position);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      imageKey: Value(imageKey),
      position: Value(position),
    );
  }

  factory Shop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      imageKey: serializer.fromJson<String>(json['image_key']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'image_key': serializer.toJson<String>(imageKey),
      'position': serializer.toJson<int>(position),
    };
  }

  Shop copyWith({
    String? id,
    String? name,
    String? address,
    String? imageKey,
    int? position,
  }) => Shop(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    imageKey: imageKey ?? this.imageKey,
    position: position ?? this.position,
  );
  Shop copyWithCompanion(ShopsCompanion data) {
    return Shop(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      imageKey: data.imageKey.present ? data.imageKey.value : this.imageKey,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, imageKey, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.imageKey == this.imageKey &&
          other.position == this.position);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> imageKey;
  final Value<int> position;
  final Value<int> rowid;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.imageKey = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String imageKey,
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       imageKey = Value(imageKey),
       position = Value(position);
  static Insertable<Shop> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? imageKey,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (imageKey != null) 'image_key': imageKey,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? imageKey,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imageKey: imageKey ?? this.imageKey,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageKey.present) {
      map['image_key'] = Variable<String>(imageKey.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Members extends Table with TableInfo<Members, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Members(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _imageKeyMeta = const VerificationMeta(
    'imageKey',
  );
  late final GeneratedColumn<String> imageKey = GeneratedColumn<String>(
    'image_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _nextTierMeta = const VerificationMeta(
    'nextTier',
  );
  late final GeneratedColumn<String> nextTier = GeneratedColumn<String>(
    'next_tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _pointsToNextTierMeta = const VerificationMeta(
    'pointsToNextTier',
  );
  late final GeneratedColumn<int> pointsToNextTier = GeneratedColumn<int>(
    'points_to_next_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (points_to_next_tier >= 0)',
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (total_points >= 0)',
  );
  static const VerificationMeta _tierStartPointsMeta = const VerificationMeta(
    'tierStartPoints',
  );
  late final GeneratedColumn<int> tierStartPoints = GeneratedColumn<int>(
    'tier_start_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (tier_start_points >= 0)',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (notification_count >= 0)',
  );
  static const VerificationMeta _availableRewardsMeta = const VerificationMeta(
    'availableRewards',
  );
  late final GeneratedColumn<int> availableRewards = GeneratedColumn<int>(
    'available_rewards',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (available_rewards >= 0)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageKey,
    tier,
    nextTier,
    pointsToNextTier,
    totalPoints,
    tierStartPoints,
    notificationCount,
    availableRewards,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_key')) {
      context.handle(
        _imageKeyMeta,
        imageKey.isAcceptableOrUnknown(data['image_key']!, _imageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_imageKeyMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('next_tier')) {
      context.handle(
        _nextTierMeta,
        nextTier.isAcceptableOrUnknown(data['next_tier']!, _nextTierMeta),
      );
    } else if (isInserting) {
      context.missing(_nextTierMeta);
    }
    if (data.containsKey('points_to_next_tier')) {
      context.handle(
        _pointsToNextTierMeta,
        pointsToNextTier.isAcceptableOrUnknown(
          data['points_to_next_tier']!,
          _pointsToNextTierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsToNextTierMeta);
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPointsMeta);
    }
    if (data.containsKey('tier_start_points')) {
      context.handle(
        _tierStartPointsMeta,
        tierStartPoints.isAcceptableOrUnknown(
          data['tier_start_points']!,
          _tierStartPointsMeta,
        ),
      );
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationCountMeta);
    }
    if (data.containsKey('available_rewards')) {
      context.handle(
        _availableRewardsMeta,
        availableRewards.isAcceptableOrUnknown(
          data['available_rewards']!,
          _availableRewardsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableRewardsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_key'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      nextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_tier'],
      )!,
      pointsToNextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_to_next_tier'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      tierStartPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tier_start_points'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
      availableRewards: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_rewards'],
      )!,
    );
  }

  @override
  Members createAlias(String alias) {
    return Members(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String name;
  final String imageKey;
  final String tier;
  final String nextTier;
  final int pointsToNextTier;
  final int totalPoints;
  final int tierStartPoints;
  final int notificationCount;
  final int availableRewards;
  const Member({
    required this.id,
    required this.name,
    required this.imageKey,
    required this.tier,
    required this.nextTier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.tierStartPoints,
    required this.notificationCount,
    required this.availableRewards,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['image_key'] = Variable<String>(imageKey);
    map['tier'] = Variable<String>(tier);
    map['next_tier'] = Variable<String>(nextTier);
    map['points_to_next_tier'] = Variable<int>(pointsToNextTier);
    map['total_points'] = Variable<int>(totalPoints);
    map['tier_start_points'] = Variable<int>(tierStartPoints);
    map['notification_count'] = Variable<int>(notificationCount);
    map['available_rewards'] = Variable<int>(availableRewards);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      imageKey: Value(imageKey),
      tier: Value(tier),
      nextTier: Value(nextTier),
      pointsToNextTier: Value(pointsToNextTier),
      totalPoints: Value(totalPoints),
      tierStartPoints: Value(tierStartPoints),
      notificationCount: Value(notificationCount),
      availableRewards: Value(availableRewards),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageKey: serializer.fromJson<String>(json['image_key']),
      tier: serializer.fromJson<String>(json['tier']),
      nextTier: serializer.fromJson<String>(json['next_tier']),
      pointsToNextTier: serializer.fromJson<int>(json['points_to_next_tier']),
      totalPoints: serializer.fromJson<int>(json['total_points']),
      tierStartPoints: serializer.fromJson<int>(json['tier_start_points']),
      notificationCount: serializer.fromJson<int>(json['notification_count']),
      availableRewards: serializer.fromJson<int>(json['available_rewards']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'image_key': serializer.toJson<String>(imageKey),
      'tier': serializer.toJson<String>(tier),
      'next_tier': serializer.toJson<String>(nextTier),
      'points_to_next_tier': serializer.toJson<int>(pointsToNextTier),
      'total_points': serializer.toJson<int>(totalPoints),
      'tier_start_points': serializer.toJson<int>(tierStartPoints),
      'notification_count': serializer.toJson<int>(notificationCount),
      'available_rewards': serializer.toJson<int>(availableRewards),
    };
  }

  Member copyWith({
    String? id,
    String? name,
    String? imageKey,
    String? tier,
    String? nextTier,
    int? pointsToNextTier,
    int? totalPoints,
    int? tierStartPoints,
    int? notificationCount,
    int? availableRewards,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    imageKey: imageKey ?? this.imageKey,
    tier: tier ?? this.tier,
    nextTier: nextTier ?? this.nextTier,
    pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
    totalPoints: totalPoints ?? this.totalPoints,
    tierStartPoints: tierStartPoints ?? this.tierStartPoints,
    notificationCount: notificationCount ?? this.notificationCount,
    availableRewards: availableRewards ?? this.availableRewards,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageKey: data.imageKey.present ? data.imageKey.value : this.imageKey,
      tier: data.tier.present ? data.tier.value : this.tier,
      nextTier: data.nextTier.present ? data.nextTier.value : this.nextTier,
      pointsToNextTier: data.pointsToNextTier.present
          ? data.pointsToNextTier.value
          : this.pointsToNextTier,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      tierStartPoints: data.tierStartPoints.present
          ? data.tierStartPoints.value
          : this.tierStartPoints,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
      availableRewards: data.availableRewards.present
          ? data.availableRewards.value
          : this.availableRewards,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageKey: $imageKey, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('tierStartPoints: $tierStartPoints, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('availableRewards: $availableRewards')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    imageKey,
    tier,
    nextTier,
    pointsToNextTier,
    totalPoints,
    tierStartPoints,
    notificationCount,
    availableRewards,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageKey == this.imageKey &&
          other.tier == this.tier &&
          other.nextTier == this.nextTier &&
          other.pointsToNextTier == this.pointsToNextTier &&
          other.totalPoints == this.totalPoints &&
          other.tierStartPoints == this.tierStartPoints &&
          other.notificationCount == this.notificationCount &&
          other.availableRewards == this.availableRewards);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> imageKey;
  final Value<String> tier;
  final Value<String> nextTier;
  final Value<int> pointsToNextTier;
  final Value<int> totalPoints;
  final Value<int> tierStartPoints;
  final Value<int> notificationCount;
  final Value<int> availableRewards;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageKey = const Value.absent(),
    this.tier = const Value.absent(),
    this.nextTier = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.tierStartPoints = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.availableRewards = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String name,
    required String imageKey,
    required String tier,
    required String nextTier,
    required int pointsToNextTier,
    required int totalPoints,
    this.tierStartPoints = const Value.absent(),
    required int notificationCount,
    required int availableRewards,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       imageKey = Value(imageKey),
       tier = Value(tier),
       nextTier = Value(nextTier),
       pointsToNextTier = Value(pointsToNextTier),
       totalPoints = Value(totalPoints),
       notificationCount = Value(notificationCount),
       availableRewards = Value(availableRewards);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? imageKey,
    Expression<String>? tier,
    Expression<String>? nextTier,
    Expression<int>? pointsToNextTier,
    Expression<int>? totalPoints,
    Expression<int>? tierStartPoints,
    Expression<int>? notificationCount,
    Expression<int>? availableRewards,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageKey != null) 'image_key': imageKey,
      if (tier != null) 'tier': tier,
      if (nextTier != null) 'next_tier': nextTier,
      if (pointsToNextTier != null) 'points_to_next_tier': pointsToNextTier,
      if (totalPoints != null) 'total_points': totalPoints,
      if (tierStartPoints != null) 'tier_start_points': tierStartPoints,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (availableRewards != null) 'available_rewards': availableRewards,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? imageKey,
    Value<String>? tier,
    Value<String>? nextTier,
    Value<int>? pointsToNextTier,
    Value<int>? totalPoints,
    Value<int>? tierStartPoints,
    Value<int>? notificationCount,
    Value<int>? availableRewards,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageKey: imageKey ?? this.imageKey,
      tier: tier ?? this.tier,
      nextTier: nextTier ?? this.nextTier,
      pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
      totalPoints: totalPoints ?? this.totalPoints,
      tierStartPoints: tierStartPoints ?? this.tierStartPoints,
      notificationCount: notificationCount ?? this.notificationCount,
      availableRewards: availableRewards ?? this.availableRewards,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageKey.present) {
      map['image_key'] = Variable<String>(imageKey.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (nextTier.present) {
      map['next_tier'] = Variable<String>(nextTier.value);
    }
    if (pointsToNextTier.present) {
      map['points_to_next_tier'] = Variable<int>(pointsToNextTier.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (tierStartPoints.present) {
      map['tier_start_points'] = Variable<int>(tierStartPoints.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (availableRewards.present) {
      map['available_rewards'] = Variable<int>(availableRewards.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageKey: $imageKey, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('tierStartPoints: $tierStartPoints, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('availableRewards: $availableRewards, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Challenges extends Table with TableInfo<Challenges, Challenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Challenges(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES members(id)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (kind IN (\'donut\', \'coffee\'))',
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  late final GeneratedColumn<int> completed = GeneratedColumn<int>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (completed >= 0)',
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (target > 0 AND completed <= target)',
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (points >= 0)',
  );
  static const VerificationMeta _imageKeyMeta = const VerificationMeta(
    'imageKey',
  );
  late final GeneratedColumn<String> imageKey = GeneratedColumn<String>(
    'image_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberId,
    title,
    kind,
    completed,
    target,
    points,
    imageKey,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Challenge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('image_key')) {
      context.handle(
        _imageKeyMeta,
        imageKey.isAcceptableOrUnknown(data['image_key']!, _imageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_imageKeyMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Challenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Challenge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      imageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_key'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  Challenges createAlias(String alias) {
    return Challenges(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Challenge extends DataClass implements Insertable<Challenge> {
  final String id;
  final String memberId;
  final String title;
  final String kind;
  final int completed;
  final int target;
  final int points;
  final String imageKey;
  final int position;
  const Challenge({
    required this.id,
    required this.memberId,
    required this.title,
    required this.kind,
    required this.completed,
    required this.target,
    required this.points,
    required this.imageKey,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['member_id'] = Variable<String>(memberId);
    map['title'] = Variable<String>(title);
    map['kind'] = Variable<String>(kind);
    map['completed'] = Variable<int>(completed);
    map['target'] = Variable<int>(target);
    map['points'] = Variable<int>(points);
    map['image_key'] = Variable<String>(imageKey);
    map['position'] = Variable<int>(position);
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      memberId: Value(memberId),
      title: Value(title),
      kind: Value(kind),
      completed: Value(completed),
      target: Value(target),
      points: Value(points),
      imageKey: Value(imageKey),
      position: Value(position),
    );
  }

  factory Challenge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Challenge(
      id: serializer.fromJson<String>(json['id']),
      memberId: serializer.fromJson<String>(json['member_id']),
      title: serializer.fromJson<String>(json['title']),
      kind: serializer.fromJson<String>(json['kind']),
      completed: serializer.fromJson<int>(json['completed']),
      target: serializer.fromJson<int>(json['target']),
      points: serializer.fromJson<int>(json['points']),
      imageKey: serializer.fromJson<String>(json['image_key']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'member_id': serializer.toJson<String>(memberId),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(kind),
      'completed': serializer.toJson<int>(completed),
      'target': serializer.toJson<int>(target),
      'points': serializer.toJson<int>(points),
      'image_key': serializer.toJson<String>(imageKey),
      'position': serializer.toJson<int>(position),
    };
  }

  Challenge copyWith({
    String? id,
    String? memberId,
    String? title,
    String? kind,
    int? completed,
    int? target,
    int? points,
    String? imageKey,
    int? position,
  }) => Challenge(
    id: id ?? this.id,
    memberId: memberId ?? this.memberId,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    completed: completed ?? this.completed,
    target: target ?? this.target,
    points: points ?? this.points,
    imageKey: imageKey ?? this.imageKey,
    position: position ?? this.position,
  );
  Challenge copyWithCompanion(ChallengesCompanion data) {
    return Challenge(
      id: data.id.present ? data.id.value : this.id,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      completed: data.completed.present ? data.completed.value : this.completed,
      target: data.target.present ? data.target.value : this.target,
      points: data.points.present ? data.points.value : this.points,
      imageKey: data.imageKey.present ? data.imageKey.value : this.imageKey,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Challenge(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('completed: $completed, ')
          ..write('target: $target, ')
          ..write('points: $points, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    memberId,
    title,
    kind,
    completed,
    target,
    points,
    imageKey,
    position,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Challenge &&
          other.id == this.id &&
          other.memberId == this.memberId &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.completed == this.completed &&
          other.target == this.target &&
          other.points == this.points &&
          other.imageKey == this.imageKey &&
          other.position == this.position);
}

class ChallengesCompanion extends UpdateCompanion<Challenge> {
  final Value<String> id;
  final Value<String> memberId;
  final Value<String> title;
  final Value<String> kind;
  final Value<int> completed;
  final Value<int> target;
  final Value<int> points;
  final Value<String> imageKey;
  final Value<int> position;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.memberId = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.completed = const Value.absent(),
    this.target = const Value.absent(),
    this.points = const Value.absent(),
    this.imageKey = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String memberId,
    required String title,
    required String kind,
    required int completed,
    required int target,
    required int points,
    required String imageKey,
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       memberId = Value(memberId),
       title = Value(title),
       kind = Value(kind),
       completed = Value(completed),
       target = Value(target),
       points = Value(points),
       imageKey = Value(imageKey),
       position = Value(position);
  static Insertable<Challenge> custom({
    Expression<String>? id,
    Expression<String>? memberId,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<int>? completed,
    Expression<int>? target,
    Expression<int>? points,
    Expression<String>? imageKey,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberId != null) 'member_id': memberId,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (completed != null) 'completed': completed,
      if (target != null) 'target': target,
      if (points != null) 'points': points,
      if (imageKey != null) 'image_key': imageKey,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? memberId,
    Value<String>? title,
    Value<String>? kind,
    Value<int>? completed,
    Value<int>? target,
    Value<int>? points,
    Value<String>? imageKey,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      completed: completed ?? this.completed,
      target: target ?? this.target,
      points: points ?? this.points,
      imageKey: imageKey ?? this.imageKey,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (completed.present) {
      map['completed'] = Variable<int>(completed.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (imageKey.present) {
      map['image_key'] = Variable<String>(imageKey.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('completed: $completed, ')
          ..write('target: $target, ')
          ..write('points: $points, ')
          ..write('imageKey: $imageKey, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class RegisteredUsers extends Table
    with TableInfo<RegisteredUsers, RegisteredUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RegisteredUsers(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [phone, firstName, lastName, birthDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registered_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegisteredUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phone};
  @override
  RegisteredUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegisteredUser(
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
    );
  }

  @override
  RegisteredUsers createAlias(String alias) {
    return RegisteredUsers(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RegisteredUser extends DataClass implements Insertable<RegisteredUser> {
  final String phone;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  const RegisteredUser({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone'] = Variable<String>(phone);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['birth_date'] = Variable<DateTime>(birthDate);
    return map;
  }

  RegisteredUsersCompanion toCompanion(bool nullToAbsent) {
    return RegisteredUsersCompanion(
      phone: Value(phone),
      firstName: Value(firstName),
      lastName: Value(lastName),
      birthDate: Value(birthDate),
    );
  }

  factory RegisteredUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegisteredUser(
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String>(json['first_name']),
      lastName: serializer.fromJson<String>(json['last_name']),
      birthDate: serializer.fromJson<DateTime>(json['birth_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phone': serializer.toJson<String>(phone),
      'first_name': serializer.toJson<String>(firstName),
      'last_name': serializer.toJson<String>(lastName),
      'birth_date': serializer.toJson<DateTime>(birthDate),
    };
  }

  RegisteredUser copyWith({
    String? phone,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
  }) => RegisteredUser(
    phone: phone ?? this.phone,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
  );
  RegisteredUser copyWithCompanion(RegisteredUsersCompanion data) {
    return RegisteredUser(
      phone: data.phone.present ? data.phone.value : this.phone,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegisteredUser(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(phone, firstName, lastName, birthDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisteredUser &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.birthDate == this.birthDate);
}

class RegisteredUsersCompanion extends UpdateCompanion<RegisteredUser> {
  final Value<String> phone;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<DateTime> birthDate;
  final Value<int> rowid;
  const RegisteredUsersCompanion({
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegisteredUsersCompanion.insert({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    this.rowid = const Value.absent(),
  }) : phone = Value(phone),
       firstName = Value(firstName),
       lastName = Value(lastName),
       birthDate = Value(birthDate);
  static Insertable<RegisteredUser> custom({
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? birthDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (birthDate != null) 'birth_date': birthDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegisteredUsersCompanion copyWith({
    Value<String>? phone,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<DateTime>? birthDate,
    Value<int>? rowid,
  }) {
    return RegisteredUsersCompanion(
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegisteredUsersCompanion(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final Products products = Products(this);
  late final Banners banners = Banners(this);
  late final Sections sections = Sections(this);
  late final SectionProducts sectionProducts = SectionProducts(this);
  late final Shops shops = Shops(this);
  late final Members members = Members(this);
  late final Challenges challenges = Challenges(this);
  late final RegisteredUsers registeredUsers = RegisteredUsers(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    banners,
    sections,
    sectionProducts,
    shops,
    members,
    challenges,
    registeredUsers,
  ];
}

typedef $ProductsCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String code,
  required String name,
  required int priceMmk,
  required bool isNew,
  Value<int?> discountPercent,
  required String imageKey,
  required String description,
  Value<int> rowid,
});
typedef $ProductsUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String> name,
  Value<int> priceMmk,
  Value<bool> isNew,
  Value<int?> discountPercent,
  Value<String> imageKey,
  Value<String> description,
  Value<int> rowid,
});

final class $ProductsReferences
    extends BaseReferences<_$AppDatabase, Products, Product> {
  $ProductsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<SectionProducts, List<SectionProduct>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'products__id__section_products__product_id',
  );

  $SectionProductsProcessedTableManager get sectionProductsRefs {
    final manager = $SectionProductsTableManager(
      $_db,
      $_db.sectionProducts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ProductsFilterComposer extends Composer<_$AppDatabase, Products> {
  $ProductsFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($SectionProductsFilterComposer f) f,
  ) {
    final $SectionProductsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionProductsFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProductsOrderingComposer extends Composer<_$AppDatabase, Products> {
  $ProductsOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ProductsAnnotationComposer extends Composer<_$AppDatabase, Products> {
  $ProductsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageKey =>
      $composableBuilder(column: $table.imageKey, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($SectionProductsAnnotationComposer a) f,
  ) {
    final $SectionProductsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionProductsAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProductsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Products,
          Product,
          $ProductsFilterComposer,
          $ProductsOrderingComposer,
          $ProductsAnnotationComposer,
          $ProductsCreateCompanionBuilder,
          $ProductsUpdateCompanionBuilder,
          (Product, $ProductsReferences),
          Product,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $ProductsTableManager(_$AppDatabase db, Products table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProductsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProductsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProductsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageKey = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageKey: imageKey,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                required bool isNew,
                Value<int?> discountPercent = const Value.absent(),
                required String imageKey,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageKey: imageKey,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Products, Product>(table),
                  $ProductsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      Product,
                      Products,
                      SectionProduct,
                      SectionProducts
                    >(
                      currentTable: table,
                      referencedTable: $ProductsReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $ProductsReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'product_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $ProductsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Products,
      Product,
      $ProductsFilterComposer,
      $ProductsOrderingComposer,
      $ProductsAnnotationComposer,
      $ProductsCreateCompanionBuilder,
      $ProductsUpdateCompanionBuilder,
      (Product, $ProductsReferences),
      Product,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $BannersCreateCompanionBuilder = BannersCompanion Function({
  required String id,
  required String title,
  required String label,
  required String imageKey,
  required int position,
  Value<int> rowid,
});
typedef $BannersUpdateCompanionBuilder = BannersCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> label,
  Value<String> imageKey,
  Value<int> position,
  Value<int> rowid,
});

class $BannersFilterComposer extends Composer<_$AppDatabase, Banners> {
  $BannersFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $BannersOrderingComposer extends Composer<_$AppDatabase, Banners> {
  $BannersOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $BannersAnnotationComposer extends Composer<_$AppDatabase, Banners> {
  $BannersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get imageKey =>
      $composableBuilder(column: $table.imageKey, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $BannersTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Banners,
          Banner,
          $BannersFilterComposer,
          $BannersOrderingComposer,
          $BannersAnnotationComposer,
          $BannersCreateCompanionBuilder,
          $BannersUpdateCompanionBuilder,
          (Banner, BaseReferences<_$AppDatabase, Banners, Banner>),
          Banner,
          PrefetchHooks Function()
        > {
  $BannersTableManager(_$AppDatabase db, Banners table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $BannersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $BannersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $BannersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> imageKey = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion(
                id: id,
                title: title,
                label: label,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String label,
                required String imageKey,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion.insert(
                id: id,
                title: title,
                label: label,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Banners, Banner>(table),
                  BaseReferences<_$AppDatabase, Banners, Banner>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $BannersProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Banners,
      Banner,
      $BannersFilterComposer,
      $BannersOrderingComposer,
      $BannersAnnotationComposer,
      $BannersCreateCompanionBuilder,
      $BannersUpdateCompanionBuilder,
      (Banner, BaseReferences<_$AppDatabase, Banners, Banner>),
      Banner,
      PrefetchHooks Function()
    >;
typedef $SectionsCreateCompanionBuilder = SectionsCompanion Function({
  required String id,
  required String title,
  required int position,
  Value<int> rowid,
});
typedef $SectionsUpdateCompanionBuilder = SectionsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> position,
  Value<int> rowid,
});

final class $SectionsReferences
    extends BaseReferences<_$AppDatabase, Sections, Section> {
  $SectionsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<SectionProducts, List<SectionProduct>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'sections__id__section_products__section_id',
  );

  $SectionProductsProcessedTableManager get sectionProductsRefs {
    final manager = $SectionProductsTableManager(
      $_db,
      $_db.sectionProducts,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $SectionsFilterComposer extends Composer<_$AppDatabase, Sections> {
  $SectionsFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($SectionProductsFilterComposer f) f,
  ) {
    final $SectionProductsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionProductsFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $SectionsOrderingComposer extends Composer<_$AppDatabase, Sections> {
  $SectionsOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $SectionsAnnotationComposer extends Composer<_$AppDatabase, Sections> {
  $SectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($SectionProductsAnnotationComposer a) f,
  ) {
    final $SectionProductsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionProductsAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $SectionsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Sections,
          Section,
          $SectionsFilterComposer,
          $SectionsOrderingComposer,
          $SectionsAnnotationComposer,
          $SectionsCreateCompanionBuilder,
          $SectionsUpdateCompanionBuilder,
          (Section, $SectionsReferences),
          Section,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $SectionsTableManager(_$AppDatabase db, Sections table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SectionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SectionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SectionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion(
                id: id,
                title: title,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion.insert(
                id: id,
                title: title,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Sections, Section>(table),
                  $SectionsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      Section,
                      Sections,
                      SectionProduct,
                      SectionProducts
                    >(
                      currentTable: table,
                      referencedTable: $SectionsReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $SectionsReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'section_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $SectionsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Sections,
      Section,
      $SectionsFilterComposer,
      $SectionsOrderingComposer,
      $SectionsAnnotationComposer,
      $SectionsCreateCompanionBuilder,
      $SectionsUpdateCompanionBuilder,
      (Section, $SectionsReferences),
      Section,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $SectionProductsCreateCompanionBuilder =
    SectionProductsCompanion Function({
      required String sectionId,
      required String productId,
      required int position,
      Value<int> rowid,
    });
typedef $SectionProductsUpdateCompanionBuilder =
    SectionProductsCompanion Function({
      Value<String> sectionId,
      Value<String> productId,
      Value<int> position,
      Value<int> rowid,
    });

final class $SectionProductsReferences
    extends BaseReferences<_$AppDatabase, SectionProducts, SectionProduct> {
  $SectionProductsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Sections _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('section_products__section_id__sections__id');

  $SectionsProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager = $SectionsTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Products _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('section_products__product_id__products__id');

  $ProductsProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $ProductsTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $SectionProductsFilterComposer
    extends Composer<_$AppDatabase, SectionProducts> {
  $SectionProductsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $SectionsFilterComposer get sectionId {
    final $SectionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionsFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProductsFilterComposer get productId {
    final $ProductsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProductsFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SectionProductsOrderingComposer
    extends Composer<_$AppDatabase, SectionProducts> {
  $SectionProductsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $SectionsOrderingComposer get sectionId {
    final $SectionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionsOrderingComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProductsOrderingComposer get productId {
    final $ProductsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProductsOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SectionProductsAnnotationComposer
    extends Composer<_$AppDatabase, SectionProducts> {
  $SectionProductsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $SectionsAnnotationComposer get sectionId {
    final $SectionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SectionsAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProductsAnnotationComposer get productId {
    final $ProductsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProductsAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SectionProductsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          SectionProducts,
          SectionProduct,
          $SectionProductsFilterComposer,
          $SectionProductsOrderingComposer,
          $SectionProductsAnnotationComposer,
          $SectionProductsCreateCompanionBuilder,
          $SectionProductsUpdateCompanionBuilder,
          (SectionProduct, $SectionProductsReferences),
          SectionProduct,
          PrefetchHooks Function({bool sectionId, bool productId})
        > {
  $SectionProductsTableManager(_$AppDatabase db, SectionProducts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SectionProductsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SectionProductsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SectionProductsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sectionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion(
                sectionId: sectionId,
                productId: productId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sectionId,
                required String productId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion.insert(
                sectionId: sectionId,
                productId: productId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<SectionProducts, SectionProduct>(table),
                  $SectionProductsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false, productId = false}) {
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
                    if (sectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sectionId,
                        referencedTable: $SectionProductsReferences
                            ._sectionIdTable(db),
                        referencedColumn: $SectionProductsReferences
                            ._sectionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $SectionProductsReferences
                            ._productIdTable(db),
                        referencedColumn: $SectionProductsReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
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

typedef $SectionProductsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      SectionProducts,
      SectionProduct,
      $SectionProductsFilterComposer,
      $SectionProductsOrderingComposer,
      $SectionProductsAnnotationComposer,
      $SectionProductsCreateCompanionBuilder,
      $SectionProductsUpdateCompanionBuilder,
      (SectionProduct, $SectionProductsReferences),
      SectionProduct,
      PrefetchHooks Function({bool sectionId, bool productId})
    >;
typedef $ShopsCreateCompanionBuilder = ShopsCompanion Function({
  required String id,
  required String name,
  required String address,
  required String imageKey,
  required int position,
  Value<int> rowid,
});
typedef $ShopsUpdateCompanionBuilder = ShopsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> address,
  Value<String> imageKey,
  Value<int> position,
  Value<int> rowid,
});

class $ShopsFilterComposer extends Composer<_$AppDatabase, Shops> {
  $ShopsFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $ShopsOrderingComposer extends Composer<_$AppDatabase, Shops> {
  $ShopsOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ShopsAnnotationComposer extends Composer<_$AppDatabase, Shops> {
  $ShopsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageKey =>
      $composableBuilder(column: $table.imageKey, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $ShopsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Shops,
          Shop,
          $ShopsFilterComposer,
          $ShopsOrderingComposer,
          $ShopsAnnotationComposer,
          $ShopsCreateCompanionBuilder,
          $ShopsUpdateCompanionBuilder,
          (Shop, BaseReferences<_$AppDatabase, Shops, Shop>),
          Shop,
          PrefetchHooks Function()
        > {
  $ShopsTableManager(_$AppDatabase db, Shops table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ShopsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ShopsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ShopsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageKey = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                name: name,
                address: address,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                required String imageKey,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion.insert(
                id: id,
                name: name,
                address: address,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Shops, Shop>(table),
                  BaseReferences<_$AppDatabase, Shops, Shop>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ShopsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Shops,
      Shop,
      $ShopsFilterComposer,
      $ShopsOrderingComposer,
      $ShopsAnnotationComposer,
      $ShopsCreateCompanionBuilder,
      $ShopsUpdateCompanionBuilder,
      (Shop, BaseReferences<_$AppDatabase, Shops, Shop>),
      Shop,
      PrefetchHooks Function()
    >;
typedef $MembersCreateCompanionBuilder = MembersCompanion Function({
  required String id,
  required String name,
  required String imageKey,
  required String tier,
  required String nextTier,
  required int pointsToNextTier,
  required int totalPoints,
  Value<int> tierStartPoints,
  required int notificationCount,
  required int availableRewards,
  Value<int> rowid,
});
typedef $MembersUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> imageKey,
  Value<String> tier,
  Value<String> nextTier,
  Value<int> pointsToNextTier,
  Value<int> totalPoints,
  Value<int> tierStartPoints,
  Value<int> notificationCount,
  Value<int> availableRewards,
  Value<int> rowid,
});

final class $MembersReferences
    extends BaseReferences<_$AppDatabase, Members, Member> {
  $MembersReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Challenges, List<Challenge>> _challengesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.challenges,
    aliasName: 'members__id__challenges__member_id',
  );

  $ChallengesProcessedTableManager get challengesRefs {
    final manager = $ChallengesTableManager(
      $_db,
      $_db.challenges,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_challengesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $MembersFilterComposer extends Composer<_$AppDatabase, Members> {
  $MembersFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tierStartPoints => $composableBuilder(
    column: $table.tierStartPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableRewards => $composableBuilder(
    column: $table.availableRewards,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> challengesRefs(
    Expression<bool> Function($ChallengesFilterComposer f) f,
  ) {
    final $ChallengesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.challenges,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ChallengesFilterComposer(
            $db: $db,
            $table: $db.challenges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $MembersOrderingComposer extends Composer<_$AppDatabase, Members> {
  $MembersOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tierStartPoints => $composableBuilder(
    column: $table.tierStartPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableRewards => $composableBuilder(
    column: $table.availableRewards,
    builder: (column) => ColumnOrderings(column),
  );
}

class $MembersAnnotationComposer extends Composer<_$AppDatabase, Members> {
  $MembersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageKey =>
      $composableBuilder(column: $table.imageKey, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get nextTier =>
      $composableBuilder(column: $table.nextTier, builder: (column) => column);

  GeneratedColumn<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tierStartPoints => $composableBuilder(
    column: $table.tierStartPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableRewards => $composableBuilder(
    column: $table.availableRewards,
    builder: (column) => column,
  );

  Expression<T> challengesRefs<T extends Object>(
    Expression<T> Function($ChallengesAnnotationComposer a) f,
  ) {
    final $ChallengesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.challenges,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ChallengesAnnotationComposer(
            $db: $db,
            $table: $db.challenges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $MembersTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Members,
          Member,
          $MembersFilterComposer,
          $MembersOrderingComposer,
          $MembersAnnotationComposer,
          $MembersCreateCompanionBuilder,
          $MembersUpdateCompanionBuilder,
          (Member, $MembersReferences),
          Member,
          PrefetchHooks Function({bool challengesRefs})
        > {
  $MembersTableManager(_$AppDatabase db, Members table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $MembersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $MembersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $MembersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageKey = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String> nextTier = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> tierStartPoints = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> availableRewards = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                imageKey: imageKey,
                tier: tier,
                nextTier: nextTier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                tierStartPoints: tierStartPoints,
                notificationCount: notificationCount,
                availableRewards: availableRewards,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String imageKey,
                required String tier,
                required String nextTier,
                required int pointsToNextTier,
                required int totalPoints,
                Value<int> tierStartPoints = const Value.absent(),
                required int notificationCount,
                required int availableRewards,
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                imageKey: imageKey,
                tier: tier,
                nextTier: nextTier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                tierStartPoints: tierStartPoints,
                notificationCount: notificationCount,
                availableRewards: availableRewards,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Members, Member>(table),
                  $MembersReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({challengesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (challengesRefs) db.challenges],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (challengesRefs)
                    await $_getPrefetchedDataByColumns<
                      Member,
                      Members,
                      Challenge,
                      Challenges
                    >(
                      currentTable: table,
                      referencedTable: $MembersReferences._challengesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $MembersReferences(db, table, p0).challengesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'member_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $MembersProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Members,
      Member,
      $MembersFilterComposer,
      $MembersOrderingComposer,
      $MembersAnnotationComposer,
      $MembersCreateCompanionBuilder,
      $MembersUpdateCompanionBuilder,
      (Member, $MembersReferences),
      Member,
      PrefetchHooks Function({bool challengesRefs})
    >;
typedef $ChallengesCreateCompanionBuilder = ChallengesCompanion Function({
  required String id,
  required String memberId,
  required String title,
  required String kind,
  required int completed,
  required int target,
  required int points,
  required String imageKey,
  required int position,
  Value<int> rowid,
});
typedef $ChallengesUpdateCompanionBuilder = ChallengesCompanion Function({
  Value<String> id,
  Value<String> memberId,
  Value<String> title,
  Value<String> kind,
  Value<int> completed,
  Value<int> target,
  Value<int> points,
  Value<String> imageKey,
  Value<int> position,
  Value<int> rowid,
});

final class $ChallengesReferences
    extends BaseReferences<_$AppDatabase, Challenges, Challenge> {
  $ChallengesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Members _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('challenges__member_id__members__id');

  $MembersProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $MembersTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ChallengesFilterComposer extends Composer<_$AppDatabase, Challenges> {
  $ChallengesFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $MembersFilterComposer get memberId {
    final $MembersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MembersFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ChallengesOrderingComposer extends Composer<_$AppDatabase, Challenges> {
  $ChallengesOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageKey => $composableBuilder(
    column: $table.imageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $MembersOrderingComposer get memberId {
    final $MembersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MembersOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ChallengesAnnotationComposer
    extends Composer<_$AppDatabase, Challenges> {
  $ChallengesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get imageKey =>
      $composableBuilder(column: $table.imageKey, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $MembersAnnotationComposer get memberId {
    final $MembersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MembersAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ChallengesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Challenges,
          Challenge,
          $ChallengesFilterComposer,
          $ChallengesOrderingComposer,
          $ChallengesAnnotationComposer,
          $ChallengesCreateCompanionBuilder,
          $ChallengesUpdateCompanionBuilder,
          (Challenge, $ChallengesReferences),
          Challenge,
          PrefetchHooks Function({bool memberId})
        > {
  $ChallengesTableManager(_$AppDatabase db, Challenges table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ChallengesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ChallengesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ChallengesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> completed = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> imageKey = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                memberId: memberId,
                title: title,
                kind: kind,
                completed: completed,
                target: target,
                points: points,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String memberId,
                required String title,
                required String kind,
                required int completed,
                required int target,
                required int points,
                required String imageKey,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                memberId: memberId,
                title: title,
                kind: kind,
                completed: completed,
                target: target,
                points: points,
                imageKey: imageKey,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Challenges, Challenge>(table),
                  $ChallengesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberId = false}) {
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
                    if (memberId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.memberId,
                        referencedTable: $ChallengesReferences._memberIdTable(
                          db,
                        ),
                        referencedColumn: $ChallengesReferences
                            ._memberIdTable(db)
                            .id,
                      ) as T;
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

typedef $ChallengesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Challenges,
      Challenge,
      $ChallengesFilterComposer,
      $ChallengesOrderingComposer,
      $ChallengesAnnotationComposer,
      $ChallengesCreateCompanionBuilder,
      $ChallengesUpdateCompanionBuilder,
      (Challenge, $ChallengesReferences),
      Challenge,
      PrefetchHooks Function({bool memberId})
    >;
typedef $RegisteredUsersCreateCompanionBuilder =
    RegisteredUsersCompanion Function({
      required String phone,
      required String firstName,
      required String lastName,
      required DateTime birthDate,
      Value<int> rowid,
    });
typedef $RegisteredUsersUpdateCompanionBuilder =
    RegisteredUsersCompanion Function({
      Value<String> phone,
      Value<String> firstName,
      Value<String> lastName,
      Value<DateTime> birthDate,
      Value<int> rowid,
    });

class $RegisteredUsersFilterComposer
    extends Composer<_$AppDatabase, RegisteredUsers> {
  $RegisteredUsersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $RegisteredUsersOrderingComposer
    extends Composer<_$AppDatabase, RegisteredUsers> {
  $RegisteredUsersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $RegisteredUsersAnnotationComposer
    extends Composer<_$AppDatabase, RegisteredUsers> {
  $RegisteredUsersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);
}

class $RegisteredUsersTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          RegisteredUsers,
          RegisteredUser,
          $RegisteredUsersFilterComposer,
          $RegisteredUsersOrderingComposer,
          $RegisteredUsersAnnotationComposer,
          $RegisteredUsersCreateCompanionBuilder,
          $RegisteredUsersUpdateCompanionBuilder,
          (
            RegisteredUser,
            BaseReferences<_$AppDatabase, RegisteredUsers, RegisteredUser>,
          ),
          RegisteredUser,
          PrefetchHooks Function()
        > {
  $RegisteredUsersTableManager(_$AppDatabase db, RegisteredUsers table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RegisteredUsersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RegisteredUsersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RegisteredUsersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> phone = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegisteredUsersCompanion(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phone,
                required String firstName,
                required String lastName,
                required DateTime birthDate,
                Value<int> rowid = const Value.absent(),
              }) => RegisteredUsersCompanion.insert(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<RegisteredUsers, RegisteredUser>(table),
                  BaseReferences<
                    _$AppDatabase,
                    RegisteredUsers,
                    RegisteredUser
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $RegisteredUsersProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      RegisteredUsers,
      RegisteredUser,
      $RegisteredUsersFilterComposer,
      $RegisteredUsersOrderingComposer,
      $RegisteredUsersAnnotationComposer,
      $RegisteredUsersCreateCompanionBuilder,
      $RegisteredUsersUpdateCompanionBuilder,
      (
        RegisteredUser,
        BaseReferences<_$AppDatabase, RegisteredUsers, RegisteredUser>,
      ),
      RegisteredUser,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $ProductsTableManager get products =>
      $ProductsTableManager(_db, _db.products);
  $BannersTableManager get banners => $BannersTableManager(_db, _db.banners);
  $SectionsTableManager get sections =>
      $SectionsTableManager(_db, _db.sections);
  $SectionProductsTableManager get sectionProducts =>
      $SectionProductsTableManager(_db, _db.sectionProducts);
  $ShopsTableManager get shops => $ShopsTableManager(_db, _db.shops);
  $MembersTableManager get members => $MembersTableManager(_db, _db.members);
  $ChallengesTableManager get challenges =>
      $ChallengesTableManager(_db, _db.challenges);
  $RegisteredUsersTableManager get registeredUsers =>
      $RegisteredUsersTableManager(_db, _db.registeredUsers);
}
