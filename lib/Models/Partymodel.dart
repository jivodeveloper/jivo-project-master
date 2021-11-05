class PartyModel {

   String cardCode;
   String cardName;

  PartyModel({required this.cardCode,required this.cardName});

   factory PartyModel.fromJson(Map<String, dynamic> json) {
      return new PartyModel(
         cardCode: json['CardCode'].toString(),
         cardName: json['CardName'].toString()
      );
   }
}