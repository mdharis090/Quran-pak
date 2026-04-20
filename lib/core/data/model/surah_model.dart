class Surah {
  final int number;
  final String name;

  Surah({
    required this.number,
    required this.name,
  });

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
      number: map['surahNumber'] ?? map['number'],
      name: map['surahName'] ?? map['name'],
    );
  }

  ///  copyWith method
  Surah copyWith({
    int? number,
    String? name,
  }) {
    return Surah(
      number: number ?? this.number,
      name: name ?? this.name,
    );
  }

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'surahNumber': number,
      'surahName': name,
    };
  }

  ///  toString
  @override
  String toString() => 'Surah(number: $number, name: $name)';

  void operator [](String other) {}
}