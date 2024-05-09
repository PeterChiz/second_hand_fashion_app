class SHFValidator {
  ///Empty Text Validation
  static String? validationEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }

    return null;
  }

  /// Kiểm tra Tên người dùng
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Tên người dùng là bắt buộc.';
    }

    // Định nghĩa một biểu thức chính quy cho tên người dùng.
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    // Tạo một đối tượng RegExp từ biểu thức chính quy.
    final regex = RegExp(pattern);

    // Sử dụng phương thức hasMatch để kiểm tra xem tên người dùng có khớp với biểu thức chính quy hay không.
    bool isValid = regex.hasMatch(username);

    // Kiểm tra xem tên người dùng có bắt đầu hoặc kết thúc bằng dấu gạch dưới hoặc dấu gạch ngang không.
    if (isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'Tên người dùng không hợp lệ.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập Email';
    }

    //Biểu thức chính quy để kiểm tra định dạng email theo chuẩn RFC 5322
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Địa chỉ email không hợp lệ.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    //Kiểm tra độ dài mật khẩu tối thiểu
    if (value.length < 6) {
      return 'Mật khẩu phải có độ dài ít nhất 6 ký tự.';
    }

    //Kiểm tra chữ hoa
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải chứa ít nhất một chữ cái viết hoa.';
    }

    //Kiểm tra chữ số
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải chứa ít nhất một chữ số.';
    }

    //Kiểm tra ký tự đặc biệt
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại.';
    }

    //Biểu thức chính quy để xác thực số điện thoại (định dạng số điện thoại gồm 10 hoặc 11 chữ số)
    final phoneRegExp = RegExp(r'^\d{10,11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Định dạng số điện thoại không hợp lệ (yêu cầu 10 hoặc 11 chữ số).';
    }

    return null;
  }
}
