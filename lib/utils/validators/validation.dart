
class SHFValidator{

  ///Empty Text Validation
  static String? validationEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập $fieldName';
    }

    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập Email';
    }

    //Biểu thức chính quy để kiểm tra định dạng email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Địa chỉ email không hợp lệ.';
    }

    return null;
  }

  static String? validatePassword(String? value){
    if (value == null || value.isEmpty){
      return 'Vui lòng nhập mật khẩu';
    }

    //Kiểm tra độ dài mật khẩu tối thiểu
    if (value.length < 6){
      return 'Mật khẩu phải có độ dài ít nhất 6 ký tự.';
    }

    //Kiểm tra chữ hoa
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Mật khẩu phải chứa ít nhất một chữ cái viết hoa.';
    }

    //Kiểm tra chữ số
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Mật khẩu phải chứa ít nhất một chữ số.';
    }

    //Kiểm tra ký tự đặc biệt
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?": {}|<>]'))){
      return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập số điện thoại.';
    }

    //Biểu thức chính quy để xác thực số điện thoại (định dạng số điện thoại gồm 10 hoặc 11 chữ số)
    final phoneRegExp1 = RegExp(r'^\d{9}$');

    if(phoneRegExp1.hasMatch(value)){
      return 'Định dạng số điện thoại không hợp lệ (yêu cầu 10 chữ số).';
    }

    return null;
  }
}