class User {
  String name; // 友好显示名称
  String location; // 用户所在地
  String description; // 用户个人描述
  String url; // 用户博客地址
  String profileImageUrl; // 用户头像地址（中图），50×50像素
  String profileUrl; // 用户的微博统一URL地址
  String gender; // 性别，m：男、f：女、n：未知
  num followersCount; // 粉丝数
  num friendsCount; // 关注数
  num statusesCount; // 微博数
  num favouritesCount; // 收藏数
  String avatarLarge; // 用户头像地址（大图），180×180像素
  String avatarHd; // 用户头像地址（高清），高清头像原图
  bool followMe; // 该用户是否关注当前登录用户，true：是，false：否
  num onlineStatus; //用户的在线状态，0：不在线、1：在线
  num biFollowersCount; // 用户的互粉数

  
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        location = json['location'],
        url = json['url'],
        profileUrl = json['profile_url'],
        gender = json['gender'],
        followersCount = json['followers_count'],
        friendsCount = json['friends_count'],
        statusesCount = json['statuses_count'],
        favouritesCount = json['favourites_count'],
        avatarLarge = json['avatar_large'],
        avatarHd = json['avatar_hd'],
        followMe = json['follow_me'],
        onlineStatus = json['online_status'],
        biFollowersCount = json['bi_followers_count'],
        profileImageUrl = json['profile_image_url'];

  Map<String, dynamic> toJson()=>{
    'name':name,
    'location':location,
    'url':url,
    'profile_url':profileUrl,
    'gender':gender,
    'followers_count':followersCount,
    'friends_count':friendsCount,
    'statuses_count':statusesCount,
    'favourites_count':favouritesCount,
    'avatar_large':avatarLarge,
    'avatar_hd':avatarHd,
    'follow_me':followMe,
    'online_status':onlineStatus,
    'bi_followers_count':biFollowersCount,
    'profile_image_url':profileImageUrl,
  };

  @override
  String toString() {
    return 'User{name: $name, location: $location, description: $description, url: $url, profileImageUrl: $profileImageUrl, profileUrl: $profileUrl, gender: $gender, followersCount: $followersCount, friendsCount: $friendsCount, statusesCount: $statusesCount, favouritesCount: $favouritesCount, avatarLarge: $avatarLarge, avatarHd: $avatarHd, followMe: $followMe, onlineStatus: $onlineStatus, biFollowersCount: $biFollowersCount}';
  }


}
