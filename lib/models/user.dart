
class User {

  int id;
  String screenName;
  String name;
  String province;
  String city;
  String location;
  String description;
  String url;
  String profileImageUrl;
  String domain;
  String gender;
  int followersCount;
  int friendsCount;
  int statusesCount;
  int favouritesCount;
  String createdAt;
  bool following;
  bool allowAllActMsg;
  bool geoEnabled;
  bool verified;
  bool allowAllComment;
  String avatarLarge;
  String verifiedReason;
  bool followMe;
  int onlineStatus;
  int biFollowersCount;

  User.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        screenName = map["screen_name"],
        name = map["name"],
        province = map["province"],
        city = map["city"],
        location = map["location"],
        description = map["description"],
        url = map["url"],
        profileImageUrl = map["profile_image_url"],
        domain = map["domain"],
        gender = map["gender"],
        followersCount = map["followers_count"],
        friendsCount = map["friends_count"],
        statusesCount = map["statuses_count"],
        favouritesCount = map["favourites_count"],
        createdAt = map["created_at"],
        following = map["following"],
        allowAllActMsg = map["allow_all_act_msg"],
        geoEnabled = map["geo_enabled"],
        verified = map["verified"],
        allowAllComment = map["allow_all_comment"],
        avatarLarge = map["avatar_large"],
        verifiedReason = map["verified_reason"],
        followMe = map["follow_me"],
        onlineStatus = map["online_status"],
        biFollowersCount = map["bi_followers_count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['screen_name'] = screenName;
    data['name'] = name;
    data['province'] = province;
    data['city'] = city;
    data['location'] = location;
    data['description'] = description;
    data['url'] = url;
    data['profile_image_url'] = profileImageUrl;
    data['domain'] = domain;
    data['gender'] = gender;
    data['followers_count'] = followersCount;
    data['friends_count'] = friendsCount;
    data['statuses_count'] = statusesCount;
    data['favourites_count'] = favouritesCount;
    data['created_at'] = createdAt;
    data['following'] = following;
    data['allow_all_act_msg'] = allowAllActMsg;
    data['geo_enabled'] = geoEnabled;
    data['verified'] = verified;
    data['allow_all_comment'] = allowAllComment;
    data['avatar_large'] = avatarLarge;
    data['verified_reason'] = verifiedReason;
    data['follow_me'] = followMe;
    data['online_status'] = onlineStatus;
    data['bi_followers_count'] = biFollowersCount;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, screen_name: $screenName, name: $name, province: $province, city: $city, location: $location, description: $description, url: $url, profileImageUrl: $profileImageUrl, domain: $domain, gender: $gender, followersCount: $followersCount, friendsCount: $friendsCount, statusesCount: $statusesCount, favouritesCount: $favouritesCount, createdAt: $createdAt, following: $following, allowAllActMsg: $allowAllActMsg, geoEnabled: $geoEnabled, verified: $verified, allowAllComment: $allowAllComment, avatarLarge: $avatarLarge, verifiedReason: $verifiedReason, followMe: $followMe, onlineStatus: $onlineStatus, biFollowersCount: $biFollowersCount}';
  }


}
