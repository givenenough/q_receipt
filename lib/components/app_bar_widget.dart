import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_bar_model.dart';
export 'app_bar_model.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    String? pageTitle,
    required this.token,
  })  : this.pageTitle = pageTitle ?? 'Default',
        super(key: key);

  final String pageTitle;
  final String? token;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late AppBarModel _model;

  Future<String> fetchProfilePicture() async {

    String? pictureUrl = getJsonField(
      (_model.apiResultProfile?.jsonBody ?? ''),
      r'''$.picture''',
    );

    return pictureUrl != null
        ? 'http://45.148.31.152:8080/public/file/preview/${pictureUrl}'
        : 'http://45.148.31.152:8080/public/file/preview/5498c0f9-d7fb-4aab-a88c-2cf151dc41c4';
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultProfile =
      await ProfileControllerGroup.getMyProfileCall.call(
        token: widget.token,
      );
      if (!(_model.apiResultProfile?.succeeded ?? true)) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Fail'),
              content: Text('Failed to load appbar profile'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Um..ok..'),
                ),
              ],
            );
          },
        );
      }
    });

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
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<ApiCallResponse>(
              future: ProfileControllerGroup.getMyProfileCall.call(
              token: widget.token,
          ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  );
                }
                final columnGetMyProfileResponse = snapshot.data!;
                return custom_widgets.NetworkImageFromBytes(
                  width: 40.0,
                  height: 40.0,
                  url: getJsonField(
                    columnGetMyProfileResponse.jsonBody,
                    r'''$.picture''',
                  ) != null
                      ? 'http://45.148.31.152:8080/public/file/preview/${getJsonField(
                    columnGetMyProfileResponse.jsonBody,
                    r'''$.picture''',
                  ).toString()}'
                      : 'http://45.148.31.152:8080/public/file/preview/80cfc176-9879-4908-b937-543cc8391dd6',
                  borderRadius: 10.0,
                );

              },
            ),
            Text(
              widget.pageTitle,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
