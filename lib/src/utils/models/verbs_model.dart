class Verbs {

  final int idVerbs;
  final String descriptionVerbs;
  final int usesVerbs;
  final int fkIdLetterVerbs;

  Verbs({this.idVerbs, this.descriptionVerbs, this.usesVerbs,
    this.fkIdLetterVerbs});

  Map<String, dynamic> toMap() {
    return(
        {
          'id_verb': idVerbs,
          'description': descriptionVerbs,
          'uses': usesVerbs,
          'fk_id_letter': fkIdLetterVerbs
        }
    );
  }
}