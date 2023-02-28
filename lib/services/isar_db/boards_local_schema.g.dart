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
    r'boardname': PropertySchema(
      id: 0,
      name: r'boardname',
      type: IsarType.string,
    ),
    r'createdby': PropertySchema(
      id: 1,
      name: r'createdby',
      type: IsarType.string,
    ),
    r'createdon': PropertySchema(
      id: 2,
      name: r'createdon',
      type: IsarType.string,
    ),
    r'notesLocal': PropertySchema(
      id: 3,
      name: r'notesLocal',
      type: IsarType.object,
      target: r'NotesLocal',
    )
  },
  estimateSize: _boardsLocalEstimateSize,
  serialize: _boardsLocalSerialize,
  deserialize: _boardsLocalDeserialize,
  deserializeProp: _boardsLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'NotesLocal': NotesLocalSchema,
    r'ImagesNoteLocal': ImagesNoteLocalSchema
  },
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
  {
    final value = object.notesLocal;
    if (value != null) {
      bytesCount += 3 +
          NotesLocalSchema.estimateSize(
              value, allOffsets[NotesLocal]!, allOffsets);
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
  writer.writeString(offsets[0], object.boardname);
  writer.writeString(offsets[1], object.createdby);
  writer.writeString(offsets[2], object.createdon);
  writer.writeObject<NotesLocal>(
    offsets[3],
    allOffsets,
    NotesLocalSchema.serialize,
    object.notesLocal,
  );
}

BoardsLocal _boardsLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BoardsLocal();
  object.boardname = reader.readStringOrNull(offsets[0]);
  object.createdby = reader.readStringOrNull(offsets[1]);
  object.createdon = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.notesLocal = reader.readObjectOrNull<NotesLocal>(
    offsets[3],
    NotesLocalSchema.deserialize,
    allOffsets,
  );
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
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<NotesLocal>(
        offset,
        NotesLocalSchema.deserialize,
        allOffsets,
      )) as P;
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

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      notesLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notesLocal',
      ));
    });
  }

  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition>
      notesLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notesLocal',
      ));
    });
  }
}

extension BoardsLocalQueryObject
    on QueryBuilder<BoardsLocal, BoardsLocal, QFilterCondition> {
  QueryBuilder<BoardsLocal, BoardsLocal, QAfterFilterCondition> notesLocal(
      FilterQuery<NotesLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notesLocal');
    });
  }
}

extension BoardsLocalQueryLinks
    on QueryBuilder<BoardsLocal, BoardsLocal, QFilterCondition> {}

extension BoardsLocalQuerySortBy
    on QueryBuilder<BoardsLocal, BoardsLocal, QSortBy> {
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
  QueryBuilder<BoardsLocal, BoardsLocal, QDistinct> distinctByBoardname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardname', caseSensitive: caseSensitive);
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

  QueryBuilder<BoardsLocal, String?, QQueryOperations> boardnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardname');
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

  QueryBuilder<BoardsLocal, NotesLocal?, QQueryOperations>
      notesLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notesLocal');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const NotesLocalSchema = Schema(
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
    r'createdby': PropertySchema(
      id: 4,
      name: r'createdby',
      type: IsarType.string,
    ),
    r'createdon': PropertySchema(
      id: 5,
      name: r'createdon',
      type: IsarType.string,
    ),
    r'imagesNoteLocal': PropertySchema(
      id: 6,
      name: r'imagesNoteLocal',
      type: IsarType.object,
      target: r'ImagesNoteLocal',
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
    final value = object.imagesNoteLocal;
    if (value != null) {
      bytesCount += 3 +
          ImagesNoteLocalSchema.estimateSize(
              value, allOffsets[ImagesNoteLocal]!, allOffsets);
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
  writer.writeString(offsets[4], object.createdby);
  writer.writeString(offsets[5], object.createdon);
  writer.writeObject<ImagesNoteLocal>(
    offsets[6],
    allOffsets,
    ImagesNoteLocalSchema.serialize,
    object.imagesNoteLocal,
  );
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
  object.createdby = reader.readStringOrNull(offsets[4]);
  object.createdon = reader.readStringOrNull(offsets[5]);
  object.imagesNoteLocal = reader.readObjectOrNull<ImagesNoteLocal>(
    offsets[6],
    ImagesNoteLocalSchema.deserialize,
    allOffsets,
  );
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
      return (reader.readObjectOrNull<ImagesNoteLocal>(
        offset,
        ImagesNoteLocalSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
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

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      imagesNoteLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagesNoteLocal',
      ));
    });
  }

  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition>
      imagesNoteLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagesNoteLocal',
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
    on QueryBuilder<NotesLocal, NotesLocal, QFilterCondition> {
  QueryBuilder<NotesLocal, NotesLocal, QAfterFilterCondition> imagesNoteLocal(
      FilterQuery<ImagesNoteLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'imagesNoteLocal');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const ImagesNoteLocalSchema = Schema(
  name: r'ImagesNoteLocal',
  id: -8622929843056344320,
  properties: {
    r'imagepath': PropertySchema(
      id: 0,
      name: r'imagepath',
      type: IsarType.string,
    ),
    r'noteid': PropertySchema(
      id: 1,
      name: r'noteid',
      type: IsarType.long,
    )
  },
  estimateSize: _imagesNoteLocalEstimateSize,
  serialize: _imagesNoteLocalSerialize,
  deserialize: _imagesNoteLocalDeserialize,
  deserializeProp: _imagesNoteLocalDeserializeProp,
);

int _imagesNoteLocalEstimateSize(
  ImagesNoteLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imagepath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _imagesNoteLocalSerialize(
  ImagesNoteLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imagepath);
  writer.writeLong(offsets[1], object.noteid);
}

ImagesNoteLocal _imagesNoteLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImagesNoteLocal();
  object.imagepath = reader.readStringOrNull(offsets[0]);
  object.noteid = reader.readLongOrNull(offsets[1]);
  return object;
}

P _imagesNoteLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ImagesNoteLocalQueryFilter
    on QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QFilterCondition> {
  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imagepath',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imagepath',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagepath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagepath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagepath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagepath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      imagepathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagepath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'noteid',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'noteid',
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteid',
        value: value,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteid',
        value: value,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteid',
        value: value,
      ));
    });
  }

  QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QAfterFilterCondition>
      noteidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImagesNoteLocalQueryObject
    on QueryBuilder<ImagesNoteLocal, ImagesNoteLocal, QFilterCondition> {}