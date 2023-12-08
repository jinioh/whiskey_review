import 'package:flutter/cupertino.dart';

import '../data/tasting_note_detail.dart';
import '../data/whiskey_tasting_note.dart';

class WhiskeyTastingNoteProvider with ChangeNotifier {
  final WhiskeyTastingNote _tastingNote = WhiskeyTastingNote(
    notes: {
      'Nose': TastingNoteDetails(),
      'Palate': TastingNoteDetails(),
      'Finish': TastingNoteDetails(),
    },
  );

  WhiskeyTastingNote get tastingNote => _tastingNote;

  void updateTastingNote(String label, TastingNoteDetails details) {
    _tastingNote.notes[label] = details;
    notifyListeners();
  }

  void updateWhiskeyInfo(String name, String wbCode, String abv) {
    _tastingNote.name = name;
    _tastingNote.wbCode = wbCode;
    _tastingNote.abv = abv;
    notifyListeners();
  }
}
