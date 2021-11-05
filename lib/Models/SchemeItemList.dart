class SchemeItemList {

String itemcode;
   String itemname;

  SchemeItemList({required this.itemcode,required this.itemname});

   factory SchemeItemList.fromJson(Map<String, dynamic> json) {
      return new SchemeItemList(
         itemcode: json['itemCode'].toString(),
         itemname: json['itemName'].toString()
      );
   }
}