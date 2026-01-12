import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';

class UserModel {
  final String membersId,
      username,
      token,
      fullName,
      userType,
      phoneNumber,
      whatsappNumber,
      email,
      autoPay,
      address,
      pin; // Moved pin here

  // These fields can be null as they are not guaranteed from the API
  final String? resetCode,
      resetTime,
      deletedTime,
      tag,
      isPinSet; // isPinSet and tag are now nullable

  final int phoneVerified, emailVerified, tier, bvnVerified;
  final double wallet, bonus;

  UserModel({
    required this.membersId,
    required this.username,
    required this.token,
    required this.fullName,
    required this.userType,
    required this.phoneNumber,
    required this.phoneVerified,
    required this.emailVerified,
    required this.whatsappNumber,
    required this.email,
    required this.wallet,
    required this.pin,
    this.resetCode,
    this.resetTime,
    required this.autoPay,
    required this.address,
    this.deletedTime,
    required this.tier,
    this.tag,
    this.isPinSet,
    required this.bvnVerified,
    required this.bonus,
  });

  factory UserModel.empty() {
    return UserModel(
      membersId: '',
      username: '',
      token: '',
      fullName: '',
      userType: '',
      phoneNumber: '',
      phoneVerified: 0,
      emailVerified: 0,
      whatsappNumber: '',
      email: '',
      wallet: 0.0,
      pin: '',
      autoPay: '',
      address: '',
      deletedTime: null,
      tier: 0,
      tag: null,
      isPinSet: null,
      bvnVerified: 0,
      bonus: 0.0,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      membersId: json['members_id'] ?? '',
      username: (json['username'] as String? ?? '').toCapitalized(),
      token: json['token'] ?? '',
      fullName: (json['full_name'] as String? ?? '').toTitleCase(),
      userType: (json['user_type'] as String? ?? '').toCapitalized(),
      phoneNumber: json['phone_number'] ?? '',
      phoneVerified: json['phone_verified'] is String
          ? int.tryParse(json['phone_verified']) ?? 0
          : (json['phone_verified'] as int? ?? 0),
      whatsappNumber: json['whatsapp_number'] ?? '',
      email: (json['email'] as String? ?? '').toCapitalized(),
      // FIX: Corrected key name from 'emailVerified' to 'email_verified'
      emailVerified: json['email_verified'] is String
          ? int.tryParse(json['email_verified']) ?? 0
          : (json['email_verified'] as int? ?? 0),
      wallet: json['wallet'] is String
          ? double.tryParse(json['wallet']) ?? 0.0
          : (json['wallet'] as num? ?? 0.0).toDouble(),
      pin: json['pin'] ?? '',
      resetCode: json['reset_code'] as String?,
      resetTime: json['reset_time'] as String?,
      autoPay: (json['autoPay'] as String? ?? '').toCapitalized(),
      address: json['address'] ?? '',
      deletedTime: json['deleted_time'] as String?,
      tier: json['tier'] is String
          ? int.tryParse(json['tier']) ?? 0
          : (json['tier'] as int? ?? 0),
      // FIX: These fields are not in the response, so we need to handle them gracefully.
      // We are now passing null, which the nullable properties can handle.
      tag: json['tag'] as String?,
      isPinSet: json['isPinSet'] as String?,
      bvnVerified: json['bvn_verified'] is String
          ? int.tryParse(json['bvn_verified']) ?? 0
          : (json['bvn_verified'] as int? ?? 0),
      bonus: json['bonus'] is String  
          ? double.tryParse(json['bonus']) ?? 0.0
          : (json['bonus'] as num? ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'members_id': membersId,
      'username': username,
      'token': token,
      'full_name': fullName,
      'user_type': userType,
      'phone_number': phoneNumber,
      'phone_verified': phoneVerified,
      'email_verified': emailVerified,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'wallet': wallet,
      'pin': pin,
      'reset_code': resetCode,
      'reset_time': resetTime,
      'autoPay': autoPay,
      'address': address,
      'deleted_time': deletedTime,
      'tier': tier,
      'tag': tag,
      'isPinSet': isPinSet,
      'bvn_verified': bvnVerified,
      'bonus': bonus,
    };
  }
}
