class TastingNoteDetails {
  int totalScore;
  Set<String> elements;
  String comment;

  TastingNoteDetails(
      {this.totalScore = 0, this.elements = const {}, this.comment = ''});
}
