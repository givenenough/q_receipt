import '/backend/api_requests/api_calls.dart';
import '/components/app_bar_widget.dart';
import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'analytics_page_model.dart';
export 'analytics_page_model.dart';

class AnalyticsPageWidget extends StatefulWidget {
  const AnalyticsPageWidget({
    Key? key,
    this.token,
  }) : super(key: key);

  final String? token;

  @override
  _AnalyticsPageWidgetState createState() => _AnalyticsPageWidgetState();
}

class _AnalyticsPageWidgetState extends State<AnalyticsPageWidget> {
  late AnalyticsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyticsPageModel());
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
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FutureBuilder<ApiCallResponse>(
                                    future: AnalyticsControllerGroup
                                        .getMyTotalSpendingsForLastMonthsCall
                                        .call(
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
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        );
                                      }
                                      final columnGetMyTotalSpendingsForLastMonthsResponse =
                                      snapshot.data!;
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 20.0),
                                            child: Container(
                                              width:
                                              MediaQuery.of(context).size.width *
                                                  1.0,
                                              height: 200.0,
                                              child: custom_widgets.SimpleBarChart(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    1.0,
                                                height: 200.0,
                                                currentMonth: functions.getLastMonthName(
                                                    columnGetMyTotalSpendingsForLastMonthsResponse
                                                        .bodyText),
                                                jsonData:
                                                columnGetMyTotalSpendingsForLastMonthsResponse
                                                    .bodyText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 20.0),
                                            child: Container(
                                              width:
                                              MediaQuery.of(context).size.width *
                                                  1.0,
                                              height: 200.0,
                                              child: custom_widgets.SpendingsList(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    1.0,
                                                height: 200.0,
                                                jsonData:
                                                columnGetMyTotalSpendingsForLastMonthsResponse
                                                    .bodyText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: AnalyticsControllerGroup
                                        .getMySpendingsPerCategoryCall
                                        .call(
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
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        );
                                      }
                                      final columnGetMySpendingsPerCategoryResponse =
                                      snapshot.data!;
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spendings in current month divided by categories',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 20.0),
                                            child: Container(
                                              width:
                                              MediaQuery.of(context).size.width *
                                                  1.0,
                                              height: 350.0,
                                              child: custom_widgets.SpendingsPieChart(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    1.0,
                                                height: 350.0,
                                                jsonData:
                                                columnGetMySpendingsPerCategoryResponse
                                                    .bodyText,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width *
                                                1.0,
                                            height: 250.0,
                                            child: custom_widgets.SpendingsGridView(
                                              width:
                                              MediaQuery.of(context).size.width *
                                                  1.0,
                                              height: 250.0,
                                              jsonData:
                                              columnGetMySpendingsPerCategoryResponse
                                                  .bodyText,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
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
                      pageTitle: 'Analytics',
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
