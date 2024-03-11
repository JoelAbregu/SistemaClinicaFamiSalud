class Cie {
  final String code;
  final String description;

  Cie({required this.code, required this.description});
  @override
  String toString() {
    return code;
  }

  bool filter(String query) {
    return code.toLowerCase().contains(query.toLowerCase());
  }
}
