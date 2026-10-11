import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/fusion_data.dart';
import '../models/fusion_model.dart';
import '../services/gemini_service.dart';

class BuilderScreen extends StatefulWidget {
  final Function(int) onNavigate;
  final Function(FusionCharacter) onGenerateFusion;

  const BuilderScreen({
    super.key,
    required this.onNavigate,
    required this.onGenerateFusion,
  });

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  Character? selectedMcu = FusionData.mcuCharacters[2]; // Doctor Strange
  Character? selectedJjk = FusionData.jjkCharacters[0]; // Gojo Satoru
  bool _isLoading = false;
  String _loadingMessage = 'COMMUNING WITH GEMINI AI...';

  Future<void> _handleGenerate() async {
    if (selectedMcu == null || selectedJjk == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.surfaceContainerHigh,
          content: Text(
            'SELECT BOTH AN MCU WARRIOR AND JJK SORCERER',
            style: AppStyles.labelCyberSm(color: AppColors.tertiaryContainer),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _loadingMessage =
          'SYNTHESIZING ${selectedMcu!.name} × ${selectedJjk!.name}...';
    });

    try {
      final fusion = await GeminiFusionService.generateFusion(
        mcuCharacter: selectedMcu!,
        jjkCharacter: selectedJjk!,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      widget.onGenerateFusion(fusion);
      widget.onNavigate(2); // Go to Result Screen
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF131317),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.tertiaryContainer, width: 1.5),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber, color: AppColors.tertiaryContainer),
              const SizedBox(width: 8),
              Text(
                'SYNTHESIS ANOMALY',
                style: AppStyles.headlineSm(color: AppColors.tertiaryContainer),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gemini AI synthesis encountered a dimensional breach:',
                style: AppStyles.bodyMd(color: AppColors.onSurface),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  e.toString().replaceAll('Exception: ', ''),
                  style: AppStyles.labelCyberSm(color: AppColors.tertiary),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'CANCEL',
                style: AppStyles.labelCyberSm(color: AppColors.outline),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cursedPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                _handleGenerate();
              },
              child: Text(
                'RETRY SYNTHESIS',
                style: AppStyles.labelCyberSm(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.voidBg,
      child: Stack(
        children: [
          // Ambient Glows
          Positioned(
            top: -60,
            left: -50,
            width: 250,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: -50,
            width: 240,
            height: 240,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryContainer.withValues(alpha: 0.1),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildSubtitleBanner(),
                  const SizedBox(height: 16),
                  _buildMcuSection(),
                  const SizedBox(height: 14),
                  _buildCatalystDivider(),
                  const SizedBox(height: 14),
                  _buildJjkSection(),
                  const SizedBox(height: 16),
                  _buildFusionPreviewStrip(),
                  const SizedBox(height: 16),
                  _buildGenerateButton(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Occult AI Loading Overlay
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF131317),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cursedPurple, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.cursedPurple.withValues(alpha: 0.5),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.cursedPurple,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'GEMINI AI SYNTHESIS',
                style: AppStyles.headlineSm(color: Colors.white).copyWith(
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _loadingMessage,
                textAlign: TextAlign.center,
                style: AppStyles.labelCyberSm(color: AppColors.primary),
              ),
              const SizedBox(height: 14),
              Container(
                height: 4,
                width: 140,
                decoration: BoxDecoration(
                  gradient: AppGradients.fusionButton,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => widget.onNavigate(0),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
          ),
        ),
        Column(
          children: [
            Text(
              'FUSION BUILDER',
              style: AppStyles.headlineSm(color: Colors.white).copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'PROTOCOL // SYNTHESIS-02',
                  style: AppStyles.labelCyberSm(color: AppColors.outline),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: const Icon(Icons.tune, color: AppColors.secondary, size: 18),
        ),
      ],
    );
  }

  Widget _buildSubtitleBanner() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.grain, color: AppColors.primary, size: 12),
                const SizedBox(width: 5),
                Text(
                  '[ DUAL CATALYST MATRIX ]',
                  style: AppStyles.labelCyberSm(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'SELECT YOUR WARRIORS',
            style: AppStyles.labelCyberSm(color: AppColors.outline)
                .copyWith(letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildMcuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt, color: AppColors.secondary, size: 16),
                const SizedBox(width: 6),
                Text(
                  'MCU CHAMPION',
                  style: AppStyles.headlineSm(color: AppColors.secondary)
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border:
                    Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
              ),
              child: Text(
                '[ 1 / 6 SELECTED ]',
                style: AppStyles.labelCyberSm(color: AppColors.secondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.35,
          ),
          itemCount: FusionData.mcuCharacters.length,
          itemBuilder: (context, index) {
            final char = FusionData.mcuCharacters[index];
            final isSelected = selectedMcu?.id == char.id;
            return _buildCharacterCard(
              char: char,
              isSelected: isSelected,
              accentColor: AppColors.secondary,
              onTap: () => setState(() => selectedMcu = char),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCatalystDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.voidBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryContainer.withValues(alpha: 0.3),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.6),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '×',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'SYNTHESIS APERTURE',
                style: AppStyles.labelCyberSm(color: AppColors.primary),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_double_arrow_down,
                color: AppColors.primary,
                size: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJjkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: AppColors.tertiaryContainer,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'JJK SORCERER',
                  style: AppStyles.headlineSm(color: AppColors.tertiaryContainer)
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.tertiaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.tertiaryContainer.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '[ 1 / 6 SELECTED ]',
                style:
                    AppStyles.labelCyberSm(color: AppColors.tertiaryContainer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.35,
          ),
          itemCount: FusionData.jjkCharacters.length,
          itemBuilder: (context, index) {
            final char = FusionData.jjkCharacters[index];
            final isSelected = selectedJjk?.id == char.id;
            return _buildCharacterCard(
              char: char,
              isSelected: isSelected,
              accentColor: AppColors.cursedPurple,
              onTap: () => setState(() => selectedJjk = char),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCharacterCard({
    required Character char,
    required bool isSelected,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerHigh.withValues(alpha: 0.8)
              : AppColors.surfaceContainerLow.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? accentColor
                : AppColors.outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.45),
                    blurRadius: 16,
                  )
                ]
              : [],
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SELECTED',
                        style: AppStyles.labelCyberSm(color: Colors.black)
                            .copyWith(fontSize: 7),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.check, size: 8, color: Colors.black),
                    ],
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      char.titleTag,
                      style: AppStyles.labelCyberSm(
                        color: isSelected ? accentColor : AppColors.outline,
                      ).copyWith(fontSize: 8),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Icon(char.icon, color: accentColor, size: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      char.name,
                      style: AppStyles.headlineSm(
                        color: isSelected ? accentColor : Colors.white,
                      ).copyWith(fontSize: 12),
                    ),
                    Text(
                      'PWR // ${char.powerRating}',
                      style: AppStyles.labelCyberSm(color: AppColors.outline)
                          .copyWith(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFusionPreviewStrip() {
    final mcuName = selectedMcu?.name.split(' ').first ?? 'STRANGE';
    final jjkName = selectedJjk?.name.split(' ').first ?? 'GOJO';
    final estimatedPower = ((selectedMcu?.powerRating ?? 9780) +
            (selectedJjk?.powerRating ?? 9990)) ~/
        2;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedMcu?.icon ?? Icons.auto_awesome,
                          size: 12,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          mcuName,
                          style: AppStyles.headlineSm(color: AppColors.secondary)
                              .copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '×',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedJjk?.icon ?? Icons.visibility,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          jjkName,
                          style: AppStyles.headlineSm(color: AppColors.primary)
                              .copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.bolt, color: AppColors.secondary, size: 14),
                  Text(
                    '$estimatedPower',
                    style: AppStyles.labelCyberMd(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI SYNTHESIS: SPECIAL GRADE OMNI-SORCERER',
                style: AppStyles.labelCyberSm(color: AppColors.onSurfaceVariant)
                    .copyWith(fontSize: 8),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'GEMINI 2.0',
                  style: AppStyles.labelCyberSm(color: AppColors.primary)
                      .copyWith(fontSize: 7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _handleGenerate,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: AppGradients.fusionButton,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.cursedPurple.withValues(alpha: 0.5),
              blurRadius: 24,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLoading ? 'SYNTHESIZING...' : 'GENERATE FUSION',
              style: AppStyles.headlineMd(color: Colors.white).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              _isLoading ? Icons.hourglass_top : Icons.bolt,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
