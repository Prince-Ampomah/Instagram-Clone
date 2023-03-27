class PlaceSuggestionModel {
  String? placeId;
  String? description, mainText, secondaryText;
  List<dynamic>? term;
  Map<String, dynamic>? structuredFormating;

  PlaceSuggestionModel(
      {this.placeId,
      this.description,
      this.term,
      this.structuredFormating,
      this.mainText,
      this.secondaryText});
}
