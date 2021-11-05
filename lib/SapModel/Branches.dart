class Branches {

  final String id;
  final String name;

  Branches({required this.id,required this.name});

   factory Branches.fromJson(Map<String, dynamic> json) {
      return new Branches(
         id: json['id'],
         name: json['Name'].toString()
      );
   }
}