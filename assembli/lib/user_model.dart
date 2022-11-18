//example file, not in-use
//commented out

class AppUser {
  String? email;
  int? rnum;
  final String type;

  AppUser(
    {
      this.email,
      this.rnum,
      required this.type
    }
  );

  //factory AppUser.fromJson....
  static AppUser fromJson(Map<String, dynamic> json) =>
  AppUser(
    email: json['email'],
    rnum: json['rnum'],
    type: json['type'],
  );
  //our application doesn't do writing but we'll have this func anyways
  Map<String, dynamic> toJson() => {
    'email': email,
    'rnum': rnum,
    'type': type
  };
}