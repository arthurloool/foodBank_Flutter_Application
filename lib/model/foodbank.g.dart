// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodbank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodBank _$FoodBankFromJson(Map<String, dynamic> json) => FoodBank(
      json['name'] as String?,
      json['closed'] as bool? ?? false,
      json['network'] as String?,
      json['phone'] as String?,
      json['secondary_phone'] as String? ?? '',
      json['emial'] as String?,
      json['address'] as String?,
      json['postcode'] as String?,
      json['country'] as String?,
      json['district'] as String?,
      json['lat_lng'] as String?,
      Map<String, String?>.from(json['urls'] as Map),
      Map<String, String?>.from(json['charity'] as Map),
      json['needs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FoodBankToJson(FoodBank instance) => <String, dynamic>{
      'name': instance.name,
      'closed': instance.closed,
      'network': instance.network,
      'phone': instance.phone,
      'secondary_phone': instance.secondaryphone,
      'emial': instance.email,
      'address': instance.address,
      'postcode': instance.postcode,
      'country': instance.country,
      'district': instance.district,
      'lat_lng': instance.coordinates,
      'urls': instance.website,
      'charity': instance.charity,
      'needs': instance.needs,
    };
