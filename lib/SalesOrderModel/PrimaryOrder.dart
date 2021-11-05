import 'PrimaryOrderItem.dart';

class PrimaryOrder {
  final String docEntry;
  final String docNum;
  final String docDate;
  final String cardCode;
  final String cardName;
  final String delDate;
  final String prefTime;
  final String paymentTerms;
  final String remarks;
  final String createdBy;
  final String createdOn;
  final String canceled;
  final String canceledDate;
  final String updateDate;
  final String status;
   List<PrimaryOrderItem> items;

  PrimaryOrder(
      {required this.docEntry,
        required this.docNum,
        required this.docDate,
        required this.cardCode,
        required this.cardName,
        required this.delDate,
        required this.prefTime,
        required this.paymentTerms,
        required this.createdBy,
        required this.remarks,
        required this.createdOn,
        required this.canceled,
        required this.canceledDate,
        required this.updateDate,
        required this.status,
        required this.items});

  factory PrimaryOrder.fromJson(Map<String, dynamic> json) {
    
    return PrimaryOrder(
      docEntry: json['DocEntry'].toString(),
      docNum: json['DocNum'].toString(),
      docDate: json['DocDate'],
      cardCode: json['CardCode'],
      cardName: json['CardName'],
      delDate: json['DelDate'],
      prefTime: json['PrefTime'],
      paymentTerms: json['PaymentTerms'],
      remarks: json['Remarks'],
      createdBy: json['CreatedBy'].toString(),
      createdOn: json['CreatedOn'],
      canceled: json['Canceled'],
      canceledDate: json['CanceledDate'],
      updateDate: json['UpdateDate'],
      status: json['Status'],
      items: json['Items'],
    );
  }
}
