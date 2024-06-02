class UserModel {
    late String id;
   late  String name;
    late String email;
   late  String password;
   late  String goal;

  UserModel({
      required this.id,
     required  this.name,
     required  this.email,
     required this.password,
     required  this.goal,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    goal = json['goal'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'goal': goal,
    };
  }
}
