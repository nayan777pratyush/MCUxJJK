import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/fusion_data.dart';
import '../models/fusion_model.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  final Function(FusionCharacter) onSelectFusion;

  const HomeScreen({
    super.key,
    required this.onNavigate,
    required this.onSelectFusion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.voidBg,
      child: Stack(
        children: [
          // Background ambient occult glow
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 380,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, -0.6),
                  radius: 0.8,
                  colors: [
                    Color(0x33A855F7),
                    Color(0x14DC2626),
                    Colors.transparent,
                  ],
                ),
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
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildFeaturedFusionHero(),
                  const SizedBox(height: 24),
                  _buildTrendingHeader(),
                  const SizedBox(height: 12),
                  _buildTrendingCarousel(),
                  const SizedBox(height: 24),
                  _buildBrowseByUniverse(),
                  const SizedBox(height: 24),
                  _buildRecentFusions(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryContainer.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.token, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MCU × JJK',
                  style: AppStyles.headlineSm(color: AppColors.primary).copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    shadows: [
                      const Shadow(color: AppColors.cursedPurple, blurRadius: 12),
                    ],
                  ),
                ),
                Text(
                  'NEXUS // OC-01',
                  style: AppStyles.labelCyberSm(color: AppColors.outline),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_active, color: AppColors.primary, size: 18),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.tertiaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0xFFFF544A), blurRadius: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cursedPurple.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cursedPurple.withOpacity(0.18),
            blurRadius: 16,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.outline, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search fusions, characters...',
              style: AppStyles.bodyMd(color: AppColors.outline),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.outlineVariant.withOpacity(0.4))),
            ),
            child: const Icon(Icons.tune, color: AppColors.secondary, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedFusionHero() {
    final hero = FusionData.infiniteSorcerer;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withOpacity(0.5),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top laser accent
            Container(
              height: 2,
              decoration: const BoxDecoration(gradient: AppGradients.cursedLaser),
            ),
            // Hero Image Zone
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF160826),
                        const Color(0xFF0A0A12),
                        hero.primaryColor.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: hero.imageUrl != null
                      ? Image.network(
                          hero.imageUrl!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (_, __, ___) => _buildHeroIllustration(hero),
                        )
                      : _buildHeroIllustration(hero),
                ),
                // Gradient scrim overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          AppColors.voidBg.withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                ),
                // Top floating badges
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary.withOpacity(0.6)),
                    ),
                    child: Text(
                      '[SYS] FEATURED FUSION',
                      style: AppStyles.labelCyberSm(color: AppColors.primary),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryContainer.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC2626).withOpacity(0.6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'POWER: ${hero.powerLevel}',
                          style: AppStyles.labelCyberSm(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Hero Info Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hero.name,
                    style: AppStyles.headlineMd(color: Colors.white).copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(hero.jjkParent, style: AppStyles.bodySm(color: AppColors.onSurfaceVariant)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('×', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      Text(hero.mcuParent, style: AppStyles.bodySm(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Ability Pills
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _buildPill(Icons.visibility, 'SIX EYES INFINITY', AppColors.primary),
                      _buildPill(Icons.layers, 'MIRROR DIMENSION', AppColors.secondary),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // CTA Button
                  GestureDetector(
                    onTap: () {
                      onSelectFusion(hero);
                      onNavigate(2); // Go to Result Screen
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: AppGradients.fusionButton,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cursedPurple.withOpacity(0.5),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'VIEW FUSION DOSSIER',
                            style: AppStyles.headlineSm(color: Colors.white).copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroIllustration(FusionCharacter hero) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.85,
          colors: [
            hero.primaryColor.withOpacity(0.35),
            const Color(0xFF130924),
            const Color(0xFF090810),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background aura rings
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: hero.primaryColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: hero.primaryColor.withOpacity(0.25),
                  blurRadius: 30,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  hero.primaryColor.withOpacity(0.4),
                  AppColors.primary.withOpacity(0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.6),
                width: 1.5,
              ),
            ),
          ),
          // Central Iconic Fusion Glyph
          Icon(
            hero.avatarIcon,
            size: 64,
            color: Colors.white,
          ),
          // Occult Corner Sparkles
          Positioned(
            top: 45,
            left: 60,
            child: Icon(
              Icons.auto_awesome,
              size: 18,
              color: AppColors.secondary.withOpacity(0.8),
            ),
          ),
          Positioned(
            bottom: 45,
            right: 60,
            child: Icon(
              Icons.flare,
              size: 20,
              color: hero.primaryColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.2), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(text, style: AppStyles.labelCyberSm(color: color)),
        ],
      ),
    );
  }

  Widget _buildTrendingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('TRENDING COMBINATIONS', style: AppStyles.headlineSm(color: Colors.white)),
            const SizedBox(width: 6),
            const Icon(Icons.local_fire_department, color: Color(0xFFFF544A), size: 18),
          ],
        ),
        GestureDetector(
          onTap: () => onNavigate(3), // Navigate to Archive
          child: Text(
            'SEE ALL',
            style: AppStyles.labelCyberSm(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCarousel() {
    final trending = FusionData.defaultSavedFusions.sublist(1, 4);

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trending.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = trending[index];
          return GestureDetector(
            onTap: () {
              onSelectFusion(item);
              onNavigate(2);
            },
            child: Container(
              width: 170,
              padding: const EdgeInsets.all(12),
              decoration: glassCardDecoration(
                borderColor: item.primaryColor.withOpacity(0.4),
                glowColor: item.primaryColor.withOpacity(0.2),
                glowRadius: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: item.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: item.primaryColor.withOpacity(0.5)),
                        ),
                        child: Icon(item.avatarIcon, color: item.primaryColor, size: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: item.primaryColor.withOpacity(0.4)),
                        ),
                        child: Text(
                          '${item.powerLevel}',
                          style: AppStyles.labelCyberSm(color: item.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('// CLASSIFIED', style: AppStyles.labelCyberSm(color: AppColors.outline)),
                      const SizedBox(height: 2),
                      Text(
                        item.name,
                        style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${item.jjkParent} Ã— ${item.mcuParent}',
                        style: AppStyles.bodySm(color: AppColors.outline),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrowseByUniverse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BROWSE BY UNIVERSE', style: AppStyles.headlineSm(color: Colors.white)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildUniverseCard(
                title: 'MARVEL / MCU',
                subtitle: '247 CHARACTERS',
                icon: Icons.shield,
                color: AppColors.secondary,
                onTap: () => onNavigate(1), // Go to Builder
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildUniverseCard(
                title: 'JUJUTSU KAISEN',
                subtitle: '89 CHARACTERS',
                icon: Icons.local_fire_department,
                color: AppColors.cursedPurple,
                onTap: () => onNavigate(1), // Go to Builder
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUniverseCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 12),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: AppStyles.labelCyberSm(color: AppColors.outline)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentFusions() {
    final recent = FusionData.defaultSavedFusions.sublist(4, 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.history_edu, color: AppColors.primary, size: 18),
            const SizedBox(width: 6),
            Text('RECENT FUSIONS', style: AppStyles.headlineSm(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recent.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = recent[index];
            return GestureDetector(
              onTap: () {
                onSelectFusion(item);
                onNavigate(2);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: glassCardDecoration(
                  borderColor: AppColors.outlineVariant.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: item.primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: item.primaryColor.withOpacity(0.6)),
                        boxShadow: [
                          BoxShadow(color: item.primaryColor.withOpacity(0.3), blurRadius: 8),
                        ],
                      ),
                      child: Icon(item.avatarIcon, color: item.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 14)),
                          Text('${item.jjkParent} Ã— ${item.mcuParent}', style: AppStyles.bodySm(color: AppColors.outline)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: item.primaryColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        '${item.powerLevel}',
                        style: AppStyles.labelCyberSm(color: item.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right, color: AppColors.outline, size: 18),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

