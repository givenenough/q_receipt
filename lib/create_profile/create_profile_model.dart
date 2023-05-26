import '../flutter_flow/form_field_controller.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateProfileModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (save)] action in NetworkImageFromBytes widget.
  ApiCallResponse? apiResultl8s;
  // Stores action output result for [Backend Call - API (assignPicture)] action in NetworkImageFromBytes widget.
  ApiCallResponse? apiResultt9q;
  // State field(s) for name widget.
  TextEditingController? nameController1;
  String? Function(BuildContext, String?)? nameController1Validator;
  // State field(s) for name widget.
  TextEditingController? nameController2;
  String? Function(BuildContext, String?)? nameController2Validator;
  DateTime? datePicked;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - API (updateMyProfile)] action in Button widget.
  ApiCallResponse? apiResultraw;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    nameController1?.dispose();
    nameController2?.dispose();
  }

  /// Additional helper methods are added here.

}
