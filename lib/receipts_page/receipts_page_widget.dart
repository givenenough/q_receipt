import '/backend/api_requests/api_calls.dart';
import '/components/app_bar_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/components/nav_bar_widget.dart';
import '/components/transaction_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'receipts_page_model.dart';
export 'receipts_page_model.dart';

class ReceiptsPageWidget extends StatefulWidget {
  const ReceiptsPageWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String? token;

  @override
  _ReceiptsPageWidgetState createState() => _ReceiptsPageWidgetState();
}

class _ReceiptsPageWidgetState extends State<ReceiptsPageWidget> {
  late ReceiptsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceiptsPageModel());
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
            children: [
              wrapWithModel(
                model: _model.appBarModel,
                updateCallback: () => setState(() {}),
                child: AppBarWidget(
                  pageTitle: 'Receipts',
                  token: widget.token!,
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() => _model.pagingController?.refresh());
                          await _model.waitForOnePage();
                        },
                        child: PagedListView<ApiPagingParams, dynamic>(
                          pagingController: () {
                            if (_model.pagingController != null) {
                              return _model.pagingController!;
                            }

                            _model.pagingController = PagingController(
                              firstPageKey: ApiPagingParams(
                                nextPageNumber: 0,
                                numItems: 0,
                                lastResponse: null,
                              ),
                            );
                            _model.pagingController!
                                .addPageRequestListener(
                                    (nextPageMarker) {
                                  ReceiptControllerGroup.getPageableCall
                                      .call(
                                    direction: 'DESC',
                                    pageNumber:
                                    nextPageMarker.nextPageNumber,
                                    pageSize: 10,
                                    sortBy: 'createdDate',
                                    token: widget.token,
                                  )
                                      .then((listViewGetPageableResponse) {
                                    final pageItems = (getJsonField(
                                      listViewGetPageableResponse
                                          .jsonBody,
                                      r'''$.data''',
                                    ) ??
                                        [])
                                        .toList() as List;
                                    final newNumItems =
                                        nextPageMarker.numItems +
                                            pageItems.length;
                                    _model.pagingController!.appendPage(
                                      pageItems,
                                      (pageItems.length > 0)
                                          ? ApiPagingParams(
                                        nextPageNumber: nextPageMarker
                                            .nextPageNumber +
                                            1,
                                        numItems: newNumItems,
                                        lastResponse:
                                        listViewGetPageableResponse,
                                      )
                                          : null,
                                    );
                                  });
                                });
                            return _model.pagingController!;
                          }(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          reverse: false,
                          scrollDirection: Axis.vertical,
                          builderDelegate:
                          PagedChildBuilderDelegate<dynamic>(
                            // Customize what your widget looks like when it's loading the first page.
                            firstPageProgressIndicatorBuilder: (_) =>
                                Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                    ),
                                  ),
                                ),
                            noItemsFoundIndicatorBuilder: (_) =>
                                EmptyListComponentWidget(),
                            itemBuilder:
                                (context, _, transactionIndex) {
                              final transactionItem = _model
                                  .pagingController!
                                  .itemList![transactionIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'TransactionPage',
                                      queryParams: {
                                        'token': serializeParam(
                                          widget.token,
                                          ParamType.String,
                                        ),
                                        'uuid': serializeParam(
                                          getJsonField(
                                            transactionItem,
                                            r'''$.id''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: TransactionWidget(
                                    key: Key(
                                        'Keyqyt_${transactionIndex}_of_${_model.pagingController!.itemList!.length}'),
                                    storeName: getJsonField(
                                      transactionItem,
                                      r'''$.organization.name''',
                                    ).toString(),
                                    category: getJsonField(
                                      transactionItem,
                                      r'''$.organization.category''',
                                    ).toString(),
                                    paymentAmount: getJsonField(
                                      transactionItem,
                                      r'''$.total''',
                                    ).toString(),
                                    date: functions
                                        .formatDate(getJsonField(
                                      transactionItem,
                                      r'''$.createdDate''',
                                    ).toString()),
                                    photoUrl:
                                    'http://45.148.31.152:8080/public/file/preview/${getJsonField(
                                      transactionItem,
                                      r'''$.organization.picture''',
                                    ).toString()}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.navBarModel,
                updateCallback: () => setState(() {}),
                child: NavBarWidget(
                  token: widget.token!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


