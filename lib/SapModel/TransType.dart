class TransType {

  final String id;
  final String transName;
  bool isSelected;

  TransType({required this.id,required this.transName,required this.isSelected});

   factory TransType.fromJson(Map<String, dynamic> json) {
      return new TransType(
         id: json['id'],
         transName: json['Name'].toString(),
         isSelected: false
      );
   }
}