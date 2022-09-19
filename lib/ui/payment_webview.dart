
import 'package:flutter/material.dart';
import 'package:nike/ui/receipt/payment_receiptscreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatelessWidget {
  const PaymentGatewayScreen({super.key, required this.bankGatewayUrl});
final String bankGatewayUrl;
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: bankGatewayUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: ((url) {
        debugPrint('url: $url');
        final uri=Uri.parse(url);
        final orderId = int.parse(uri.queryParameters['order_id']!);
        if (uri.pathSegments.contains('checkout') && uri.host=='expertdevelopers.ir') {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentReceiptScreen(orderId: orderId),
              ));
        }
      }),
    );
  }
}