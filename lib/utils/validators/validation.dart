
class SHFValidator{

  ///Empty Text Validation
  static String? validationEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required.';
    }

    //Biểu thức chính quy để xác thực email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value){
    if (value == null || value.isEmpty){
      return 'Password is required.';
    }

    //Kiểm tra độ dài mật khẩu tối thiểu
    if (value.length < 6){
      return 'Password must be at least 6 characters long.';
    }

    //Kiểm tra chữ hoa
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one uppercase letter.';
    }

    //Kiểm tra chữ số
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }

    //Kiểm tra ký tự đặc biệt
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?": {}|<>]'))){
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Phone number is required.';
    }

    //Biểu thức chính quy để xác thực số điện thoại (định dạng số điện thoại gồm 10 chữ số)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if(phoneRegExp.hasMatch(value)){
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }
}