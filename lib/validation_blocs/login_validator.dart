import 'dart:async';

class LoginValidator {
  final validateMobileNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
    if (mobile.isEmpty) {
      sink.addError('Enter mobile no.');
      }else if(mobile.length!=10){
        sink.addError('Enter valid mobile no.');
      } else {
        sink.add(mobile);
      }
    
  });
  final validatepassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      sink.addError('Enter your password');
    } else {
      sink.add(password);
    }
  });
}