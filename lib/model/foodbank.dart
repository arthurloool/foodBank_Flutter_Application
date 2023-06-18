import 'package:json_annotation/json_annotation.dart';

part "foodbank.g.dart";

@JsonSerializable()
class FoodBank {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "closed", defaultValue: false)
  final bool closed;

  @JsonKey(name: "network")
  final String? network;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "secondary_phone", defaultValue: "")
  String? secondaryphone;

  @JsonKey(name: "emial")
  final String? email;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "postcode")
  final String? postcode;

  @JsonKey(name: "country")
  final String? country;

  @JsonKey(name: "district")
  final String? district;

  @JsonKey(name: "lat_lng")
  final String? coordinates;

  @JsonKey(name: "urls")
  final Map<String, String?> website;

  @JsonKey(name: "charity")
  final Map<String, String?> charity;

  @JsonKey(name: "needs")
  final Map<String, dynamic>? needs;

  FoodBank(
      this.name,
      this.closed,
      this.network,
      this.phone,
      this.secondaryphone,
      this.email,
      this.address,
      this.postcode,
      this.country,
      this.district,
      this.coordinates,
      this.website,
      this.charity,
      this.needs);

  factory FoodBank.fromJson(Map<String, dynamic> json) =>
      _$FoodBankFromJson(json);

  Map<String, dynamic> toJson() => _$FoodBankToJson(this);
}
