class Expense {
  var transId;
  var transDate;
  var account;
  var budget;
  var deptt;
  var state;
  var category;
  var branch;
  var narration;
  var amount;

  Expense(
      { this.account,
         this.amount,
         this.branch,
         this.budget,
         this.category,
         this.deptt,
         this.narration,
         this.state,
         this.transDate,
       this.transId
      }
     );

  factory Expense.fromJson(Map<dynamic, dynamic> json) {
    return Expense(
      account: json['account'],
      amount: json['amount'].toString(),
      branch: json['branch'],
      budget: json['budget'],
      category: json['category'],
      deptt: json['deptt'],
      narration: json['narration'],
      state: json['state'],
      transDate: json['transDate'],
      transId: json['transId'],
    );
  }
  Map<String, dynamic> toJson() => {
        'account': account,
        'amount': amount,
        'branch': branch,
        'budget': budget,
        'category': category,
        'deptt': deptt,
        'narration': narration,
        'state': state,
        'transDate': transDate,
        'transId': transId,
      };

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['account'] = account;
    map['amount'] = amount;
    map['branch'] = branch;
    map['budget'] = budget;
    map['category'] = category;
    map['deptt'] = deptt;
    map['narration'] = narration;
    map['state'] = state;
    map['transDate'] = transDate;
    map['transId'] = transId;
    return map;
  }
}
