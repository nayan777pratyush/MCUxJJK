import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/fusion_model.dart';

class ResultScreen extends StatelessWidget {
  final FusionCharacter fusion;
  final Function(int) onNavigate;
  final VoidCallback onSaveFusion;

  const ResultScreen({
    super.key,
    required this.fusion,
    required this.onNavigate,
    required this.onSaveFusion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.voidBg,
      child: Stack(
        children: [
          // Background ambient occult glow
          Positioned(
            top: -40,
            left: -50,
            width: 300,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryContainer.withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            top: 280,
            right: -60,
            width: 260,
            height: 260,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiaryContainer.withOpacity(0.1),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 8),
                  _buildHeroArtworkZone(),
                  const SizedBox(height: 14),
                  _buildFusionIdentityCard(),
                  const SizedBox(height: 14),
                  _buildAbilitiesSection(),
                  const SizedBox(height: 14),
                  _buildSignatureTechniqueCard(),
                  const SizedBox(height: 14),
                  _buildMcuPowersCard(),
                  const SizedBox(height: 14),
                  _buildOriginStoryCard(),
                  const SizedBox(height: 16),
                  _buildActionButtons(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => onNavigate(1), // Back to Builder
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
          ),
        ),
        Column(
          children: [
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
                  'FUSION DOSSIER',
                  style: AppStyles.headlineSm(color: AppColors.primary).copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            Text(
              '// PROTOCOL: SYNTHESIS COMPLETE',
              style: AppStyles.labelCyberSm(color: AppColors.outline),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 6),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
              ),
              child: const Icon(Icons.bookmark_border, color: Colors.white, size: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroArtworkZone() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cursedPurple.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cursedPurple.withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            if (fusion.imageUrl != null)
              (fusion.imageUrl!.startsWith('assets/')
                  ? Image.asset(
                      fusion.imageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) => _buildFallbackHero(),
                    )
                  : Image.network(
                      fusion.imageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) => _buildFallbackHero(),
                    ))
            else
              _buildFallbackHero(),
            // Gradient scrim
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      AppColors.voidBg.withOpacity(0.95),
                    ],
                  ),
                ),
              ),
            ),
            // Badges
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.8)),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 10),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.diamond, color: AppColors.primary, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'SPECIAL GRADE OMNI',
                      style: AppStyles.labelCyberSm(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryContainer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.tertiaryContainer),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFDC2626).withOpacity(0.5), blurRadius: 12),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt, color: Colors.white, size: 12),
                    const SizedBox(width: 3),
                    Text(
                      'NEW SYNTHESIS',
                      style: AppStyles.labelCyberSm(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E0E12).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'SYNC: 99.8%',
                      style: AppStyles.labelCyberSm(color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackHero() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [
            fusion.primaryColor.withOpacity(0.4),
            const Color(0xFF140726),
            const Color(0xFF08070D),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsating ring
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: fusion.primaryColor.withOpacity(0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: fusion.primaryColor.withOpacity(0.3),
                  blurRadius: 36,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
          // Inner glowing core
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  fusion.primaryColor.withOpacity(0.5),
                  AppColors.primary.withOpacity(0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.7),
                width: 2,
              ),
            ),
          ),
          Icon(fusion.avatarIcon, size: 70, color: Colors.white),
          Positioned(
            top: 50,
            left: 70,
            child: Icon(Icons.auto_awesome, size: 22, color: AppColors.secondary),
          ),
          Positioned(
            bottom: 50,
            right: 70,
            child: Icon(Icons.electric_bolt, size: 24, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildFusionIdentityCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SYNTHESIZED ENTITY // #009-S',
            style: AppStyles.labelCyberSm(color: AppColors.secondary),
          ),
          const SizedBox(height: 4),
          Text(
            fusion.name,
            style: AppStyles.headlineLg(color: Colors.white).copyWith(
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          // Lineage Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.all_inclusive, color: AppColors.secondary, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      fusion.mcuParent.toUpperCase(),
                      style: AppStyles.labelCyberSm(color: Colors.white),
                    ),
                  ],
                ),
                const Text('Ã—', style: TextStyle(color: AppColors.tertiaryContainer, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(
                      fusion.jjkParent.toUpperCase(),
                      style: AppStyles.labelCyberSm(color: AppColors.primary),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.visibility, color: AppColors.primary, size: 14),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'ORIGIN: DUAL REALITY // MATRIX: OMNI-CLASS',
              style: AppStyles.labelCyberSm(color: AppColors.outline),
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.outlineVariant.withOpacity(0.3)),
          const SizedBox(height: 8),
          // Power Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'TOTAL POWER RATING // OVERLOAD',
                style: AppStyles.labelCyberSm(color: AppColors.outline),
              ),
              RichText(
                text: TextSpan(
                  text: '${fusion.powerLevel}',
                  style: AppStyles.displayHero(color: AppColors.tertiaryContainer).copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' / 10,000',
                      style: AppStyles.labelCyberSm(color: AppColors.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Power bar
          Container(
            height: 10,
            width: double.infinity,
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.4)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fusion.powerLevel / 10000.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.powerGauge,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.tertiaryContainer.withOpacity(0.8),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('CALIBRATION: STABLE', style: AppStyles.labelCyberSm(color: AppColors.outline).copyWith(fontSize: 8)),
              Text('CRITICAL DOMAIN RESONANCE', style: AppStyles.labelCyberSm(color: AppColors.tertiaryContainer).copyWith(fontSize: 8)),
              Text('THRESHOLD: 98.5%', style: AppStyles.labelCyberSm(color: AppColors.outline).copyWith(fontSize: 8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 3,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Text('CURSED TECHNIQUES & POWERS', style: AppStyles.labelCyberMd(color: Colors.white)),
              ],
            ),
            Row(
              children: [
                _buildPip(AppColors.primary),
                _buildPip(AppColors.primary),
                _buildPip(AppColors.secondary),
                _buildPip(AppColors.secondary),
                _buildPip(AppColors.tertiaryContainer),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.2,
          ),
          itemCount: fusion.abilities.length,
          itemBuilder: (context, index) {
            final ab = fusion.abilities[index];
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ab.color.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ab.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(ab.icon, color: ab.color, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ab.name,
                          style: AppStyles.labelCyberSm(color: ab.color).copyWith(fontSize: 8),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          ab.description,
                          style: AppStyles.bodySm(color: AppColors.outline).copyWith(fontSize: 9),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPip(Color color) {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildSignatureTechniqueCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryContainer.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(color: const Color(0xFFDC2626).withOpacity(0.25), blurRadius: 16),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SIGNATURE CURSED TECHNIQUE // DOMAIN', style: AppStyles.labelCyberSm(color: AppColors.tertiary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.tertiaryContainer),
                ),
                child: Text('SPECIAL GRADE', style: AppStyles.labelCyberSm(color: AppColors.tertiary).copyWith(fontSize: 8)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.emergency, color: AppColors.tertiaryContainer, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  fusion.domainExpansion,
                  style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            fusion.domainDescription,
            style: AppStyles.bodySm(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildMcuPowersCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: AppColors.secondary.withOpacity(0.2), blurRadius: 16),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MCU ABILITIES ABSORBED // MYSTIC RELIC ENGINE', style: AppStyles.labelCyberSm(color: AppColors.secondary)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.cyclone, color: AppColors.secondary, size: 16),
              const SizedBox(width: 6),
              Text(
                fusion.mcuPowersName,
                style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: fusion.mcuPowerTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.4)),
                ),
                child: Text(tag, style: AppStyles.labelCyberSm(color: AppColors.secondary).copyWith(fontSize: 8)),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          Text(
            fusion.mcuPowersDescription,
            style: AppStyles.bodySm(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginStoryCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('CLASSIFIED ORIGIN PROTOCOL // CONVERGENCE POINT', style: AppStyles.labelCyberSm(color: AppColors.primary)),
              const Icon(Icons.verified_user, color: AppColors.primary, size: 14),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            fusion.originStory,
            style: AppStyles.bodySm(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onSaveFusion();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.surfaceContainerHigh,
                content: Text(
                  '${fusion.name} saved to Archive!',
                  style: AppStyles.bodyMd(color: AppColors.primary),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            onNavigate(3); // Go to Saved Screen
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: AppGradients.fusionButton,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withOpacity(0.6),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SAVE FUSION',
                  style: AppStyles.headlineSm(color: Colors.white).copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.check_circle, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => onNavigate(1), // Back to Builder
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary.withOpacity(0.6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bolt, color: AppColors.primary, size: 16),
                const SizedBox(width: 6),
                Text(
                  'CREATE NEW FUSION',
                  style: AppStyles.labelCyberLg(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

