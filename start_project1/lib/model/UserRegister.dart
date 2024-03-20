class UserRegister {
  bool success;
  Data data;
  String message;

  UserRegister({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      success: json["success"],
      data: Data.fromJson(json["data"]),
      message: json["message"],
    );
  }
}

class Data {
  String token;
  User user;
  Channel channel;

  Data({
    required this.token,
    required this.user,
    required this.channel,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json["token"],
      user: User.fromJson(json["user"]),
      channel: Channel.fromJson(json["channel"]),
    );
  }
}

class Channel {
  int userId;
  String title;
  dynamic latestMessage;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Channel({
    required this.userId,
    required this.title,
    required this.latestMessage,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      userId: json["user_id"],
      title: json["title"],
      latestMessage: json["latest_message"],
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      id: json["id"],
    );
  }
}

class User {
  int id;
  String username;
  String firstName;
  String lastName;
  dynamic image;
  String gender;
  dynamic bio;
  dynamic dob;
  String mobile;
  dynamic email;
  dynamic membership;
  int active;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.gender,
    required this.bio,
    required this.dob,
    required this.mobile,
    required this.email,
    required this.membership,
    required this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      image: json["image"],
      gender: json["gender"],
      bio: json["bio"],
      dob: json["dob"],
      // Assignment Operators
      mobile: json["mobile"]??"", // json["mobile"] == null  ? "" : json["mobile"] ,
      email: json["email"],
      membership: json["membership"],
      active: json["active"],
    );
  }
}