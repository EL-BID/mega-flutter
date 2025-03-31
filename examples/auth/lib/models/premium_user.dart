import 'package:mega_flutter/mega_flutter.dart';

class PremiumUser extends User {
  final DateTime subscriptionExpiresAt;

  PremiumUser({
    required String name,
    required this.subscriptionExpiresAt,
  }) : super(name: name);

  factory PremiumUser.fromJson(Map<String, dynamic> json) {
    return PremiumUser(
      name: User.fromJson(json).name,
      subscriptionExpiresAt: DateTime.parse(json['subscriptionExpiresAt']),
    );
  }
}
