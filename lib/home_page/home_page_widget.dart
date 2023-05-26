import 'package:shared_preferences/shared_preferences.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/app_bar_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/components/nav_bar_widget.dart';
import '/components/transaction_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
    this.accessToken,
  }) : super(key: key);

  final String? accessToken;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  String? accessToken;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    initializeAccessToken();
    print("Access token: $accessToken");  // Debug print
  }

  Future<void> initializeAccessToken() async {
    if (widget.accessToken == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString('accessToken');
    } else {
      accessToken = widget.accessToken;
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    wrapWithModel(
                      model: _model.appBarModel,
                      updateCallback: () => setState(() {}),
                      child: AppBarWidget(
                        pageTitle: 'Home',
                        token: widget.accessToken ?? accessToken,
                      ),
                    ),
                    Flexible(
                      child: FutureBuilder<ApiCallResponse>(
                        future: AnalyticsControllerGroup
                            .getMyTotalSpendingsForLastMonthsCall
                            .call(
                          token: widget.accessToken,
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
                          final columnGetMyTotalSpendingsForLastMonthsResponse =
                          snapshot.data!;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 170.0,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                1.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF2F2F2F),
                                              borderRadius:
                                              BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      20.0, 20.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        'Total Expenses',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: Color(
                                                              0xFF63636E),
                                                          fontWeight:
                                                          FontWeight
                                                              .normal,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0,
                                                            10.0,
                                                            0.0,
                                                            0.0),
                                                        child: Text(
                                                          'KZT ${functions.calculateTotalSpendings(columnGetMyTotalSpendingsForLastMonthsResponse.bodyText).toString()}',
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Poppins',
                                                            color: Colors
                                                                .white,
                                                            fontSize: 26.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0.0, -0.7),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        20.0, 0.0),
                                                    child: Icon(
                                                      Icons.settings_ethernet,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Analytics',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
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
                                                    widget.accessToken,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                  ),
                                                },
                                              );
                                            },
                                            child: Text(
                                              'View all',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                Color(0xFFC3C2CC),
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              1.0,
                                          height: 200.0,
                                          child: custom_widgets.SimpleBarChart(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                1.0,
                                            height: 200.0,
                                            currentMonth:
                                            functions.getLastMonthName(
                                                columnGetMyTotalSpendingsForLastMonthsResponse
                                                    .bodyText),
                                            jsonData:
                                            columnGetMyTotalSpendingsForLastMonthsResponse
                                                .bodyText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Transactions',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
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
                                                    widget.accessToken,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                  ),
                                                },
                                              );
                                            },
                                            child: Text(
                                              'View all',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                Color(0xFFC3C2CC),
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              FutureBuilder<ApiCallResponse>(
                                                future: ReceiptControllerGroup
                                                    .getPageableCall
                                                    .call(
                                                  direction: 'DESC',
                                                  pageNumber: 0,
                                                  pageSize: 2,
                                                  sortBy: 'createdDate',
                                                  token: widget.accessToken,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                        CircularProgressIndicator(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final listViewGetPageableResponse =
                                                  snapshot.data!;
                                                  return Builder(
                                                    builder: (context) {
                                                      final transaction =
                                                      getJsonField(
                                                        listViewGetPageableResponse
                                                            .jsonBody,
                                                        r'''$.data''',
                                                      )
                                                          .toList()
                                                          .take(2)
                                                          .toList();
                                                      if (transaction.isEmpty) {
                                                        return EmptyListComponentWidget();
                                                      }
                                                      return ListView.builder(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                        Axis.vertical,
                                                        itemCount:
                                                        transaction.length,
                                                        itemBuilder: (context,
                                                            transactionIndex) {
                                                          final transactionItem =
                                                          transaction[
                                                          transactionIndex];
                                                          return Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                10.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                              Colors
                                                                  .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'TransactionPage',
                                                                  queryParams: {
                                                                    'token':
                                                                    serializeParam(
                                                                      widget
                                                                          .accessToken,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'uuid':
                                                                    serializeParam(
                                                                      getJsonField(
                                                                        transactionItem,
                                                                        r'''$.id''',
                                                                      ).toString(),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child:
                                                              TransactionWidget(
                                                                key: Key(
                                                                    'Keyu1c_${transactionIndex}_of_${transaction.length}'),
                                                                storeName:
                                                                getJsonField(
                                                                  transactionItem,
                                                                  r'''$.organization.name''',
                                                                ).toString(),
                                                                category:
                                                                getJsonField(
                                                                  transactionItem,
                                                                  r'''$.organization.category''',
                                                                ).toString(),
                                                                paymentAmount:
                                                                getJsonField(
                                                                  transactionItem,
                                                                  r'''$.total''',
                                                                ).toString(),
                                                                date:
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.formatDate(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          transactionItem,
                                                                          r'''$.createdDate''',
                                                                        ).toString(),
                                                                        '2023-05-15T15:55:22.259513Z',
                                                                      )),
                                                                  '2023-05-15T15:55:22.259513Z',
                                                                ),
                                                                photoUrl:
                                                                valueOrDefault<
                                                                    String>(
                                                                  'http://45.148.31.152:8080/public/file/preview/${getJsonField(
                                                                    transactionItem,
                                                                    r'''$.organization.picture''',
                                                                  ).toString()}',
                                                                  'http://45.148.31.152:8080/public/file/preview/80cfc176-9879-4908-b937-543cc8391dd6',
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.navBarModel,
                updateCallback: () => setState(() {}),
                child: NavBarWidget(
                  token: widget.accessToken ?? accessToken,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
