class Language {
  const Language({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  // @override
  // int get hashCode => hashValues(name.hashCode, id.hashCode);
}
