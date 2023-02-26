// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetOnboardingCollection on Isar {
  IsarCollection<Onboarding> get onboardings => this.collection();
}

const OnboardingSchema = CollectionSchema(
  name: r'Onboarding',
  id: -1646666611443929564,
  properties: {
    r'onboarding': PropertySchema(
      id: 0,
      name: r'onboarding',
      type: IsarType.string,
    )
  },
  estimateSize: _onboardingEstimateSize,
  serialize: _onboardingSerialize,
  deserialize: _onboardingDeserialize,
  deserializeProp: _onboardingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _onboardingGetId,
  getLinks: _onboardingGetLinks,
  attach: _onboardingAttach,
  version: '3.0.5',
);

int _onboardingEstimateSize(
  Onboarding object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.onboarding;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _onboardingSerialize(
  Onboarding object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.onboarding);
}

Onboarding _onboardingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Onboarding();
  object.id = id;
  object.onboarding = reader.readStringOrNull(offsets[0]);
  return object;
}

P _onboardingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _onboardingGetId(Onboarding object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _onboardingGetLinks(Onboarding object) {
  return [];
}

void _onboardingAttach(IsarCollection<dynamic> col, Id id, Onboarding object) {
  object.id = id;
}

extension OnboardingQueryWhereSort
    on QueryBuilder<Onboarding, Onboarding, QWhere> {
  QueryBuilder<Onboarding, Onboarding, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OnboardingQueryWhere
    on QueryBuilder<Onboarding, Onboarding, QWhereClause> {
  QueryBuilder<Onboarding, Onboarding, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Onboarding, Onboarding, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterWhereClause> idBetween(
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

extension OnboardingQueryFilter
    on QueryBuilder<Onboarding, Onboarding, QFilterCondition> {
  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onboarding',
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onboarding',
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> onboardingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> onboardingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onboarding',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'onboarding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition> onboardingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'onboarding',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboarding',
        value: '',
      ));
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterFilterCondition>
      onboardingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'onboarding',
        value: '',
      ));
    });
  }
}

extension OnboardingQueryObject
    on QueryBuilder<Onboarding, Onboarding, QFilterCondition> {}

extension OnboardingQueryLinks
    on QueryBuilder<Onboarding, Onboarding, QFilterCondition> {}

extension OnboardingQuerySortBy
    on QueryBuilder<Onboarding, Onboarding, QSortBy> {
  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> sortByOnboarding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboarding', Sort.asc);
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> sortByOnboardingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboarding', Sort.desc);
    });
  }
}

extension OnboardingQuerySortThenBy
    on QueryBuilder<Onboarding, Onboarding, QSortThenBy> {
  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> thenByOnboarding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboarding', Sort.asc);
    });
  }

  QueryBuilder<Onboarding, Onboarding, QAfterSortBy> thenByOnboardingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboarding', Sort.desc);
    });
  }
}

extension OnboardingQueryWhereDistinct
    on QueryBuilder<Onboarding, Onboarding, QDistinct> {
  QueryBuilder<Onboarding, Onboarding, QDistinct> distinctByOnboarding(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboarding', caseSensitive: caseSensitive);
    });
  }
}

extension OnboardingQueryProperty
    on QueryBuilder<Onboarding, Onboarding, QQueryProperty> {
  QueryBuilder<Onboarding, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Onboarding, String?, QQueryOperations> onboardingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboarding');
    });
  }
}
