import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const LiquidGlassDemoApp());
}

class LiquidGlassDemoApp extends StatelessWidget {
  const LiquidGlassDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF007AFF),
        scaffoldBackgroundColor: Color(0xFFF2F6FA),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: Color(0xFF101318),
            fontFamily: '.SF Pro Text',
          ),
        ),
      ),
      home: LiquidGlassDemoPage(),
    );
  }
}

class LiquidGlassDemoPage extends StatefulWidget {
  const LiquidGlassDemoPage({super.key});

  @override
  State<LiquidGlassDemoPage> createState() => _LiquidGlassDemoPageState();
}

class _LiquidGlassDemoPageState extends State<LiquidGlassDemoPage> {
  late final PageController _pageController;
  int _selectedIndex = 0;

  static const _tabs = <_TabSpec>[
    _TabSpec('Inicio', CupertinoIcons.house_fill),
    _TabSpec('Videos', CupertinoIcons.play_rectangle_fill),
    _TabSpec('Mensajes', CupertinoIcons.bubble_left_bubble_right_fill),
    _TabSpec('Código', CupertinoIcons.chevron_left_slash_chevron_right),
  ];

  static const _pages = <_PageSpec>[
    _PageSpec(
      eyebrow: 'DOMINGO, 6 DE SEPTIEMBRE',
      title: 'Descubre',
      subtitle: 'Una interfaz luminosa que deja respirar al contenido.',
      featureTitle: 'Horizonte sereno',
      featureSubtitle: 'El color fluye detrás del cristal',
      colors: [Color(0xFF7AD7F0), Color(0xFF8178E8), Color(0xFFF6B7D4)],
      cardColors: [Color(0xFF55C8EB), Color(0xFF5B7FE5)],
      symbol: CupertinoIcons.sparkles,
    ),
    _PageSpec(
      eyebrow: 'PARA VER AHORA',
      title: 'Videos',
      subtitle: 'Historias seleccionadas para una tarde tranquila.',
      featureTitle: 'Luz en movimiento',
      featureSubtitle: 'Una colección de paisajes inmersivos',
      colors: [Color(0xFF8FE4D2), Color(0xFF6695E8), Color(0xFFC5A4EC)],
      cardColors: [Color(0xFF57CDB6), Color(0xFF4A73D5)],
      symbol: CupertinoIcons.play_fill,
    ),
    _PageSpec(
      eyebrow: 'CONVERSACIONES',
      title: 'Mensajes',
      subtitle: 'Tus personas favoritas, siempre cerca.',
      featureTitle: 'Todo al día',
      featureSubtitle: 'Responde cuando tengas un momento',
      colors: [Color(0xFFA7EBC8), Color(0xFF70C9D9), Color(0xFFB5B5F1)],
      cardColors: [Color(0xFF63D6A0), Color(0xFF469CCB)],
      symbol: CupertinoIcons.chat_bubble_2_fill,
    ),
    _PageSpec(
      eyebrow: 'ESPACIO CREATIVO',
      title: 'Código',
      subtitle: 'Ideas rápidas convertidas en experiencias fluidas.',
      featureTitle: 'Construye algo nuevo',
      featureSubtitle: 'Diseño y tecnología en una misma capa',
      colors: [Color(0xFFA8D6FF), Color(0xFF8C8FE9), Color(0xFFE0B2EA)],
      cardColors: [Color(0xFF539DDE), Color(0xFF7659C7)],
      symbol: CupertinoIcons.chevron_left_slash_chevron_right,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    if (MediaQuery.disableAnimationsOf(context)) {
      _pageController.jumpToPage(index);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 330),
        curve: Curves.easeOutCubic,
      );
    }
    HapticFeedback.selectionClick();
  }

  void _showPrimaryAction() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Crear algo nuevo'),
        message: const Text('Elige una acción rápida para continuar.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Nueva idea'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Nuevo mensaje'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Nuevo proyecto'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              key: const ValueKey('liquid-pages'),
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: _pages.length,
              onPageChanged: (index) {
                if (_selectedIndex != index) {
                  setState(() => _selectedIndex = index);
                  HapticFeedback.selectionClick();
                }
              },
              itemBuilder: (context, index) =>
                  _DiscoveryPage(spec: _pages[index], index: index),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: math.max(10, bottomInset + 8),
              child: RepaintBoundary(
                child: _LiquidGlassTabBar(
                  key: const ValueKey('liquid-glass-tab-bar'),
                  tabs: _tabs,
                  currentIndex: _selectedIndex,
                  reduceMotion: reduceMotion,
                  highContrast: MediaQuery.highContrastOf(context),
                  onChanged: _selectTab,
                  onPrimaryPressed: _showPrimaryAction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoveryPage extends StatelessWidget {
  const _DiscoveryPage({required this.spec, required this.index});

  final _PageSpec spec;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(spec.colors[0], Colors.white, 0.70)!,
            Color.lerp(spec.colors[1], Colors.white, 0.77)!,
            Color.lerp(spec.colors[2], Colors.white, 0.66)!,
          ],
          stops: const [0, 0.52, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _AmbientBackdropPainter(
                colors: spec.colors,
                seed: index,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              key: PageStorageKey('page-$index'),
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 150),
                  sliver: SliverList.list(
                    children: [
                      Text(
                        spec.eyebrow,
                        style: const TextStyle(
                          color: Color(0xA6464C57),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.15,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        spec.title,
                        key: ValueKey('page-title-$index'),
                        style: const TextStyle(
                          color: Color(0xFF101318),
                          fontSize: 40,
                          height: 0.98,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.7,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        spec.subtitle,
                        style: const TextStyle(
                          color: Color(0xB33B424D),
                          fontSize: 17,
                          height: 1.32,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.25,
                        ),
                      ),
                      const SizedBox(height: 26),
                      _FeatureCard(spec: spec),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _SmallCard(
                              title: index.isEven ? 'En calma' : 'Favoritos',
                              subtitle: index.isEven
                                  ? '12 momentos'
                                  : 'Guardados',
                              icon: CupertinoIcons.heart_fill,
                              color: spec.colors[2],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _SmallCard(
                              title: index.isEven ? 'Más cerca' : 'Recientes',
                              subtitle: index.isEven
                                  ? 'Explorar'
                                  : 'Esta semana',
                              icon: CupertinoIcons.location_fill,
                              color: spec.colors[0],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _WideColorCard(spec: spec),
                    ],
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

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.spec});

  final _PageSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 238,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: spec.cardColors,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F315B),
            blurRadius: 34,
            offset: Offset(0, 18),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _FeatureLandscapePainter(colors: spec.colors),
            ),
          ),
          Positioned(
            top: 18,
            right: 18,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0x29FFFFFF),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x59FFFFFF)),
              ),
              child: Icon(spec.symbol, size: 20, color: Colors.white),
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: 21,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.featureTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.7,
                    shadows: [Shadow(color: Color(0x40000000), blurRadius: 12)],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  spec.featureSubtitle,
                  style: const TextStyle(
                    color: Color(0xEFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Color(0x33000000), blurRadius: 8)],
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

class _SmallCard extends StatelessWidget {
  const _SmallCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xBFF7FAFC),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xAFFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120E3156),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: -6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 19,
              color: Color.lerp(color, Colors.black, 0.18),
            ),
          ),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1B2028),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0x8F343A44),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _WideColorCard extends StatelessWidget {
  const _WideColorCard({required this.spec});

  final _PageSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.fromLTRB(20, 20, 18, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            spec.colors[2].withValues(alpha: 0.88),
            spec.colors[0].withValues(alpha: 0.86),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F244C74),
            blurRadius: 26,
            offset: Offset(0, 14),
            spreadRadius: -9,
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hecho para sentirse vivo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.08,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                Spacer(),
                Text(
                  'DESLIZA PARA EXPLORAR',
                  style: TextStyle(
                    color: Color(0xDFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0x38FFFFFF),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x75FFFFFF)),
            ),
            child: const Icon(
              CupertinoIcons.arrow_up_right,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiquidGlassTabBar extends StatefulWidget {
  const _LiquidGlassTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onChanged,
    required this.onPrimaryPressed,
    required this.reduceMotion,
    required this.highContrast,
  });

  final List<_TabSpec> tabs;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final VoidCallback onPrimaryPressed;
  final bool reduceMotion;
  final bool highContrast;

  @override
  State<_LiquidGlassTabBar> createState() => _LiquidGlassTabBarState();
}

class _LiquidGlassTabBarState extends State<_LiquidGlassTabBar>
    with TickerProviderStateMixin {
  late final AnimationController _selectionController;
  double _fromSlot = 0;
  double _toSlot = 0;
  int? _pressedIndex;
  int? _dragTargetIndex;
  double _touchX = 0.5;
  double? _pointerDownX;
  bool _touching = false;

  double _slotForTab(int index) =>
      index < 2 ? index.toDouble() : (index + 1).toDouble();

  int? _tabForSlot(int slot) {
    if (slot == 2) return null;
    return slot < 2 ? slot : slot - 1;
  }

  @override
  void initState() {
    super.initState();
    _fromSlot = _slotForTab(widget.currentIndex);
    _toSlot = _slotForTab(widget.currentIndex);
    _selectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1,
    );
  }

  @override
  void didUpdateWidget(covariant _LiquidGlassTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _fromSlot = _displayedSlot;
      _toSlot = _slotForTab(widget.currentIndex);
      if (widget.reduceMotion) {
        _fromSlot = _toSlot;
        _selectionController.value = 1;
      } else {
        _selectionController.forward(from: 0);
      }
    }
  }

  double get _displayedSlot {
    final t = Curves.easeOutCubic.transform(_selectionController.value);
    return lerpDouble(_fromSlot, _toSlot, t) ?? _toSlot;
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  void _setPressed(int? index) {
    if (_pressedIndex != index) setState(() => _pressedIndex = index);
  }

  void _updateTouch(double localX, double width) {
    final nextTouchX = (localX / width).clamp(0.0, 1.0);
    if (!_touching || (nextTouchX - _touchX).abs() > 0.012) {
      setState(() {
        _touchX = nextTouchX;
        _touching = true;
      });
    }
  }

  void _beginPointer(double localX, double width) {
    _pointerDownX = localX;
    _dragTargetIndex = null;
    _updateTouch(localX, width);
  }

  void _movePointer({
    required double localX,
    required double width,
    required double slotWidth,
  }) {
    final startX = _pointerDownX;
    if (startX == null || (localX - startX).abs() < 12) return;
    _updateTouch(localX, width);
    final slot = ((localX - 6) / slotWidth).floor().clamp(0, 4);
    final index = _tabForSlot(slot);
    if (index == null) return;
    if (_dragTargetIndex != index) {
      setState(() => _dragTargetIndex = index);
    }
  }

  void _endPointer() {
    final targetIndex = _dragTargetIndex;
    _pointerDownX = null;
    setState(() {
      _dragTargetIndex = null;
      _touching = false;
    });
    if (targetIndex != null && targetIndex != widget.currentIndex) {
      widget.onChanged(targetIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fillOpacity = widget.highContrast ? 0.62 : 0.29;

    return SizedBox(
      height: 96,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const inset = 6.0;
          const barTop = 18.0;
          const barHeight = 78.0;
          const primarySize = 74.0;
          final slotWidth = (constraints.maxWidth - inset * 2) / 5;

          return Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) =>
                _beginPointer(event.localPosition.dx, constraints.maxWidth),
            onPointerMove: (event) => _movePointer(
              localX: event.localPosition.dx,
              width: constraints.maxWidth,
              slotWidth: slotWidth,
            ),
            onPointerUp: (_) => _endPointer(),
            onPointerCancel: (_) => _endPointer(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: barTop,
                  height: barHeight,
                  child: RepaintBoundary(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x30091B2E),
                            blurRadius: 38,
                            offset: Offset(0, 20),
                            spreadRadius: -8,
                          ),
                          BoxShadow(
                            color: Color(0x1A357AB7),
                            blurRadius: 16,
                            offset: Offset(0, 7),
                            spreadRadius: -3,
                          ),
                          BoxShadow(
                            color: Color(0x5CFFFFFF),
                            blurRadius: 9,
                            offset: Offset(-2, -3),
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(39),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(39),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withValues(
                                        alpha: fillOpacity + 0.16,
                                      ),
                                      Colors.white.withValues(
                                        alpha: fillOpacity,
                                      ),
                                      const Color(
                                        0xFFDAE8F2,
                                      ).withValues(alpha: fillOpacity - 0.12),
                                    ],
                                    stops: const [0, 0.48, 1],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withValues(
                                      alpha: widget.highContrast ? 0.95 : 0.72,
                                    ),
                                    width: widget.highContrast ? 1.4 : 1,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                right: 10,
                                top: 1,
                                height: 22,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(38),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.56),
                                        Colors.white.withValues(alpha: 0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _selectionController,
                  child: _SelectionLens(
                    highContrast: widget.highContrast,
                    reduceMotion: widget.reduceMotion,
                  ),
                  builder: (context, child) {
                    final rawT = _selectionController.value;
                    final easedT = Curves.easeOutCubic.transform(rawT);
                    final slot =
                        lerpDouble(_fromSlot, _toSlot, easedT) ?? _toSlot;
                    final stretch = widget.reduceMotion
                        ? 0.0
                        : math.sin(rawT * math.pi) *
                              math.min(12, slotWidth * 0.16);
                    return Positioned(
                      left: inset + slot * slotWidth - stretch / 2,
                      top: barTop + 6,
                      width: slotWidth + stretch,
                      height: 66,
                      child: child!,
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: barTop,
                  height: barHeight,
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: _TouchGlowPainter(
                          touchX: _touchX,
                          touching: _touching,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: inset,
                  right: inset,
                  top: barTop,
                  height: barHeight,
                  child: Row(
                    children: List.generate(5, (slot) {
                      final index = _tabForSlot(slot);
                      if (index == null) {
                        return const Expanded(child: SizedBox());
                      }
                      final tab = widget.tabs[index];
                      return Expanded(
                        child: _GlassTabButton(
                          key: ValueKey('glass-tab-$index'),
                          tab: tab,
                          selected: index == widget.currentIndex,
                          pressed: index == _pressedIndex,
                          reduceMotion: widget.reduceMotion,
                          onTapDown: () => _setPressed(index),
                          onTapEnd: () => _setPressed(null),
                          onTap: () => widget.onChanged(index),
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: (constraints.maxWidth - primarySize) / 2,
                  width: primarySize,
                  height: primarySize,
                  child: _PrimaryGlassButton(
                    key: const ValueKey('liquid-primary-action'),
                    reduceMotion: widget.reduceMotion,
                    highContrast: widget.highContrast,
                    onTap: widget.onPrimaryPressed,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SelectionLens extends StatelessWidget {
  const _SelectionLens({
    required this.highContrast,
    required this.reduceMotion,
  });

  final bool highContrast;
  final bool reduceMotion;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: highContrast ? 0.86 : 0.68),
            const Color(0xFFEAF5FF).withValues(alpha: 0.46),
            const Color(0xFFBDD9EF).withValues(alpha: 0.25),
          ],
          stops: const [0, 0.56, 1],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: highContrast ? 1 : 0.80),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A91CC).withValues(alpha: 0.17),
            blurRadius: 18,
            offset: const Offset(0, 7),
            spreadRadius: -4,
          ),
          const BoxShadow(
            color: Color(0x2BFFFFFF),
            blurRadius: 5,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.35, -0.9),
                  radius: 1.25,
                  colors: [
                    Colors.white.withValues(alpha: 0.42),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            _ActiveLensShimmer(reduceMotion: reduceMotion),
          ],
        ),
      ),
    );
  }
}

class _ActiveLensShimmer extends StatefulWidget {
  const _ActiveLensShimmer({required this.reduceMotion});

  final bool reduceMotion;

  @override
  State<_ActiveLensShimmer> createState() => _ActiveLensShimmerState();
}

class _ActiveLensShimmerState extends State<_ActiveLensShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
      value: widget.reduceMotion ? 0.46 : 0,
    );
    if (!widget.reduceMotion) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _ActiveLensShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reduceMotion == widget.reduceMotion) return;
    if (widget.reduceMotion) {
      _controller
        ..stop()
        ..value = 0.46;
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _ActiveLensShimmerPainter(progress: _controller),
        ),
      ),
    );
  }
}

class _ActiveLensShimmerPainter extends CustomPainter {
  _ActiveLensShimmerPainter({required this.progress})
    : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerX = size.width * (-0.75 + progress.value * 2.5);
    final shimmerRect = Rect.fromCenter(
      center: Offset(shimmerX, size.height / 2),
      width: math.max(18, size.width * 0.34),
      height: size.height * 2.2,
    );
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.06),
          Colors.white.withValues(alpha: 0.48),
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0),
        ],
        stops: const [0, 0.32, 0.5, 0.68, 1],
      ).createShader(shimmerRect);
    canvas.save();
    canvas.translate(shimmerX, size.height / 2);
    canvas.rotate(-0.22);
    canvas.translate(-shimmerX, -size.height / 2);
    canvas.drawRect(shimmerRect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ActiveLensShimmerPainter oldDelegate) => false;
}

class _PrimaryGlassButton extends StatefulWidget {
  const _PrimaryGlassButton({
    super.key,
    required this.reduceMotion,
    required this.highContrast,
    required this.onTap,
  });

  final bool reduceMotion;
  final bool highContrast;
  final VoidCallback onTap;

  @override
  State<_PrimaryGlassButton> createState() => _PrimaryGlassButtonState();
}

class _PrimaryGlassButtonState extends State<_PrimaryGlassButton>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _pressureController;
  late final AnimationController _impactController;
  late final Animation<double> _scaleAnimation;
  final ValueNotifier<Offset> _touchOrigin = ValueNotifier(
    const Offset(37, 27),
  );
  int? _activePointer;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4800),
      value: widget.reduceMotion ? 0.24 : 0,
    );
    _pressureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      reverseDuration: const Duration(milliseconds: 260),
    );
    _impactController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.91).animate(
      CurvedAnimation(
        parent: _pressureController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeOutBack,
      ),
    );
    if (!widget.reduceMotion) _waveController.repeat();
  }

  @override
  void didUpdateWidget(covariant _PrimaryGlassButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reduceMotion == widget.reduceMotion) return;
    if (widget.reduceMotion) {
      _waveController
        ..stop()
        ..value = 0.24;
      _impactController
        ..stop()
        ..value = 0;
      _pressureController.value = _activePointer == null ? 0 : 1;
    } else {
      _waveController.repeat();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pressureController.dispose();
    _impactController.dispose();
    _touchOrigin.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (_activePointer != null) return;
    _activePointer = event.pointer;
    _touchOrigin.value = event.localPosition;
    HapticFeedback.lightImpact();
    if (widget.reduceMotion) {
      _pressureController.value = 1;
      _impactController.value = 0.34;
    } else {
      _pressureController.forward();
      _impactController.forward(from: 0);
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_activePointer != event.pointer) return;
    final next = event.localPosition;
    if ((next - _touchOrigin.value).distanceSquared > 1) {
      _touchOrigin.value = next;
    }
  }

  void _handlePointerEnd(PointerEvent event) {
    if (_activePointer != event.pointer) return;
    _activePointer = null;
    if (widget.reduceMotion) {
      _pressureController.value = 0;
      _impactController.value = 0;
    } else {
      _pressureController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Crear',
      button: true,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: _handlePointerDown,
        onPointerMove: _handlePointerMove,
        onPointerUp: _handlePointerEnd,
        onPointerCancel: _handlePointerEnd,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Stack(
              fit: StackFit.expand,
              children: [
                RepaintBoundary(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x400A62B0),
                          blurRadius: 24,
                          offset: Offset(0, 13),
                          spreadRadius: -5,
                        ),
                        BoxShadow(
                          color: Color(0x66FFFFFF),
                          blurRadius: 8,
                          offset: Offset(-2, -3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(
                                  alpha: widget.highContrast ? 0.94 : 0.78,
                                ),
                                const Color(0xFF55B9FF).withValues(alpha: 0.68),
                                const Color(0xFF087BEB).withValues(alpha: 0.88),
                              ],
                              stops: const [0, 0.48, 1],
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(
                                alpha: widget.highContrast ? 1 : 0.88,
                              ),
                              width: widget.highContrast ? 1.6 : 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ClipOval(
                    child: IgnorePointer(
                      child: RepaintBoundary(
                        child: CustomPaint(
                          key: const ValueKey('liquid-motion-layer'),
                          painter: _PrimaryLiquidPainter(
                            wave: _waveController,
                            pressure: _pressureController,
                            impact: _impactController,
                            touchOrigin: _touchOrigin,
                            highContrast: widget.highContrast,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 13,
                  right: 17,
                  top: 7,
                  height: 23,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.72),
                            Colors.white.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const IgnorePointer(
                  child: Center(
                    child: Icon(
                      CupertinoIcons.plus,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        Shadow(color: Color(0x40004E92), blurRadius: 10),
                        Shadow(color: Color(0x66FFFFFF), blurRadius: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryLiquidPainter extends CustomPainter {
  _PrimaryLiquidPainter({
    required this.wave,
    required this.pressure,
    required this.impact,
    required this.touchOrigin,
    required this.highContrast,
  }) : super(repaint: Listenable.merge([wave, pressure, impact, touchOrigin]));

  final Animation<double> wave;
  final Animation<double> pressure;
  final Animation<double> impact;
  final ValueListenable<Offset> touchOrigin;
  final bool highContrast;

  Path _wavePath({
    required Size size,
    required double phase,
    required double baseY,
    required double amplitude,
    required double frequency,
    required double impactEnvelope,
    required Offset touchPoint,
  }) {
    final path = Path()..moveTo(-2, size.height + 2);
    for (double x = -2; x <= size.width + 2; x += 2) {
      final normalizedX = x / size.width;
      final distance = (x - touchPoint.dx) / (size.width * 0.22);
      final indentation =
          math.exp(-(distance * distance)) * impactEnvelope * 7.5;
      final y =
          baseY +
          math.sin(normalizedX * math.pi * 2 * frequency + phase) * amplitude +
          math.cos(normalizedX * math.pi * 3.2 - phase * 0.72) * 1.2 +
          indentation;
      path.lineTo(x, y);
    }
    return path
      ..lineTo(size.width + 2, size.height + 2)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final phase = wave.value * math.pi * 2;
    final pressureT = pressure.value.clamp(0.0, 1.0);
    final impactT = impact.value.clamp(0.0, 1.0);
    final impactContact = impactT < 0.32
        ? Curves.easeOutCubic.transform(impactT / 0.32)
        : 1 - Curves.easeInCubic.transform((impactT - 0.32) / 0.68);
    final contact = math.min(1.0, pressureT * 0.82 + impactContact * 0.42);
    final touchPoint = touchOrigin.value;
    final safeTouch = Offset(
      touchPoint.dx.clamp(5.0, size.width - 5),
      touchPoint.dy.clamp(5.0, size.height - 5),
    );

    canvas.save();
    canvas.clipPath(Path()..addOval(Offset.zero & size));

    final backWave = _wavePath(
      size: size,
      phase: phase + 1.15,
      baseY: size.height * 0.39,
      amplitude: 3.1,
      frequency: 1.05,
      impactEnvelope: contact * 0.72,
      touchPoint: touchPoint,
    );
    canvas.drawPath(
      backWave,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: highContrast ? 0.29 : 0.21),
            const Color(0xFFBCEBFF).withValues(alpha: 0.11),
          ],
        ).createShader(Offset.zero & size),
    );

    final frontWave = _wavePath(
      size: size,
      phase: -phase * 0.84,
      baseY: size.height * 0.52,
      amplitude: 3.8,
      frequency: 1.2,
      impactEnvelope: contact,
      touchPoint: touchPoint,
    );
    canvas.drawPath(
      frontWave,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFB6EAFF).withValues(alpha: 0.12),
            const Color(0xFF0078E7).withValues(alpha: 0.32),
            const Color(0xFF004FAE).withValues(alpha: 0.40),
          ],
          stops: const [0, 0.58, 1],
        ).createShader(Offset.zero & size),
    );

    final surfacePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = highContrast ? 1.35 : 1
      ..color = Colors.white.withValues(alpha: highContrast ? 0.54 : 0.38);
    final surface = Path();
    for (double x = -2; x <= size.width + 2; x += 2) {
      final normalizedX = x / size.width;
      final distance = (x - touchPoint.dx) / (size.width * 0.22);
      final indentation = math.exp(-(distance * distance)) * contact * 7.5;
      final y =
          size.height * 0.52 +
          math.sin(normalizedX * math.pi * 2.4 - phase * 0.84) * 3.8 +
          math.cos(normalizedX * math.pi * 3.2 + phase * 0.60) * 1.2 +
          indentation;
      if (x == -2) {
        surface.moveTo(x, y);
      } else {
        surface.lineTo(x, y);
      }
    }
    canvas.drawPath(surface, surfacePaint);

    if (pressureT > 0 || (impactT > 0 && impactT < 1)) {
      final rippleT = Curves.easeOutCubic.transform(impactT);
      final fade = math.pow(1 - impactT, 1.35).toDouble();
      final depressionRadius = 8 + contact * 13;
      canvas.drawCircle(
        safeTouch,
        depressionRadius,
        Paint()
          ..shader =
              RadialGradient(
                colors: [
                  const Color(0xFF003B82).withValues(alpha: 0.29 * contact),
                  const Color(0xFF58C7FF).withValues(alpha: 0.10 * contact),
                  Colors.transparent,
                ],
              ).createShader(
                Rect.fromCircle(center: safeTouch, radius: depressionRadius),
              ),
      );

      if (impactT > 0 && impactT < 1) {
        canvas.drawCircle(
          safeTouch,
          4 + size.width * 0.61 * rippleT,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8 - impactT * 0.7
            ..color = Colors.white.withValues(alpha: 0.62 * fade),
        );
      }

      final secondRippleT = ((impactT - 0.16) / 0.84).clamp(0.0, 1.0);
      if (secondRippleT > 0) {
        canvas.drawCircle(
          safeTouch,
          3 + size.width * 0.48 * Curves.easeOut.transform(secondRippleT),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.1
            ..color = const Color(
              0xFFD8F5FF,
            ).withValues(alpha: 0.38 * (1 - secondRippleT)),
        );
      }

      canvas.drawCircle(
        safeTouch.translate(-2.4, -2.8),
        2.3 + contact * 1.8,
        Paint()..color = Colors.white.withValues(alpha: 0.52 * contact),
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PrimaryLiquidPainter oldDelegate) =>
      oldDelegate.touchOrigin != touchOrigin ||
      oldDelegate.highContrast != highContrast;
}

class _GlassTabButton extends StatelessWidget {
  const _GlassTabButton({
    super.key,
    required this.tab,
    required this.selected,
    required this.pressed,
    required this.reduceMotion,
    required this.onTapDown,
    required this.onTapEnd,
    required this.onTap,
  });

  final _TabSpec tab;
  final bool selected;
  final bool pressed;
  final bool reduceMotion;
  final VoidCallback onTapDown;
  final VoidCallback onTapEnd;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFF087BEB);
    const inactive = Color(0xB82E343D);
    final duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 220);

    return Semantics(
      label: tab.label,
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => onTapDown(),
        onTapCancel: onTapEnd,
        onTapUp: (_) => onTapEnd(),
        onTap: onTap,
        child: AnimatedScale(
          scale: pressed && !reduceMotion ? 0.92 : 1,
          duration: pressed
              ? const Duration(milliseconds: 100)
              : const Duration(milliseconds: 220),
          curve: pressed ? Curves.easeOut : Curves.easeOutBack,
          child: AnimatedSlide(
            offset: selected && !reduceMotion
                ? const Offset(0, -0.025)
                : Offset.zero,
            duration: duration,
            curve: Curves.easeOutCubic,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  width: 28,
                  height: 29,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: selected
                        ? const [
                            BoxShadow(
                              color: Color(0x280087FF),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    tab.icon,
                    size: selected ? 23 : 22,
                    color: selected ? active : inactive,
                  ),
                ),
                const SizedBox(height: 1),
                AnimatedDefaultTextStyle(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    color: selected ? active : inactive,
                    fontSize: 10.5,
                    height: 1,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: -0.15,
                  ),
                  child: Text(tab.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmbientBackdropPainter extends CustomPainter {
  const _AmbientBackdropPainter({required this.colors, required this.seed});

  final List<Color> colors;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final haze = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 58);

    haze.shader =
        RadialGradient(
          colors: [
            colors[0].withValues(alpha: 0.34),
            colors[0].withValues(alpha: 0),
          ],
        ).createShader(
          Rect.fromCircle(
            center: Offset(
              size.width * (0.12 + seed * 0.04),
              size.height * 0.22,
            ),
            radius: size.width * 0.66,
          ),
        );
    canvas.drawCircle(
      Offset(size.width * (0.08 + seed * 0.035), size.height * 0.22),
      size.width * 0.47,
      haze,
    );

    haze.shader =
        RadialGradient(
          colors: [
            colors[2].withValues(alpha: 0.33),
            colors[2].withValues(alpha: 0),
          ],
        ).createShader(
          Rect.fromCircle(
            center: Offset(size.width * 0.87, size.height * 0.66),
            radius: size.width * 0.58,
          ),
        );
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.66),
      size.width * 0.48,
      haze,
    );

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.white.withValues(alpha: 0.28);
    final path = Path()
      ..moveTo(-40, size.height * 0.78)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.68,
        size.width * 0.60,
        size.height * 0.96,
        size.width + 40,
        size.height * 0.80,
      );
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _AmbientBackdropPainter oldDelegate) =>
      oldDelegate.seed != seed || oldDelegate.colors != colors;
}

class _FeatureLandscapePainter extends CustomPainter {
  const _FeatureLandscapePainter({required this.colors});

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [const Color(0xBFFFFFFF), colors[2].withValues(alpha: 0)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.72, size.height * 0.22),
              radius: size.width * 0.35,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.22),
      size.width * 0.34,
      glow,
    );

    final farHill = Path()
      ..moveTo(-20, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.34,
        size.width * 0.57,
        size.height * 0.70,
      )
      ..quadraticBezierTo(
        size.width * 0.80,
        size.height * 0.48,
        size.width + 20,
        size.height * 0.68,
      )
      ..lineTo(size.width + 20, size.height + 20)
      ..lineTo(-20, size.height + 20)
      ..close();
    canvas.drawPath(farHill, Paint()..color = const Color(0x2EFFFFFF));

    final nearHill = Path()
      ..moveTo(-20, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.56,
        size.width * 0.57,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.80,
        size.height * 0.65,
        size.width + 20,
        size.height * 0.79,
      )
      ..lineTo(size.width + 20, size.height + 20)
      ..lineTo(-20, size.height + 20)
      ..close();
    canvas.drawPath(nearHill, Paint()..color = const Color(0x38223870));

    final sheen = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x5FFFFFFF), Color(0x00FFFFFF)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sheen);
  }

  @override
  bool shouldRepaint(covariant _FeatureLandscapePainter oldDelegate) =>
      oldDelegate.colors != colors;
}

class _TouchGlowPainter extends CustomPainter {
  const _TouchGlowPainter({required this.touchX, required this.touching});

  final double touchX;
  final bool touching;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);
    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, radius));

    if (touching) {
      final center = Offset(size.width * touchX, size.height * 0.30);
      final touchGlow = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.36),
            const Color(0xFF8EC9FF).withValues(alpha: 0.10),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: 82));
      canvas.drawCircle(center, 82, touchGlow);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TouchGlowPainter oldDelegate) =>
      oldDelegate.touchX != touchX || oldDelegate.touching != touching;
}

class _TabSpec {
  const _TabSpec(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _PageSpec {
  const _PageSpec({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.featureTitle,
    required this.featureSubtitle,
    required this.colors,
    required this.cardColors,
    required this.symbol,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final String featureTitle;
  final String featureSubtitle;
  final List<Color> colors;
  final List<Color> cardColors;
  final IconData symbol;
}
