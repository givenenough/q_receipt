import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'transaction_info_model.dart';
export 'transaction_info_model.dart';

class TransactionInfoWidget extends StatefulWidget {
  const TransactionInfoWidget({
    Key? key,
    required this.product,
    required this.price,
    required this.quantity,
    required this.total,
  }) : super(key: key);

  final String? product;
  final double? price;
  final int? quantity;
  final double? total;

  @override
  _TransactionInfoWidgetState createState() => _TransactionInfoWidgetState();
}

class _TransactionInfoWidgetState extends State<TransactionInfoWidget> {
  late TransactionInfoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionInfoModel());
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.product!,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${widget.price.toString()} KZT',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.quantity.toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${widget.total.toString()} KZT',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
