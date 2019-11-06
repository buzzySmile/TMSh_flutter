// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortlist_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShortlistState> _$shortlistStateSerializer =
    new _$ShortlistStateSerializer();

class _$ShortlistStateSerializer
    implements StructuredSerializer<ShortlistState> {
  @override
  final Iterable<Type> types = const [ShortlistState, _$ShortlistState];
  @override
  final String wireName = 'ShortlistState';

  @override
  Iterable<Object> serialize(Serializers serializers, ShortlistState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'movies',
      serializers.serialize(object.movies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TMDbMovieCard)])),
    ];

    return result;
  }

  @override
  ShortlistState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShortlistStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'movies':
          result.movies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TMDbMovieCard)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$ShortlistState extends ShortlistState {
  @override
  final BuiltList<TMDbMovieCard> movies;

  factory _$ShortlistState([void Function(ShortlistStateBuilder) updates]) =>
      (new ShortlistStateBuilder()..update(updates)).build();

  _$ShortlistState._({this.movies}) : super._() {
    if (movies == null) {
      throw new BuiltValueNullFieldError('ShortlistState', 'movies');
    }
  }

  @override
  ShortlistState rebuild(void Function(ShortlistStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShortlistStateBuilder toBuilder() =>
      new ShortlistStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShortlistState && movies == other.movies;
  }

  @override
  int get hashCode {
    return $jf($jc(0, movies.hashCode));
  }
}

class ShortlistStateBuilder
    implements Builder<ShortlistState, ShortlistStateBuilder> {
  _$ShortlistState _$v;

  ListBuilder<TMDbMovieCard> _movies;
  ListBuilder<TMDbMovieCard> get movies =>
      _$this._movies ??= new ListBuilder<TMDbMovieCard>();
  set movies(ListBuilder<TMDbMovieCard> movies) => _$this._movies = movies;

  ShortlistStateBuilder();

  ShortlistStateBuilder get _$this {
    if (_$v != null) {
      _movies = _$v.movies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShortlistState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ShortlistState;
  }

  @override
  void update(void Function(ShortlistStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ShortlistState build() {
    _$ShortlistState _$result;
    try {
      _$result = _$v ?? new _$ShortlistState._(movies: movies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'movies';
        movies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ShortlistState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
