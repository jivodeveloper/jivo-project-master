class OrderItem {
  var docEntry;
  var createdBy;
  var createdOn;
  var canceled;
  var canceledDate;
  var updateDate;
  var status;
  var lineNum;
  var id;
  var itemCode;
  var itemName;
  var quantity;
  var boxQty;
  var uOM;
  var retSchemeQty;
  var itmRemarks;
  OrderItem(
      { this.docEntry,
        this.createdBy,
        this.createdOn,
        this.canceled,
        this.canceledDate,
        this.updateDate,
        this.status,
         this.lineNum,
         this.id,
         this.itemCode,
         this.itemName,
         this.quantity,
         this.boxQty,
         this.uOM,
         this.retSchemeQty,
         this.itmRemarks});

  OrderItem.fromJson(Map<String, dynamic> json)
      : docEntry = json['DocEntry'].toString(),
        createdBy = json['CreatedBy'].toString(),
        createdOn = json['CreatedOn'],
        canceled = json['Canceled'],
        canceledDate = json['CanceledDate'],
        updateDate = json['UpdateDate'],
        status = json['Status'],
        lineNum = json['LineNum'].toString(),
        id = json['id'].toString(),
        itemCode = json['ItemCode'],
        itemName = json['ItemName'],
        quantity = json['Quantity'].toString(),
        boxQty = json['BoxQty'].toString(),
        itmRemarks = json['ItmRemarks'],
        uOM = json['UOM'],
        retSchemeQty = json['RetSchemeQty'].toString();

  Map<String, dynamic> toJson() => {
        'DocEntry': docEntry,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn,
        'Canceled': canceled,
        'CanceledDate': canceledDate,
        'UpdateDate': updateDate,
        'Status': status,
        'LineNum': lineNum,
        'id': id,
        'ItemCode': itemCode,
        'ItemName': itemName,
        'Quantity': quantity,
        'BoxQty': boxQty,
        'ItmRemarks': itmRemarks,
        'UOM': uOM,
        'RetSchemeQty': retSchemeQty,
        'Status': status
      };
}
