class UserBalance {
  final String id;
  final double balance;

  UserBalance({this.id, this.balance});

  UserBalance.fromMap(Map snapshot, String id)
      : id = 'id' ?? '',
        balance = snapshot['balance'] ?? '';

  toJson() {
    return {
      'balance': balance,
    };
  }
}
