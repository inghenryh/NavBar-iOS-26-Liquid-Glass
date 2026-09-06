import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navbar_ios_26_liquid_glass/main.dart';

void main() {
  testWidgets('shows the floating Liquid Glass menu', (tester) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    expect(find.byKey(const ValueKey('liquid-glass-tab-bar')), findsOneWidget);
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Videos'), findsOneWidget);
    expect(find.text('Mensajes'), findsOneWidget);
    expect(find.text('Código'), findsOneWidget);
    expect(find.text('Descubre'), findsOneWidget);
    expect(find.byKey(const ValueKey('liquid-primary-action')), findsOneWidget);
  });

  testWidgets('changes pages when a tab is selected', (tester) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('glass-tab-1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.byKey(const ValueKey('page-title-1')), findsOneWidget);
  });

  testWidgets('changes pages when the floating menu is dragged', (
    tester,
  ) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    final menu = tester.getRect(
      find.byKey(const ValueKey('liquid-glass-tab-bar')),
    );
    await tester.dragFrom(
      Offset(menu.left + 35, menu.center.dy),
      Offset(menu.width - 80, 0),
      touchSlopX: 2,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byKey(const ValueKey('page-title-3')), findsOneWidget);
  });

  testWidgets('opens the elevated primary action', (tester) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('liquid-primary-action')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Crear algo nuevo'), findsOneWidget);
    expect(find.text('Nueva idea'), findsOneWidget);
  });
}
