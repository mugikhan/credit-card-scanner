// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banned_countries.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBannedCountryCollection on Isar {
  IsarCollection<BannedCountry> get bannedCountrys => this.collection();
}

const BannedCountrySchema = CollectionSchema(
  name: r'BannedCountry',
  id: 2603965742873234580,
  properties: {
    r'country': PropertySchema(
      id: 0,
      name: r'country',
      type: IsarType.string,
    ),
    r'selected': PropertySchema(
      id: 1,
      name: r'selected',
      type: IsarType.bool,
    )
  },
  estimateSize: _bannedCountryEstimateSize,
  serialize: _bannedCountrySerialize,
  deserialize: _bannedCountryDeserialize,
  deserializeProp: _bannedCountryDeserializeProp,
  idName: r'id',
  indexes: {
    r'country': IndexSchema(
      id: 749182048769006606,
      name: r'country',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'country',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bannedCountryGetId,
  getLinks: _bannedCountryGetLinks,
  attach: _bannedCountryAttach,
  version: '3.1.0+1',
);

int _bannedCountryEstimateSize(
  BannedCountry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.country.length * 3;
  return bytesCount;
}

void _bannedCountrySerialize(
  BannedCountry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.country);
  writer.writeBool(offsets[1], object.selected);
}

BannedCountry _bannedCountryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BannedCountry();
  object.country = reader.readString(offsets[0]);
  object.id = id;
  object.selected = reader.readBool(offsets[1]);
  return object;
}

P _bannedCountryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bannedCountryGetId(BannedCountry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bannedCountryGetLinks(BannedCountry object) {
  return [];
}

void _bannedCountryAttach(
    IsarCollection<dynamic> col, Id id, BannedCountry object) {
  object.id = id;
}

extension BannedCountryByIndex on IsarCollection<BannedCountry> {
  Future<BannedCountry?> getByCountry(String country) {
    return getByIndex(r'country', [country]);
  }

  BannedCountry? getByCountrySync(String country) {
    return getByIndexSync(r'country', [country]);
  }

  Future<bool> deleteByCountry(String country) {
    return deleteByIndex(r'country', [country]);
  }

  bool deleteByCountrySync(String country) {
    return deleteByIndexSync(r'country', [country]);
  }

  Future<List<BannedCountry?>> getAllByCountry(List<String> countryValues) {
    final values = countryValues.map((e) => [e]).toList();
    return getAllByIndex(r'country', values);
  }

  List<BannedCountry?> getAllByCountrySync(List<String> countryValues) {
    final values = countryValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'country', values);
  }

  Future<int> deleteAllByCountry(List<String> countryValues) {
    final values = countryValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'country', values);
  }

  int deleteAllByCountrySync(List<String> countryValues) {
    final values = countryValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'country', values);
  }

  Future<Id> putByCountry(BannedCountry object) {
    return putByIndex(r'country', object);
  }

  Id putByCountrySync(BannedCountry object, {bool saveLinks = true}) {
    return putByIndexSync(r'country', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCountry(List<BannedCountry> objects) {
    return putAllByIndex(r'country', objects);
  }

  List<Id> putAllByCountrySync(List<BannedCountry> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'country', objects, saveLinks: saveLinks);
  }
}

extension BannedCountryQueryWhereSort
    on QueryBuilder<BannedCountry, BannedCountry, QWhere> {
  QueryBuilder<BannedCountry, BannedCountry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BannedCountryQueryWhere
    on QueryBuilder<BannedCountry, BannedCountry, QWhereClause> {
  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> idBetween(
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

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause> countryEqualTo(
      String country) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'country',
        value: [country],
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterWhereClause>
      countryNotEqualTo(String country) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'country',
              lower: [],
              upper: [country],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'country',
              lower: [country],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'country',
              lower: [country],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'country',
              lower: [],
              upper: [country],
              includeUpper: false,
            ));
      }
    });
  }
}

extension BannedCountryQueryFilter
    on QueryBuilder<BannedCountry, BannedCountry, QFilterCondition> {
  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BannedCountry, BannedCountry, QAfterFilterCondition>
      selectedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selected',
        value: value,
      ));
    });
  }
}

extension BannedCountryQueryObject
    on QueryBuilder<BannedCountry, BannedCountry, QFilterCondition> {}

extension BannedCountryQueryLinks
    on QueryBuilder<BannedCountry, BannedCountry, QFilterCondition> {}

extension BannedCountryQuerySortBy
    on QueryBuilder<BannedCountry, BannedCountry, QSortBy> {
  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> sortBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.asc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy>
      sortBySelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.desc);
    });
  }
}

extension BannedCountryQuerySortThenBy
    on QueryBuilder<BannedCountry, BannedCountry, QSortThenBy> {
  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy> thenBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.asc);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QAfterSortBy>
      thenBySelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.desc);
    });
  }
}

extension BannedCountryQueryWhereDistinct
    on QueryBuilder<BannedCountry, BannedCountry, QDistinct> {
  QueryBuilder<BannedCountry, BannedCountry, QDistinct> distinctByCountry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BannedCountry, BannedCountry, QDistinct> distinctBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selected');
    });
  }
}

extension BannedCountryQueryProperty
    on QueryBuilder<BannedCountry, BannedCountry, QQueryProperty> {
  QueryBuilder<BannedCountry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BannedCountry, String, QQueryOperations> countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<BannedCountry, bool, QQueryOperations> selectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selected');
    });
  }
}
