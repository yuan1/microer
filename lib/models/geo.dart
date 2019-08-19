
class Geo {

  String longitude;
  String latitude;
  String city;
  String province;
  String address;
  String pinyin;
  String more;

	Geo.fromJsonMap(Map<String, dynamic> map): 
		longitude = map["longitude"],
		latitude = map["latitude"],
		city = map["city"],
		province = map["province"],
		address = map["address"],
		pinyin = map["pinyin"],
		more = map["more"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['longitude'] = longitude;
		data['latitude'] = latitude;
		data['city'] = city;
		data['province'] = province;
		data['address'] = address;
		data['pinyin'] = pinyin;
		data['more'] = more;
		return data;
	}

	@override
	String toString() {
		return 'Geo{longitude: $longitude, latitude: $latitude, city: $city, province: $province, address: $address, pinyin: $pinyin, more: $more}';
	}

}
