class User {
  int id;
  String name;
  String email;
  String npm;
  String phone;

  User(this.id, this.name, this.email, this.npm, this.phone);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        npm = json['npm'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'npm': npm,
        'phone': phone,
      };
}
