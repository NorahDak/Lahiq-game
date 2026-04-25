import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const LahiqApp());
}

class LahiqApp extends StatelessWidget {
  const LahiqApp({super.key});

  @override
  Widget build(BuildContext context) {
    const deepPurple = Color(0xFF3B1D6E);
    const deepPurple2 = Color(0xFF2A1352);
    const amber = Color(0xFFFFC107);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لحّق',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: deepPurple).copyWith(
          primary: deepPurple,
          secondary: amber,
          surface: const Color(0xFF0F0B1A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0B0714),
        textTheme: GoogleFonts.tajawalTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.tajawal(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: amber,
            foregroundColor: deepPurple2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            textStyle: GoogleFonts.tajawal(fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF151026),
          hintStyle: GoogleFonts.tajawal(color: Colors.white70),
          labelStyle: GoogleFonts.tajawal(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: amber, width: 1.5),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF151026),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final List<String> _players = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addPlayer() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _players.add(name);
      _controller.clear();
    });
  }

  void _removePlayer(int index) {
    setState(() => _players.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const _AnimatedBackdrop(),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'لحّق',
                          style: GoogleFonts.tajawal(
                            fontSize: 54,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              scheme.secondary.withOpacity(0.95),
                              scheme.secondary.withOpacity(0.65),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: scheme.secondary.withOpacity(0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.flash_on_rounded, size: 28, color: Color(0xFF2A1352)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اللعبة الأسرع في اللمة: سمِّ ٣–٥ عناصر بحرف معيّن خلال ٧ ثواني!',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'أضف اللاعبين',
                            style: GoogleFonts.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => _addPlayer(),
                                  style: GoogleFonts.tajawal(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'اسم اللاعب',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: _addPlayer,
                                style: IconButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  foregroundColor: const Color(0xFF2A1352),
                                  padding: const EdgeInsets.all(14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                icon: const Icon(Icons.add_rounded),
                                tooltip: 'إضافة',
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          if (_players.isEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white.withOpacity(0.08)),
                                color: Colors.white.withOpacity(0.03),
                              ),
                              child: Text(
                                'ابدأ بإضافة أسماء اللاعبين…',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          else
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (int i = 0; i < _players.length; i++)
                                  _PlayerChip(
                                    name: _players[i],
                                    onRemove: () => _removePlayer(i),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _players.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: GameScreen(players: List.of(_players)),
                                ),
                              ),
                            );
                          },
                    child: const Text('ابدأ اللعبة'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'تلميح: كل نقرة = عنصر واحد. خلّك سريع!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(
                      color: Colors.white54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.players});
  final List<String> players;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _rng = Random();

  static const int _totalMs = 7000;

  // Exclude difficult letters: ظ، ذ، غ (and keep the set friendly for fast word recall).
  final List<String> _letters = const [
    'ا', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ',
    'د', 'ر', 'ز', 'س', 'ش', 'ص', 'ض',
    'ط', 'ع', 'ف', 'ق', 'ك', 'ل', 'م',
    'ن', 'هـ', 'و', 'ي',
  ];

  final List<String> _categories = const [
    'مطاعم شاورما',
    'ماركات سيارات',
    'أشياء في شنطة',
    'براندات قهوة',
    'مدن سعودية',
    'أكلات شعبية',
    'بقالة',
    'تطبيقات جوال',
    'لاعبين كرة',
    'برامج أطفال',
  ];

  int _playerIndex = 0;

  String? _letter;
  String? _category;
  int _target = 3;

  int _taps = 0;

  bool _started = false;
  bool _finished = false;
  bool _success = false;

  int _remainingMs = _totalMs;
  Timer? _timer;

  String get _playerName => widget.players[_playerIndex];

  @override
  void initState() {
    super.initState();
    _generateChallenge(); // pre-generate so UI looks ready
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generateChallenge() {
    _letter = _letters[_rng.nextInt(_letters.length)];
    _category = _categories[_rng.nextInt(_categories.length)];
    _target = 3 + _rng.nextInt(3); // 3..5
  }

  void _resetTurn({bool keepPlayer = true}) {
    _timer?.cancel();
    _timer = null;

    setState(() {
      if (!keepPlayer) {
        _playerIndex = (_playerIndex + 1) % widget.players.length;
      }
      _generateChallenge();
      _taps = 0;
      _started = false;
      _finished = false;
      _success = false;
      _remainingMs = _totalMs;
    });
  }

  void _start() {
    if (_started || _finished) return;

    setState(() {
      _started = true;
      _finished = false;
      _success = false;
      _remainingMs = _totalMs;
      _taps = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      final next = _remainingMs - 50;
      if (!mounted) return;

      if (next <= 0) {
        t.cancel();
        setState(() {
          _remainingMs = 0;
          _finished = true;
          _success = false;
        });
      } else {
        setState(() => _remainingMs = next);
      }
    });
  }

  void _onTapAnywhere() {
    if (!_started || _finished) return;

    if (_taps >= _target) return;

    setState(() => _taps++);

    if (_taps >= _target) {
      _timer?.cancel();
      setState(() {
        _finished = true;
        _success = true;
      });
    }
  }

  Color _progressColor(double p) {
    // p: 0..1 (remaining fraction). Green -> Red as time runs out.
    final t = (1.0 - p).clamp(0.0, 1.0);
    return Color.lerp(const Color(0xFF22C55E), const Color(0xFFEF4444), t)!;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final remainingFraction = (_remainingMs / _totalMs).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('لحّق', style: GoogleFonts.tajawal(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            tooltip: 'إعادة ضبط الجولة',
            onPressed: () => _resetTurn(keepPlayer: true),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const _AnimatedBackdrop(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onTapAnywhere,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TopRoleCard(
                      playerName: _playerName,
                      started: _started,
                      finished: _finished,
                      success: _success,
                    ),
                    const SizedBox(height: 14),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'التحدّي',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: scheme.secondary.withOpacity(0.15),
                                    border: Border.all(
                                      color: scheme.secondary.withOpacity(0.35),
                                    ),
                                  ),
                                  child: Text(
                                    '٧ ثواني',
                                    style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w900,
                                      color: scheme.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _ChallengeRow(
                              label: 'الحرف',
                              value: _letter ?? '—',
                              valueChipGradient: LinearGradient(
                                colors: [scheme.secondary, scheme.secondary.withOpacity(0.75)],
                              ),
                            ),
                            const SizedBox(height: 10),
                            _ChallengeRow(
                              label: 'الفئة',
                              value: _category ?? '—',
                              valueChipGradient: LinearGradient(
                                colors: [scheme.primary, scheme.primary.withOpacity(0.65)],
                              ),
                            ),
                            const SizedBox(height: 10),
                            _ChallengeRow(
                              label: 'المطلوب',
                              value: '$_target عناصر',
                              valueChipGradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                              ),
                            ),
                            const SizedBox(height: 14),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 120),
                                tween: Tween(begin: 0, end: remainingFraction),
                                builder: (context, value, _) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    minHeight: 10,
                                    backgroundColor: Colors.white.withOpacity(0.10),
                                    valueColor: AlwaysStoppedAnimation<Color>(_progressColor(value)),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: _finished ? null : _start,
                                    icon: const Icon(Icons.play_arrow_rounded),
                                    label: const Text('ابدأ'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: (!_finished) ? null : () => _resetTurn(keepPlayer: false),
                                    child: const Text('اللاعب التالي'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _started
                                  ? (_finished
                                      ? (_success ? 'نجحت! أحسنت.' : 'انتهى الوقت! حاول مرّة ثانية الجولة الجاية.')
                                      : 'اضغط على الشاشة مع كل عنصر تقوله.')
                                  : 'اضغط "ابدأ" ثم ابدأ العدّ بالنقر!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                color: Colors.white60,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Text(
                              'العداد بالنقر',
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _TapCircles(
                              total: _target,
                              filled: _taps,
                              accent: scheme.secondary,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'كل نقرة = عنصر واحد',
                              style: GoogleFonts.tajawal(
                                color: Colors.white60,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            scheme.primary.withOpacity(0.22),
                            scheme.secondary.withOpacity(0.14),
                          ],
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Text(
                        _finished
                            ? 'جاهزين للجولة التالية؟'
                            : (_started ? 'اضغط أي مكان للتسجيل بسرعة!' : 'اضغط ابدأ… ثم اضغط أي مكان للتسجيل.'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(
                          color: Colors.white70,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_finished)
              Positioned(
                left: 18,
                right: 18,
                top: 92,
                child: _ResultBanner(success: _success),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({required this.success});
  final bool success;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final Color c1 = success ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final Color c2 = success ? const Color(0xFF16A34A) : const Color(0xFFB91C1C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(colors: [c1.withOpacity(0.90), c2.withOpacity(0.85)]),
        boxShadow: [
          BoxShadow(
            color: c1.withOpacity(0.20),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(success ? Icons.emoji_events_rounded : Icons.timer_off_rounded, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              success ? 'نجاح! خلّصت قبل الوقت.' : 'فشل! الوقت خلص.',
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 15.5,
              ),
            ),
          ),
          Icon(Icons.chevron_left_rounded, color: scheme.surface.withOpacity(0.0)),
        ],
      ),
    );
  }
}

class _TopRoleCard extends StatelessWidget {
  const _TopRoleCard({
    required this.playerName,
    required this.started,
    required this.finished,
    required this.success,
  });

  final String playerName;
  final bool started;
  final bool finished;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final statusText = !started ? 'استعد' : (finished ? (success ? 'نجاح' : 'انتهى') : 'جاري');

    final Color dot = !started
        ? scheme.secondary
        : (finished ? (success ? const Color(0xFF22C55E) : const Color(0xFFEF4444)) : scheme.secondary);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            scheme.primary.withOpacity(0.42),
            scheme.primary.withOpacity(0.18),
            scheme.secondary.withOpacity(0.10),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: dot.withOpacity(0.35), blurRadius: 14)],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الدور: $playerName',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'الحالة: $statusText',
                  style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.06),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Icon(
              started ? Icons.flash_on_rounded : Icons.bolt_rounded,
              color: scheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeRow extends StatelessWidget {
  const _ChallengeRow({
    required this.label,
    required this.value,
    required this.valueChipGradient,
  });

  final String label;
  final String value;
  final Gradient valueChipGradient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.tajawal(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: valueChipGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 14,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Text(
            value,
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B0714),
            ),
          ),
        ),
      ],
    );
  }
}

class _TapCircles extends StatelessWidget {
  const _TapCircles({
    required this.total,
    required this.filled,
    required this.accent,
  });

  final int total;
  final int filled;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(total, (i) => i < filled);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _Circle(isFilled: items[i], accent: accent),
          if (i != items.length - 1) const SizedBox(width: 10),
        ]
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.isFilled, required this.accent});
  final bool isFilled;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final border = Colors.white.withOpacity(0.18);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 1.2),
        gradient: isFilled
            ? LinearGradient(
                colors: [
                  accent.withOpacity(0.98),
                  accent.withOpacity(0.62),
                ],
              )
            : null,
        color: isFilled ? null : Colors.white.withOpacity(0.04),
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: accent.withOpacity(0.22),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: isFilled ? const Icon(Icons.check_rounded, size: 18, color: Color(0xFF2A1352)) : null,
    );
  }
}

class _PlayerChip extends StatelessWidget {
  const _PlayerChip({required this.name, required this.onRemove});
  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.secondary.withOpacity(0.18),
                border: Border.all(color: scheme.secondary.withOpacity(0.30)),
              ),
              child: Icon(Icons.close_rounded, size: 16, color: scheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackdrop extends StatefulWidget {
  const _AnimatedBackdrop();

  @override
  State<_AnimatedBackdrop> createState() => _AnimatedBackdropState();
}

class _AnimatedBackdropState extends State<_AnimatedBackdrop> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = _c.value;
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.6 - t * 0.9, -0.7 + t * 0.7),
              radius: 1.25,
              colors: [
                scheme.primary.withOpacity(0.55),
                const Color(0xFF0B0714),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  scheme.secondary.withOpacity(0.10 + t * 0.05),
                  Colors.transparent,
                  scheme.primary.withOpacity(0.08 + (1 - t) * 0.06),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
