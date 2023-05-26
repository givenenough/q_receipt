import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_drop_down.dart';
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
import 'create_profile_model.dart';
export 'create_profile_model.dart';
import '/flutter_flow/custom_functions.dart' as functions;


class CreateProfileWidget extends StatefulWidget {
  const CreateProfileWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String? token;


  @override
  _CreateProfileWidgetState createState() => _CreateProfileWidgetState();
}

class _CreateProfileWidgetState extends State<CreateProfileWidget> {
  late CreateProfileModel _model;

  final _unfocusNode = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProfileModel());
    print(widget.token);

  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
    child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFDD1E5F),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Edit your Profile',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryBtnText,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding (
    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
    child: FutureBuilder<ApiCallResponse>(
          future: ProfileControllerGroup.getMyProfileCall.call(
            token: widget.token,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              );
            }
            final columnGetMyProfileResponse = snapshot.data!;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (!_isButtonEnabled) {
                            return;
                          }
                          _isButtonEnabled = false;

                          final selectedMedia =
                              await selectMediaWithSourceBottomSheet(
                            context: context,
                            allowPhoto: true,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            setState(() => _model.isDataUploading = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            try {
                              selectedUploadedFiles = selectedMedia
                                  .map((m) => FFUploadedFile(
                                        name: m.storagePath.split('/').last,
                                        bytes: m.bytes,
                                        height: m.dimensions?.height,
                                        width: m.dimensions?.width,
                                        blurHash: m.blurHash,
                                      ))
                                  .toList();
                            } finally {
                              _model.isDataUploading = false;
                            }
                            if (selectedUploadedFiles.length ==
                                selectedMedia.length) {
                              setState(() {
                                _model.uploadedLocalFile =
                                    selectedUploadedFiles.first;
                              });
                            } else {
                              setState(() {});
                              return;
                            }
                          }

                          _model.apiResultl8s =
                              await FileControllerGroup.saveCall.call(
                            image: _model.uploadedLocalFile,
                          );
                          if ((_model.apiResultl8s?.succeeded ?? true)) {
                            String cleanedUuid = _model.apiResultl8s?.bodyText.replaceAll('"', '') ?? '';
                            _model.apiResultt9q = await ProfileControllerGroup
                                .assignPictureCall
                                .call(
                              uuid: cleanedUuid,
                              token: widget.token,
                            );
                            if (!(_model.apiResultt9q?.succeeded ?? true)) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Assign picture fail'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('File upload fail'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          _isButtonEnabled = true;
                          setState(() {});
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: custom_widgets.NetworkImageFromBytes(
                            width: 100.0,
                            height: 100.0,
                            url: getJsonField(
                              columnGetMyProfileResponse.jsonBody,
                              r'''$.picture''',
                            ) != null
                                ? 'http://45.148.31.152:8080/public/file/preview/${getJsonField(
                              columnGetMyProfileResponse.jsonBody,
                              r'''$.picture''',
                            ).toString()}'
                                : 'http://45.148.31.152:8080/public/file/preview/80cfc176-9879-4908-b937-543cc8391dd6',
                            borderRadius: 15.0,
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _model.nameController1 ??=
                                TextEditingController(
                                  text: getJsonField(
                                    columnGetMyProfileResponse.jsonBody,
                                    r'''$.firstname''',
                                  ).toString(),
                                ),
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your name here...',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 0.0, 24.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: null,
                            validator: _model.nameController1Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _model.nameController2 ??=
                                TextEditingController(
                                  text: getJsonField(
                                    columnGetMyProfileResponse.jsonBody,
                                    r'''$.lastname''',
                                  ).toString(),
                                ),
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Surname',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your surname here...',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 0.0, 24.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: null,
                            validator: _model.nameController2Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            print(functions.stringToDate(getJsonField(
                              columnGetMyProfileResponse.jsonBody,
                              r'''$.dateOfBirth''',
                            ).toString()));
                            final _datePickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                              functions.stringToDate(getJsonField(
                                columnGetMyProfileResponse.jsonBody,
                                r'''$.dateOfBirth''',
                              ).toString()),
                              firstDate: DateTime(1900),
                              lastDate: functions.stringToDate(getJsonField(
                                columnGetMyProfileResponse.jsonBody,
                                r'''$.dateOfBirth''',
                              ).toString()),
                            );

                            if (_datePickedDate != null) {
                              setState(() {
                                _model.datePicked = DateTime(
                                  _datePickedDate.year,
                                  _datePickedDate.month,
                                  _datePickedDate.day,
                                );
                              });
                            } else {
                              setState(() {
                                _model.datePicked = functions.stringToDate(getJsonField(
                                  columnGetMyProfileResponse.jsonBody,
                                  r'''$.dateOfBirth''',
                                ).toString());
                              });
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Container(
                              width: 100.0,
                              height: 58.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(40.0),
                                border: Border.all(
                                  color: Color(0xFFF1F4F8),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 0.0, 16.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    functions.formatDateFor(getJsonField(
            columnGetMyProfileResponse.jsonBody,
            r'''$.dateOfBirth''',
            ).toString()),
                                    '01/01/2023',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController ??=
                              FormFieldController<String>(
                                _model.dropDownValue ??= getJsonField(
                                  columnGetMyProfileResponse.jsonBody,
                                  r'''$.gender''',
                                ).toString(),
                              ),
                          options: ['MALE', 'FEMALE', 'OTHER'],
                          onChanged: (val) =>
                              setState(() => _model.dropDownValue = val),
                          width: 400.0,
                          height: 58.0,
                          searchHintTextStyle:
                          FlutterFlowTheme.of(context).labelMedium,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Please select your gender...',
                          searchHintText: 'Search for an item...',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          elevation: 2.0,
                          borderColor: Color(0xFFF1F4F8),
                          borderWidth: 2.0,
                          borderRadius: 40.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          hidesUnderline: true,
                          isSearchable: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        String newDate;
                        if (_model.datePicked == null) {
                          newDate = (getJsonField(
                            columnGetMyProfileResponse.jsonBody,
                            r'''$.dateOfBirth''',
                          ).toString());
                        } else {
                          newDate = functions.transformDate(_model.datePicked!);
                        }
                        print(_model.nameController1.text);
                        print(_model.nameController2.text);
                        print(_model.datePicked);
                        print(newDate);
                        _model.apiResultraw = await ProfileControllerGroup
                            .updateMyProfileCall
                            .call(
                          token: widget.token,
                          dateOfBirth: newDate,
                          firstname: _model.nameController1.text,
                          lastname: _model.nameController2.text,
                          gender: _model.dropDownValue,
                        );
                        print(_model.apiResultraw?.statusCode);
                        if (!(_model.apiResultraw?.succeeded ?? true)) {

                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Update profile failed'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        setState(() {});
                      },
                      text: 'Save Changes',
                      options: FFButtonOptions(
                        width: 270.0,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFFDD1E5F),
                        textStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed('LoginPage');
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.remove('accessToken');
                      },
                      text: 'Sign out',
                      options: FFButtonOptions(
                        width: 150.0,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: Colors.grey,
                        textStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      )
    ));
  }
}
