import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Analytics Controller Group Code

class AnalyticsControllerGroup {
  static String baseUrl = 'http://45.148.31.152:8080/private/analytics';
  static Map<String, String> headers = {};
  static GetMyTotalSpendingsForLastMonthsCall
      getMyTotalSpendingsForLastMonthsCall =
      GetMyTotalSpendingsForLastMonthsCall();
  static GetMySpendingsPerCategoryCall getMySpendingsPerCategoryCall =
      GetMySpendingsPerCategoryCall();
}

class GetMyTotalSpendingsForLastMonthsCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMyTotalSpendingsForLastMonths',
      apiUrl:
          '${AnalyticsControllerGroup.baseUrl}/getMyTotalSpendingsForLastMonths',
      callType: ApiCallType.GET,
      headers: {
        ...AnalyticsControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetMySpendingsPerCategoryCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMySpendingsPerCategory',
      apiUrl: '${AnalyticsControllerGroup.baseUrl}/getMySpendingsPerCategory',
      callType: ApiCallType.GET,
      headers: {
        ...AnalyticsControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Analytics Controller Group Code

/// Start Auth Controller Group Code

class AuthControllerGroup {
  static String baseUrl = 'http://45.148.31.152:8080/public/auth';
  static Map<String, String> headers = {};
  static EmailExistsCall emailExistsCall = EmailExistsCall();
  static LoginCall loginCall = LoginCall();
  static PasswordRecoveryCompleteCall passwordRecoveryCompleteCall =
      PasswordRecoveryCompleteCall();
  static PasswordRecoveryConfirmCodeCall passwordRecoveryConfirmCodeCall =
      PasswordRecoveryConfirmCodeCall();
  static PasswordRecoverySendCodeCall passwordRecoverySendCodeCall =
      PasswordRecoverySendCodeCall();
  static RegistrationConfirmEmailCall registrationConfirmEmailCall =
      RegistrationConfirmEmailCall();
  static RegistrationCreateUserCall registrationCreateUserCall =
      RegistrationCreateUserCall();
  static RegistrationSendEmailCodeCall registrationSendEmailCodeCall =
      RegistrationSendEmailCodeCall();
}

class EmailExistsCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'emailExists',
      apiUrl: '${AuthControllerGroup.baseUrl}/emailExists/${email}',
      callType: ApiCallType.GET,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    final body = '''
{
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${AuthControllerGroup.baseUrl}/login',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PasswordRecoveryCompleteCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'passwordRecovery complete',
      apiUrl:
          '${AuthControllerGroup.baseUrl}/passwordRecovery/complete/${email}/${password}',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PasswordRecoveryConfirmCodeCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? code = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'passwordRecovery confirmCode',
      apiUrl:
          '${AuthControllerGroup.baseUrl}/passwordRecovery/confirmCode/${email}/${code}',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PasswordRecoverySendCodeCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'passwordRecovery sendCode',
      apiUrl:
          '${AuthControllerGroup.baseUrl}/passwordRecovery/sendCode/${email}',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RegistrationConfirmEmailCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? code = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'registration confirmEmail',
      apiUrl:
          '${AuthControllerGroup.baseUrl}/registration/confirmEmail/${email}/${code}',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RegistrationCreateUserCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? firstname = '',
    String? lastname = '',
    String? password = '',
    String? dateOfBirth = '',
    String? gender = '',
  }) {
    final body = '''
{
  "email": "${email}",
  "firstname": "${firstname}",
  "lastname": "${lastname}",
  "password": "${password}",
  "dateOfBirth": "${dateOfBirth}",
  "gender": "${gender}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'registration createUser',
      apiUrl: '${AuthControllerGroup.baseUrl}/registration/createUser',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RegistrationSendEmailCodeCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'registration sendEmailCode',
      apiUrl:
          '${AuthControllerGroup.baseUrl}/registration/sendEmailCode/${email}',
      callType: ApiCallType.POST,
      headers: {
        ...AuthControllerGroup.headers,
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Auth Controller Group Code

/// Start File Controller Group Code

class FileControllerGroup {
  static String baseUrl = 'http://45.148.31.152:8080/public/file';
  static Map<String, String> headers = {};
  static GetCall getCall = GetCall();
  static FilePreviewCall filePreviewCall = FilePreviewCall();
  static SaveCall saveCall = SaveCall();
}

class GetCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'get',
      apiUrl: '${FileControllerGroup.baseUrl}/get/${uuid}',
      callType: ApiCallType.GET,
      headers: {
        ...FileControllerGroup.headers,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class FilePreviewCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'filePreview',
      apiUrl: '${FileControllerGroup.baseUrl}/preview/${uuid}',
      callType: ApiCallType.GET,
      headers: {
        ...FileControllerGroup.headers,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class SaveCall {
  Future<ApiCallResponse> call({
    FFUploadedFile? image,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'save',
      apiUrl: '${FileControllerGroup.baseUrl}/save',
      callType: ApiCallType.POST,
      headers: {
        ...FileControllerGroup.headers,
      },
      params: image != null ? {'file': image} : {},
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}


/// End File Controller Group Code

/// Start Profile Controller Group Code

class ProfileControllerGroup {
  static String baseUrl = 'http://45.148.31.152:8080/private/profile';
  static Map<String, String> headers = {};
  static AssignPictureCall assignPictureCall = AssignPictureCall();
  static GetMyProfileCall getMyProfileCall = GetMyProfileCall();
  static UpdateMyProfileCall updateMyProfileCall = UpdateMyProfileCall();
}

class AssignPictureCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'assignPicture',
      apiUrl: '${ProfileControllerGroup.baseUrl}/assignPicture/${uuid}',
      callType: ApiCallType.POST,
      headers: {
        ...ProfileControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetMyProfileCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMyProfile',
      apiUrl: '${ProfileControllerGroup.baseUrl}/getMyProfile',
      callType: ApiCallType.GET,
      headers: {
        ...ProfileControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class UpdateMyProfileCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? dateOfBirth = '',
    String? firstname = '',
    String? lastname = '',
    String? gender = '',
  }) {
    final body = '''
{
  "dateOfBirth": "${dateOfBirth}",
  "firstname": "${firstname}",
  "gender": "${gender}",
  "lastname": "${lastname}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateMyProfile',
      apiUrl: '${ProfileControllerGroup.baseUrl}/updateMyProfile',
      callType: ApiCallType.PUT,
      headers: {
        ...ProfileControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Profile Controller Group Code

/// Start Receipt Controller Group Code

class ReceiptControllerGroup {
  static String baseUrl = 'http://45.148.31.152:8080/private/receipt';
  static Map<String, String> headers = {};
  static ClaimCall claimCall = ClaimCall();
  static GetAllCall getAllCall = GetAllCall();
  static GetPageableCall getPageableCall = GetPageableCall();
  static ReceiptPreviewCall receiptPreviewCall = ReceiptPreviewCall();
  static PrintAndDownloadReceiptCall printAndDownloadReceiptCall =
      PrintAndDownloadReceiptCall();
}

class ClaimCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'claim',
      apiUrl: '${ReceiptControllerGroup.baseUrl}/claim/${uuid}',
      callType: ApiCallType.POST,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetAllCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAll',
      apiUrl: '${ReceiptControllerGroup.baseUrl}/owner/getAll',
      callType: ApiCallType.GET,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetPageableCall {
  Future<ApiCallResponse> call({
    String? direction = '',
    int? pageNumber,
    int? pageSize,
    String? sortBy = 'id',
    String? token = '',
  }) {
    final body = '''
{
  "direction": "${direction}",
  "pageNumber": ${pageNumber},
  "pageSize": ${pageSize},
  "sortBy": "${sortBy}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getPageable',
      apiUrl: '${ReceiptControllerGroup.baseUrl}/owner/getPageable',
      callType: ApiCallType.POST,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ReceiptPreviewCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'receiptPreview',
      apiUrl: '${ReceiptControllerGroup.baseUrl}/preview/${uuid}',
      callType: ApiCallType.GET,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PrintAndDownloadReceiptCall {
  Future<ApiCallResponse> call({
    String? uuid = '',
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'printAndDownloadReceipt',
      apiUrl:
          '${ReceiptControllerGroup.baseUrl}/printAndDownloadReceipt/${uuid}',
      callType: ApiCallType.GET,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Receipt Controller Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
