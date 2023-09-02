// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCreditCardCollection on Isar {
  IsarCollection<CreditCard> get creditCards => this.collection();
}

const CreditCardSchema = CollectionSchema(
  name: r'CreditCard',
  id: 687928797046475984,
  properties: {
    r'cardHolderName': PropertySchema(
      id: 0,
      name: r'cardHolderName',
      type: IsarType.string,
    ),
    r'cardNumber': PropertySchema(
      id: 1,
      name: r'cardNumber',
      type: IsarType.string,
    ),
    r'cardType': PropertySchema(
      id: 2,
      name: r'cardType',
      type: IsarType.string,
      enumMap: _CreditCardcardTypeEnumValueMap,
    ),
    r'cvc': PropertySchema(
      id: 3,
      name: r'cvc',
      type: IsarType.string,
    ),
    r'expiryMonth': PropertySchema(
      id: 4,
      name: r'expiryMonth',
      type: IsarType.string,
    ),
    r'expiryYear': PropertySchema(
      id: 5,
      name: r'expiryYear',
      type: IsarType.long,
    )
  },
  estimateSize: _creditCardEstimateSize,
  serialize: _creditCardSerialize,
  deserialize: _creditCardDeserialize,
  deserializeProp: _creditCardDeserializeProp,
  idName: r'id',
  indexes: {
    r'cardNumber': IndexSchema(
      id: 8692631350741394952,
      name: r'cardNumber',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'cardNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _creditCardGetId,
  getLinks: _creditCardGetLinks,
  attach: _creditCardAttach,
  version: '3.1.0+1',
);

int _creditCardEstimateSize(
  CreditCard object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cardHolderName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cardNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.cardType.cardIssuerName.length * 3;
  {
    final value = object.cvc;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.expiryMonth;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _creditCardSerialize(
  CreditCard object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cardHolderName);
  writer.writeString(offsets[1], object.cardNumber);
  writer.writeString(offsets[2], object.cardType.cardIssuerName);
  writer.writeString(offsets[3], object.cvc);
  writer.writeString(offsets[4], object.expiryMonth);
  writer.writeLong(offsets[5], object.expiryYear);
}

CreditCard _creditCardDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CreditCard();
  object.cardHolderName = reader.readStringOrNull(offsets[0]);
  object.cardNumber = reader.readStringOrNull(offsets[1]);
  object.cardType =
      _CreditCardcardTypeValueEnumMap[reader.readStringOrNull(offsets[2])] ??
          CardIssuer.visa;
  object.cvc = reader.readStringOrNull(offsets[3]);
  object.expiryMonth = reader.readStringOrNull(offsets[4]);
  object.expiryYear = reader.readLongOrNull(offsets[5]);
  object.id = id;
  return object;
}

P _creditCardDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (_CreditCardcardTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CardIssuer.visa) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CreditCardcardTypeEnumValueMap = {
  r'visa': r'Visa',
  r'mastercard': r'Mastercard',
  r'unknown': r'Unknown',
};
const _CreditCardcardTypeValueEnumMap = {
  r'Visa': CardIssuer.visa,
  r'Mastercard': CardIssuer.mastercard,
  r'Unknown': CardIssuer.unknown,
};

Id _creditCardGetId(CreditCard object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _creditCardGetLinks(CreditCard object) {
  return [];
}

void _creditCardAttach(IsarCollection<dynamic> col, Id id, CreditCard object) {
  object.id = id;
}

extension CreditCardByIndex on IsarCollection<CreditCard> {
  Future<CreditCard?> getByCardNumber(String? cardNumber) {
    return getByIndex(r'cardNumber', [cardNumber]);
  }

  CreditCard? getByCardNumberSync(String? cardNumber) {
    return getByIndexSync(r'cardNumber', [cardNumber]);
  }

  Future<bool> deleteByCardNumber(String? cardNumber) {
    return deleteByIndex(r'cardNumber', [cardNumber]);
  }

  bool deleteByCardNumberSync(String? cardNumber) {
    return deleteByIndexSync(r'cardNumber', [cardNumber]);
  }

  Future<List<CreditCard?>> getAllByCardNumber(List<String?> cardNumberValues) {
    final values = cardNumberValues.map((e) => [e]).toList();
    return getAllByIndex(r'cardNumber', values);
  }

  List<CreditCard?> getAllByCardNumberSync(List<String?> cardNumberValues) {
    final values = cardNumberValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'cardNumber', values);
  }

  Future<int> deleteAllByCardNumber(List<String?> cardNumberValues) {
    final values = cardNumberValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'cardNumber', values);
  }

  int deleteAllByCardNumberSync(List<String?> cardNumberValues) {
    final values = cardNumberValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'cardNumber', values);
  }

  Future<Id> putByCardNumber(CreditCard object) {
    return putByIndex(r'cardNumber', object);
  }

  Id putByCardNumberSync(CreditCard object, {bool saveLinks = true}) {
    return putByIndexSync(r'cardNumber', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCardNumber(List<CreditCard> objects) {
    return putAllByIndex(r'cardNumber', objects);
  }

  List<Id> putAllByCardNumberSync(List<CreditCard> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'cardNumber', objects, saveLinks: saveLinks);
  }
}

extension CreditCardQueryWhereSort
    on QueryBuilder<CreditCard, CreditCard, QWhere> {
  QueryBuilder<CreditCard, CreditCard, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CreditCardQueryWhere
    on QueryBuilder<CreditCard, CreditCard, QWhereClause> {
  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> cardNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cardNumber',
        value: [null],
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause>
      cardNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'cardNumber',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> cardNumberEqualTo(
      String? cardNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cardNumber',
        value: [cardNumber],
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterWhereClause> cardNumberNotEqualTo(
      String? cardNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardNumber',
              lower: [],
              upper: [cardNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardNumber',
              lower: [cardNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardNumber',
              lower: [cardNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardNumber',
              lower: [],
              upper: [cardNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CreditCardQueryFilter
    on QueryBuilder<CreditCard, CreditCard, QFilterCondition> {
  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cardHolderName',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cardHolderName',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardHolderName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardHolderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardHolderName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardHolderName',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardHolderNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardHolderName',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cardNumber',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cardNumber',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeEqualTo(
    CardIssuer value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardTypeGreaterThan(
    CardIssuer value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeLessThan(
    CardIssuer value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeBetween(
    CardIssuer lower,
    CardIssuer upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cardTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardType',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      cardTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardType',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cvc',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cvc',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cvc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cvc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cvc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cvc',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> cvcIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cvc',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expiryMonth',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expiryMonth',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiryMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expiryMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expiryMonth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiryMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryMonthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expiryMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryYearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expiryYear',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryYearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expiryYear',
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> expiryYearEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryYearGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition>
      expiryYearLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> expiryYearBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiryYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CreditCardQueryObject
    on QueryBuilder<CreditCard, CreditCard, QFilterCondition> {}

extension CreditCardQueryLinks
    on QueryBuilder<CreditCard, CreditCard, QFilterCondition> {}

extension CreditCardQuerySortBy
    on QueryBuilder<CreditCard, CreditCard, QSortBy> {
  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCardHolderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardHolderName', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy>
      sortByCardHolderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardHolderName', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCardNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCardNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCardType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCardTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCvc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cvc', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByCvcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cvc', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByExpiryMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryMonth', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByExpiryMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryMonth', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByExpiryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryYear', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> sortByExpiryYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryYear', Sort.desc);
    });
  }
}

extension CreditCardQuerySortThenBy
    on QueryBuilder<CreditCard, CreditCard, QSortThenBy> {
  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCardHolderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardHolderName', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy>
      thenByCardHolderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardHolderName', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCardNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCardNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardNumber', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCardType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCardTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardType', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCvc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cvc', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByCvcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cvc', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByExpiryMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryMonth', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByExpiryMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryMonth', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByExpiryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryYear', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByExpiryYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryYear', Sort.desc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CreditCardQueryWhereDistinct
    on QueryBuilder<CreditCard, CreditCard, QDistinct> {
  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByCardHolderName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardHolderName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByCardNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByCardType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByCvc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cvc', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByExpiryMonth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiryMonth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCard, CreditCard, QDistinct> distinctByExpiryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiryYear');
    });
  }
}

extension CreditCardQueryProperty
    on QueryBuilder<CreditCard, CreditCard, QQueryProperty> {
  QueryBuilder<CreditCard, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CreditCard, String?, QQueryOperations> cardHolderNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardHolderName');
    });
  }

  QueryBuilder<CreditCard, String?, QQueryOperations> cardNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardNumber');
    });
  }

  QueryBuilder<CreditCard, CardIssuer, QQueryOperations> cardTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardType');
    });
  }

  QueryBuilder<CreditCard, String?, QQueryOperations> cvcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cvc');
    });
  }

  QueryBuilder<CreditCard, String?, QQueryOperations> expiryMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiryMonth');
    });
  }

  QueryBuilder<CreditCard, int?, QQueryOperations> expiryYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiryYear');
    });
  }
}
