
class Limit {
  final String cardCode;
  final double currentLimit;
  final int createdBy;
  final double newLimit;
  final String validTill;

  Limit({required this.cardCode,required this.currentLimit, required this.newLimit,required this.validTill,required this.createdBy});

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      cardCode: json['CardCode'],
      currentLimit: json['CurrentLimit'],
      newLimit: json['NewLimit'],
      validTill: json['ValidTill'],
      createdBy:json['createdBy']
    );
  }

  Map<String, dynamic> toJson() => {
        'CardCode': cardCode,
        'CurrentLimit': currentLimit,
        'NewLimit': newLimit,
        'ValidTill': validTill,
        'createdBy':createdBy,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["CardCode"] = cardCode;
    map["CurrentLimit"] = currentLimit;
    map["NewLimit"] = newLimit;
    map["createdBy"]=createdBy;
    map["ValidTill"] = validTill;
    return map;
  }
}
