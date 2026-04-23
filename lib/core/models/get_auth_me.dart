class GetAuthMe {
  String? id;
  String? name;
  String? email;
  String? role;
  int? points;
  String? createdAt;
  String? updatedAt;
  Branch? branch;
  List<Branch>? branches;

  GetAuthMe({
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

  /// FROM JSON
  factory GetAuthMe.fromJson(Map<String, dynamic> json) {
    return GetAuthMe(
      id: json['id']?.toString(),
      name: json['name'],
      email: json['email'],
      role: json['role'],
      points: json['points'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      branch: json['branch'] != null
          ? Branch.fromJson(json['branch'])
          : null,
      branches: json['branches'] != null
          ? List<Branch>.from(
        json['branches'].map((x) => Branch.fromJson(x)),
      )
          : [],
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "points": points,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "branch": branch?.toJson(),
      "branches": branches != null
          ? List<dynamic>.from(branches!.map((x) => x.toJson()))
          : [],
    };
  }
}

class Branch {
  String? id;
  String? name;
  String? address; // optional (safe to include extra fields)

  Branch({
    this.id,
    this.name,
    this.address,
  });

  /// FROM JSON
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id']?.toString(),
      name: json['name'],
      address: json['address'], // will be null if not present
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
    };
  }
}