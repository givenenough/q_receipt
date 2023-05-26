import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String? token;

  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'HomePage',
                  queryParams: {
                    'accessToken': serializeParam(
                      widget.token,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: Icon(
                Icons.home_rounded,
                color: Color(0xFFC2C2C7),
                size: 24.0,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'ReceiptsPage',
                  queryParams: {
                    'token': serializeParam(
                      widget.token,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: Icon(
                Icons.credit_card,
                color: Color(0xFFC2C2C7),
                size: 24.0,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.receiptUuid = await FlutterBarcodeScanner.scanBarcode(
                  '#C62828', // scanning line color
                  'Cancel', // cancel button text
                  true, // whether to show the flash icon
                  ScanMode.QR,
                );

                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Scan successful'),
                      content: Text(_model.receiptUuid!),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
                _model.apiResultt5u =
                    await ReceiptControllerGroup.claimCall.call(
                  uuid: _model.receiptUuid,
                  token: widget.token,
                );
                if ((_model.apiResultt5u?.succeeded ?? true)) {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text('Receipt successfully claimed'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                }

                setState(() {});
              },
              child: Icon(
                Icons.add_circle,
                color: Color(0xFFDD1E5F),
                size: 60.0,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'AnalyticsPage',
                  queryParams: {
                    'token': serializeParam(
                      widget.token,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: Icon(
                Icons.analytics_outlined,
                color: Color(0xFFC2C2C7),
                size: 24.0,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'CreateProfile',
                  queryParams: {
                    'token': serializeParam(
                      widget.token,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: Icon(
                Icons.settings_outlined,
                color: Color(0xFFC2C2C7),
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
