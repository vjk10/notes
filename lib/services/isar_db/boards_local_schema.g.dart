// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_local_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetBoardsLocalCollection on Isar {
  IsarCollection<BoardsLocal> get boardsLocals => this.collection();
}

const BoardsLocalSchema = CollectionSchema(
  name: r'BoardsLocal',
  id: 4214883672164069265,
  properties: {
    r'boardcolor': PropertySchema(
      id: 0,
      name: r'boardcolor',
      type: IsarType.long,
    ),
    r'boardname': PropertySchema(
      id: 1,
      name: r'boardname',
      type: IsarType.string,
    ),
    r'boardtextcolor': PropertySchema(
      id: 2,
      name: r'boardtextcolor',
      type: IsarType.long,
    ),
    r'createdby': PropertySchema(
      id: 3,
      name: r'createdby',
      type: IsarType.string,
    ),
    r'createdon': PropertySchema(
      id: 4,
      name: r'createdon',
      type: IsarType.string,
    )
  },
  estimateSize: _boardsLocalEstimateSize,
  serialize: _boardsLocalSerialize,
  deserialize: _boardsLocalDeserialize,
  deserializeProp: _boardsLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _boardsLocalGetId,
  getLinks: _boardsLocalGetLinks,
  attach: _boardsLocalAttach,
  version: '3.0.5',
);

int _boardsLocalEstimateSize(
  BoardsLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.boardname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdby;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdon;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _boardsLocalSerialize(
  BoardsLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.boardcolor);
  writer.writeString(offsets[1], object.boardname);
  writer.writeLong(offsets[2], object.boardtextcolor);
  writer.writeString(offsets[3], object.createdby);
  writer.writeString(offsets[4], object.createdon);
}

BoardsLocal _boardsLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BoardsLocal();
  object.boardcolor = reader.readLongOrNull(offsets[0]);
  object.boardname = reader.readStringOrNull(offsets[1]);
  object.boardtextcolor = reader.readLongOrNull(offsets[2]);
  object.createdby = reader.readStringOrNull(offsets[3]);
  object.createdon = reader.readStringOrNull(offsets[4]);
  object.id = id;
  return object;
}

P _boardsLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _boardsLocalGetId(BoardsLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _boardsLocalGetLinks(BoardsLocal object) {
  return [];
}

void _boardsLocalAttach(
    IsarCollection<dynamic> col, Id id, BoardsLocal object) {
  object.id = id;
}

extension BoardsLocalQueryWhereSort
    on QueryBuilder<BoardsLocal, BoardsLocal, QWhere> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BoardsLocalQueryWhere
    on QueryBuilder<BoardsLocal, BoardsLocal, QWhereClause> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterWhereClause> idBetween(
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
}

extension BoardsLocalQueryFilter
    on QueryBuilder<BoardsLocal, BoardsLocal, QFilterCondition> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardcolor',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardcolor',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardcolorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardcolor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardname',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardname',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardname',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardname',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardtextcolor',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardtextcolor',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardtextcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardtextcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardtextcolor',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      boardtextcolorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardtextcolor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdby',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdby',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdby',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdby',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdby',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdbyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdby',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdon',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdon',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdon',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      createdonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdon',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition> idBetween(
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

extension BoardsLocalQueryObject
    on QueryBuilder<BoardsLocal, BoardsLocal, QFilterCondition> {}

extension BoardsLocalQueryLinks
    on QueryBuilder<BoardsLocal, BoardsLocal, QFilterCondition> {}

extension BoardsLocalQuerySortBy
    on QueryBuilder<BoardsLocal, BoardsLocal, QSortBy> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByBoardcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardcolor', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByBoardcolorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardcolor', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByBoardname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByBoardnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByBoardtextcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardtextcolor', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy>
      sortByBoardtextcolorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardtextcolor', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByCreatedby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByCreatedbyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByCreatedon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> sortByCreatedonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.desc);
    });
  }
}

extension BoardsLocalQuerySortThenBy
    on QueryBuilder<BoardsLocal, BoardsLocal, QSortThenBy> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByBoardcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardcolor', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByBoardcolorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardcolor', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByBoardname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByBoardnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByBoardtextcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardtextcolor', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy>
      thenByBoardtextcolorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardtextcolor', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByCreatedby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByCreatedbyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByCreatedon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByCreatedonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.desc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension BoardsLocalQueryWhereDistinct
    on QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> {
  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByBoardcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardcolor');
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByBoardname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByBoardtextcolor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardtextcolor');
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByCreatedby(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdby', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByCreatedon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdon', caseSensitive: caseSensitive);
    });
  }
}

extension BoardsLocalQueryProperty
    on QueryBuilder<BoardsLocal, BoardsLocal, QQueryProperty> {
  QueryBuilder<BoardsLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BoardsLocal, int?, QQueryOperations> boardcolorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardcolor');
    });
  }

  QueryBuilder<BoardsLocal, String?, QQueryOperations> boardnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardname');
    });
  }

  QueryBuilder<BoardsLocal, int?, QQueryOperations> boardtextcolorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardtextcolor');
    });
  }

  QueryBuilder<BoardsLocal, String?, QQueryOperations> createdbyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdby');
    });
  }

  QueryBuilder<BoardsLocal, String?, QQueryOperations> createdonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdon');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetNotesLocalCollection on Isar {
  IsarCollection<NotesLocal> get notesLocals => this.collection();
}

const NotesLocalSchema = CollectionSchema(
  name: r'NotesLocal',
  id: 6655623578322762102,
  properties: {
    r'backedup': PropertySchema(
      id: 0,
      name: r'backedup',
      type: IsarType.bool,
    ),
    r'boardid': PropertySchema(
      id: 1,
      name: r'boardid',
      type: IsarType.long,
    ),
    r'boardname': PropertySchema(
      id: 2,
      name: r'boardname',
      type: IsarType.string,
    ),
    r'body': PropertySchema(
      id: 3,
      name: r'body',
      type: IsarType.string,
    ),
    r'bodyPlainText': PropertySchema(
      id: 4,
      name: r'bodyPlainText',
      type: IsarType.string,
    ),
    r'createdby': PropertySchema(
      id: 5,
      name: r'createdby',
      type: IsarType.string,
    ),
    r'createdon': PropertySchema(
      id: 6,
      name: r'createdon',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _notesLocalEstimateSize,
  serialize: _notesLocalSerialize,
  deserialize: _notesLocalDeserialize,
  deserializeProp: _notesLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _notesLocalGetId,
  getLinks: _notesLocalGetLinks,
  attach: _notesLocalAttach,
  version: '3.0.5',
);

int _notesLocalEstimateSize(
  NotesLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.boardname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.body;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bodyPlainText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdby;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdon;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _notesLocalSerialize(
  NotesLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.backedup);
  writer.writeLong(offsets[1], object.boardid);
  writer.writeString(offsets[2], object.boardname);
  writer.writeString(offsets[3], object.body);
  writer.writeString(offsets[4], object.bodyPlainText);
  writer.writeString(offsets[5], object.createdby);
  writer.writeString(offsets[6], object.createdon);
  writer.writeString(offsets[7], object.title);
}

NotesLocal _notesLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotesLocal();
  object.backedup = reader.readBoolOrNull(offsets[0]);
  object.boardid = reader.readLongOrNull(offsets[1]);
  object.boardname = reader.readStringOrNull(offsets[2]);
  object.body = reader.readStringOrNull(offsets[3]);
  object.bodyPlainText = reader.readStringOrNull(offsets[4]);
  object.createdby = reader.readStringOrNull(offsets[5]);
  object.createdon = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.title = reader.readStringOrNull(offsets[7]);
  return object;
}

P _notesLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notesLocalGetId(NotesLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notesLocalGetLinks(NotesLocal object) {
  return [];
}

void _notesLocalAttach(IsarCollection<dynamic> col, Id id, NotesLocal object) {
  object.id = id;
}

extension NotesLocalQueryWhereSort
    on QueryBuilder<NotesLocal, NotesLocal, QWhere> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotesLocalQueryWhere
    on QueryBuilder<NotesLocal, NotesLocal, QWhereClause> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<NotesLocal, NotesLocal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterWhereClause> idBetween(
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
}

extension NotesLocalQueryFilter
    on QueryBuilder<NotesLocal, NotesLocal, QFilterCondition> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> backedupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backedup',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      backedupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backedup',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> backedupEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backedup',
        value: value,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardid',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardid',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardidEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardid',
        value: value,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardid',
        value: value,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardid',
        value: value,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardname',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardname',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> boardnameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardname',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      boardnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardname',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'body',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'body',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'body',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'body',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> bodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bodyPlainText',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bodyPlainText',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bodyPlainText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bodyPlainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bodyPlainText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyPlainText',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      bodyPlainTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bodyPlainText',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdby',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdby',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdby',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdby',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdbyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdby',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdby',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdbyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdby',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdon',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdon',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> createdonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdon',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      createdonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdon',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension NotesLocalQueryObject
    on QueryBuilder<NotesLocal, NotesLocal, QFilterCondition> {}

extension NotesLocalQueryLinks
    on QueryBuilder<NotesLocal, NotesLocal, QFilterCondition> {}

extension NotesLocalQuerySortBy
    on QueryBuilder<NotesLocal, NotesLocal, QSortBy> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBackedup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backedup', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBackedupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backedup', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBoardid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardid', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBoardidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardid', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBoardname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBoardnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBodyPlainText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyPlainText', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByBodyPlainTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyPlainText', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByCreatedby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByCreatedbyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByCreatedon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByCreatedonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension NotesLocalQuerySortThenBy
    on QueryBuilder<NotesLocal, NotesLocal, QSortThenBy> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBackedup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backedup', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBackedupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backedup', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBoardid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardid', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBoardidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardid', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBoardname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBoardnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardname', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBodyPlainText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyPlainText', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByBodyPlainTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyPlainText', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByCreatedby() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByCreatedbyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdby', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByCreatedon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByCreatedonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdon', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension NotesLocalQueryWhereDistinct
    on QueryBuilder<NotesLocal, NotesLocal, QDistinct> {
  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByBackedup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backedup');
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByBoardid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardid');
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByBoardname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByBody(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'body', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByBodyPlainText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyPlainText',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByCreatedby(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdby', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByCreatedon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension NotesLocalQueryProperty
    on QueryBuilder<NotesLocal, NotesLocal, QQueryProperty> {
  QueryBuilder<NotesLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotesLocal, bool?, QQueryOperations> backedupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backedup');
    });
  }

  QueryBuilder<NotesLocal, int?, QQueryOperations> boardidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardid');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> boardnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardname');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'body');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> bodyPlainTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyPlainText');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> createdbyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdby');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> createdonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdon');
    });
  }

  QueryBuilder<NotesLocal, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
