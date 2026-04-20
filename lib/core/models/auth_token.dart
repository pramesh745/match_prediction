class AuthToken {
  String? accessToken;
  User? user;

  AuthToken({this.accessToken, this.user});

  AuthToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user?.toJson(),
    };
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  int? points;
  String? createdAt;
  String? updatedAt;

  dynamic branch;
  List<dynamic>? branches;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.branches,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    points = json['points'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    branch = json['branch'];
    branches = json['branches']; // no parsing needed unless structured
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'points': points,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'branch': branch,
      'branches': branches,
    };
  }
}