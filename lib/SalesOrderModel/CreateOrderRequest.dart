import 'package:http/http.dart' as http;
import 'package:myproject/utils/Constant.dart';
import 'dart:convert';
import 'OrderItem.dart';

final createPrimaryOrderurl =Constant.ip_url + "Sap/createPrimaryOrder";

Future<http.Response> createPrimaryOrder(
    Map<String, dynamic> postJsonData) async {
  // showToast("inside createSapRightsfunc");
  var body = json.encode(postJsonData);
  var response = await http.post(Uri.parse(createPrimaryOrderurl),
      headers: {"Content-Type": "application/json"}, body: body);
  return response;
}

String getLineNum(List<OrderItem>? items) {
  String lineNum = "0";

  if (items != null && items.length > 0) {
    lineNum = items[items.length - 1].lineNum;
  }

  int lineNo = int.parse(lineNum);
  lineNo++;
  return lineNo.toString();
}

class CreateOrderRequest {
  var docEntry;
  var docNum;
  var docDate;
  var cardCode;
  var cardName;
  var delDate;
  var prefTime;
  var paymentTerms;
  var remarks;
  var createdBy;
  var createdOn;
  var canceled;
  var canceledDate;
  var updateDate;
  var status;
  List<OrderItem>? items;

  CreateOrderRequest(
      { this.docEntry,
         this.docNum,
         this.docDate,
         this.cardCode,
         this.cardName,
         this.delDate,
         this.prefTime,
         this.paymentTerms,
         this.createdBy,
         this.remarks,
         this.createdOn,
         this.canceled,
         this.canceledDate,
         this.updateDate,
         this.status,
         this.items});

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    List<OrderItem> items = (json['items'] as List)
        .map((itemSaleJson) => OrderItem.fromJson(itemSaleJson))
        .toList();

    return CreateOrderRequest(
        docEntry: json['DocEntry'],
        docNum: json['DocNum'],
        docDate: json['DocDate'],
        cardCode: json['CardCode'],
        cardName: json['CardName'],
        delDate: json['DelDate'],
        prefTime: json['PrefTime'],
        paymentTerms: json['PaymentTerms'],
        remarks: json['Remarks'],
        createdBy: json['CreatedBy'],
        createdOn: json['CreatedOn'],
        canceled: json['Canceled'],
        canceledDate: json['CanceledDate'],
        updateDate: json['UpdateDate'],
        status: json['Status'],
        items: items);
  }

  Map<String, dynamic> toJson() => {
        'DocEntry': docEntry,
        'DocNum': docNum,
        'DocDate': docDate,
        'CardCode': cardCode,
        'CardName': cardName,
        'DelDate': delDate,
        'PrefTime': prefTime,
        'PaymentTerms': paymentTerms,
        'Remarks': remarks,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'Canceled': canceled,
        'CanceledDate': canceledDate,
        'UpdateDate': updateDate,
        'Status': status,
        'items': items,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["DocEntry"] = docEntry;
    map["DocNum"] = docNum;
    map["DocDate"] = docDate;
    map["CardCode"] = cardCode;
    map["CardName"] = cardName;
    map["DelDate"] = delDate;
    map["PrefTime"] = prefTime;
    map["PaymentTerms"] = paymentTerms;
    map["Remarks"] = remarks;
    map["CreatedBy"] = createdBy;
    map["CreatedOn"] = createdOn;
    map["Canceled"] = canceled;
    map["CanceledDate"] = canceledDate;
    map["UpdateDate"] = updateDate;
    map["Status"] = status;
    map["items"] = items;

    return map;
  }

}
