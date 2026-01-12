


class SignupModel {


 final String  username, email, phoneNumber, platform, password;

  SignupModel({required this.username, required this.email, required this.phoneNumber, this.platform = "MyTrader", required this.password, });


//helper function to get the full name
//String get fullName => '$firstName $lastName';

//format phone number

//String get formattedPhoneNo => RFormatter.formatPhoneNumber(phoneNumber);

//static List<String> nameParts(fullName) => fullName.split(" ");


//static function to create an empty user model
static SignupModel empty() => SignupModel(username: '', email: '', phoneNumber: '', platform: '', password: '');

//convert model to json structure for storing data in firebase
Map<String, dynamic> toJson() {
  return {
    'username': username,
    'email': email,
    'phone_number': phoneNumber,
    'password': password,
    'platform': platform,
  };
}

}