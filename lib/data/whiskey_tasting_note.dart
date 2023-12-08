import 'tasting_note_detail.dart';

class WhiskeyTastingNote {
  String name;
  String wbCode;
  String abv;
  Map<String, TastingNoteDetails> notes; // Nose, Palate, Finish에 대한 정보

  WhiskeyTastingNote(
      {this.name = '', this.wbCode = '', this.abv = '', required this.notes});
}
