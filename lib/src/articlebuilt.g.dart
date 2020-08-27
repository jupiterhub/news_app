// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articlebuilt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArticleBuilt extends ArticleBuilt {
  @override
  final int id;
  final int score;

  factory _$ArticleBuilt([void Function(ArticleBuiltBuilder) updates]) =>
      (new ArticleBuiltBuilder()..update(updates)).build ();

  _$ArticleBuilt._({this.id}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ArticleBuilt', 'id');
    }
  }

  @override
  ArticleBuilt rebuild(void Function(ArticleBuiltBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleBuiltBuilder toBuilder() => new ArticleBuiltBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleBuilt && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ArticleBuilt')..add('id', id))
        .toString();
  }
}

class ArticleBuiltBuilder
    implements Builder<ArticleBuilt, ArticleBuiltBuilder> {
  _$ArticleBuilt _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ArticleBuiltBuilder();

  ArticleBuiltBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleBuilt other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ArticleBuilt;
  }

  @override
  void update(void Function(ArticleBuiltBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ArticleBuilt build() {
    final _$result = _$v ?? new _$ArticleBuilt._(id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
