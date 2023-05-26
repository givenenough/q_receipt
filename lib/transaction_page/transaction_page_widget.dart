import '/backend/api_requests/api_calls.dart';
import '/components/app_bar_widget.dart';
import '/components/nav_bar_widget.dart';
import '/components/transaction_info_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'transaction_page_model.dart';
export 'transaction_page_model.dart';

class TransactionPageWidget extends StatefulWidget {
  const TransactionPageWidget({
    Key? key,
    required this.token,
    required this.uuid,
  }) : super(key: key);

  final String? token;
  final String? uuid;

  @override
  _TransactionPageWidgetState createState() => _TransactionPageWidgetState();
}

class _TransactionPageWidgetState extends State<TransactionPageWidget> {
  late TransactionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  Future<void>? downloadTaskId;

  Future<String> downloadFile(String url, String filename) async {
    String localPath = "/storage/emulated/0/Download/";
    print(localPath);

    var cnt = 1;
    var originalExtension = p.extension(filename);
    var baseName = p.basenameWithoutExtension(filename);

    var isExist = await File("/storage/emulated/0/Download/$filename").exists();

    while(isExist) {
      var newFileName = '${baseName}_$cnt$originalExtension';
      filename = newFileName;
      isExist = await File("/storage/emulated/0/Download/$newFileName").exists();
      cnt++;
    }

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {
        ...ReceiptControllerGroup.headers,
        'Authorization': 'bearer ${widget.token}',
      },
      savedDir: localPath,
      fileName: filename,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );

    if (taskId == null) {
      throw Exception('Download task could not be created');
    }

    return taskId;
  }


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionPageModel());
    createDirectory();
  }

  void createDirectory() async {
    final Directory dir = Directory('/data/user/0/com.qchimera.qreceipt/app_flutter');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Positioned(
                top: 100.0, // Adjust according to your AppBar height
                left: 0,
                right: 0,
                bottom: 70.0, // Adjust according to your NavBar height
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: FutureBuilder<ApiCallResponse>(
                            future:
                            ReceiptControllerGroup.receiptPreviewCall.call(
                              uuid: widget.uuid,
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
                              final columnReceiptPreviewResponse = snapshot.data!;
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: Text(
                                        getJsonField(
                                          columnReceiptPreviewResponse.jsonBody,
                                          r'''$.organization.name''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Name',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Price',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Q-ty',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Total price',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final transactionInfoRow = getJsonField(
                                          columnReceiptPreviewResponse.jsonBody,
                                          r'''$.products''',
                                        ).toList();
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: transactionInfoRow.length,
                                          itemBuilder:
                                              (context, transactionInfoRowIndex) {
                                            final transactionInfoRowItem =
                                            transactionInfoRow[
                                            transactionInfoRowIndex];
                                            return TransactionInfoWidget(
                                              key: Key(
                                                  'Keymjw_${transactionInfoRowIndex}_of_${transactionInfoRow.length}'),
                                              product: getJsonField(
                                                transactionInfoRowItem,
                                                r'''$.name''',
                                              ).toString(),
                                              price: getJsonField(
                                                transactionInfoRowItem,
                                                r'''$.price''',
                                              ),
                                              quantity: getJsonField(
                                                transactionInfoRowItem,
                                                r'''$.quantity''',
                                              ),
                                              total: getJsonField(
                                                transactionInfoRowItem,
                                                r'''$.totalPrice''',
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              valueOrDefault<String>(
                                                functions.formatDate(
                                                    valueOrDefault<String>(
                                                      getJsonField(
                                                        columnReceiptPreviewResponse
                                                            .jsonBody,
                                                        r'''$.createdDate''',
                                                      ).toString(),
                                                      '2023-05-15T15:55:22.259513Z',
                                                    )),
                                                '2023-05-15T15:55:22.259513Z',
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Total: ${getJsonField(
                                                columnReceiptPreviewResponse
                                                    .jsonBody,
                                                r'''$.total''',
                                              ).toString()} KZT',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () {
                                        setState(() {
                                          downloadTaskId = downloadFile(
                                            '${ReceiptControllerGroup.baseUrl}/printAndDownloadReceipt/${widget.uuid}',
                                            'receipt-${widget.uuid}.pdf',
                                          );
                                        });
                                      },
                                      text: 'Show Receipt',
                                      options: FFButtonOptions(
                                        width: 130.0,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        color: Color(0xFFDD1E5F),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                        elevation: 2.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: FlutterFlowTheme.of(context).primaryBackground, // To keep the AppBar background same as the body
                  child: wrapWithModel(
                    model: _model.appBarModel,
                    updateCallback: () => setState(() {}),
                    child: AppBarWidget(
                      pageTitle: 'Transaction Page',
                      token: widget.token!,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: wrapWithModel(
                  model: _model.navBarModel,
                  updateCallback: () => setState(() {}),
                  child: NavBarWidget(
                    token: widget.token!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
