import 'package:flutter_test/flutter_test.dart';

import 'package:api_app/main.dart';

void main() {
  testWidgets('App renders product list page', (WidgetTester tester) async {
    await tester.pumpWidget(const KatalogProdukApp());
    await tester.pump();

    expect(find.text('Katalog Produk'), findsOneWidget);
    expect(find.text('Cari produk...'), findsOneWidget);
  });
}
