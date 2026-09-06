import 'package:flutter/cupertino.dart';
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
    expect(find.byKey(const ValueKey('liquid-motion-layer')), findsOneWidget);
  });

  testWidgets('uses the green palette and 0.20 glass by default', (
    tester,
  ) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    final activeIcon = tester.widget<Icon>(
      find.descendant(
        of: find.byKey(const ValueKey('glass-tab-0')),
        matching: find.byIcon(CupertinoIcons.house_fill),
      ),
    );
    final surface = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('liquid-glass-surface')),
    );
    final gradient = (surface.decoration as BoxDecoration).gradient!;

    expect(activeIcon.color, const Color(0xFF087D2A));
    expect(gradient.colors[1].a, closeTo(0.20, 0.001));
  });

  testWidgets('keeps the original blue palette available', (tester) async {
    await tester.pumpWidget(
      const LiquidGlassDemoApp(variant: LiquidGlassVariant.blue),
    );
    await tester.pump();

    final activeIcon = tester.widget<Icon>(
      find.descendant(
        of: find.byKey(const ValueKey('glass-tab-0')),
        matching: find.byIcon(CupertinoIcons.house_fill),
      ),
    );
    final surface = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('liquid-glass-surface')),
    );
    final gradient = (surface.decoration as BoxDecoration).gradient!;

    expect(activeIcon.color, const Color(0xFF087BEB));
    expect(gradient.colors[1].a, closeTo(0.29, 0.001));
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

  testWidgets('liquid button depresses under an off-center touch', (
    tester,
  ) async {
    await tester.pumpWidget(const LiquidGlassDemoApp());
    await tester.pump();

    final button = find.byKey(const ValueKey('liquid-primary-action'));
    final rect = tester.getRect(button);
    final gesture = await tester.startGesture(
      rect.topLeft + const Offset(18, 22),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 140));

    final scale = tester.widget<ScaleTransition>(
      find.descendant(of: button, matching: find.byType(ScaleTransition)),
    );
    expect(scale.scale.value, lessThan(1));

    await gesture.cancel();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(scale.scale.value, closeTo(1, 0.001));
    expect(tester.takeException(), isNull);
  });
}
