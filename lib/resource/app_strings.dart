class AppStrings {
  // Length Constants
  static const int contactNoMinLength = 10;
  static const int contactNoMaxLength = 10;
  static const int passwordMinLength = 8;
  static const int quantityLength = 10;
  static const int priceLength = 10;
  static const int otpLength = 4;
  static const int weightLength = 4;
  static const int favBrandLength = 6;

  static const int paginationLimit10 = 10;

  // Date Format
  static const String dfYMD = 'yyyy-MM-dd';
  static const String dfCalendarDialog = 'd MMM yyyy';
  static const String dfIso = 'yyyy-MM-dd HH:mm:ss.mmm';
  static const String dfIso1 = 'yyyy-MM-dd HH:mm:ss.mmmuuu';
  static const String df24Hour = 'yyyy-MM-dd HH:mm:ss';

  // Regular Expressions
  static const String regexCharactersOnly = '[a-zA-Z]';
  static const String regexCharactersWithSpace = '[a-zA-Z ]';
  static const String regexEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String strNoInternetConnection = 'No Internet Connection';
  static const String strConnectionTimeout = 'Connection Timeout';
  static const String strNoData = 'No Data';
  static const String strDot = '.';

  static const String strAppName = 'ToDo';
  static const String strEmployeeList = 'Employee List';
  static const String strAddEmployeeDetails = 'Add Employee Details';
  static const String strEditEmployeeDetails = 'Edit Employee Details';
  static const String strCancel = 'Cancel';
  static const String strSave = 'Save';
  static const String strEmployeename = 'Employee name';
  static const String strEnteremployeename = 'Enter employee name';
  static const String strSelectrole = 'Select role';
  static const String strFromdate = 'From date';
  static const String strSelectfromdate = 'Select from date';
  static const String strTodate = 'To date';
  static const String strSelecttodate = 'Select to date';
  static const String strNoDate = 'No Date';
  static const String strCurrentemployees = 'Current employees';
  static const String strPreviousemployees = 'Previous employees';
  static const String strFrom = 'From ';
  static const String strAlertDeleteEmployee =
      'Are you sure do you want to delete this employee?';
  static const String strNo = 'No';
  static const String strYes = 'Yes';
  static const String strPleaseSelectDate = 'Please, Select date';
  static const String strPleaseSelectFromDate = 'Please select from date first';
  static const String strToday = 'Today';
  static const String strNextMonday = 'Next Monday';
  static const String strNextTuesday = 'Next Tuesday';
  static const String strAfter1Week = 'After 1 Week';
  static const String strAlertDateInvalid =
      'To date can not be before from date';
}
