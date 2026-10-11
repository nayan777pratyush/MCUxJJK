import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/fusion_model.dart';

class SavedScreen extends StatefulWidget {
  final List<FusionCharacter> savedFusions;
  final Function(int) onNavigate;
  final Function(FusionCharacter) onSelectFusion;
  final Function(String) onDeleteFusion;

  const SavedScreen({
    super.key,
    required this.savedFusions,
    required this.onNavigate,
    required this.onSelectFusion,
    required this.onDeleteFusion,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String selectedFilter = 'ALL';

  final List<String> filters = [
    'ALL',
    'SPECIAL GRADE',
    'RANK S',
    'MCU ORIGIN',
    'JJK ORIGIN',
  ];

  List<FusionCharacter> get filteredFusions {
    if (selectedFilter == 'ALL') return widget.savedFusions;
    if (selectedFilter == 'SPECIAL GRADE') {
      return widget.savedFusions.where((f) => f.rank == 'SPECIAL GRADE').toList();
    }
    if (selectedFilter == 'RANK S') {
      return widget.savedFusions.where((f) => f.rank == 'RANK S').toList();
    }
    return widget.savedFusions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.voidBg,
      child: Stack(
        children: [
          // Background ambient glow
          Positioned(
            top: -50,
            left: 50,
            width: 280,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: -60,
            width: 240,
            height: 240,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiaryContainer.withOpacity(0.08),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildStatsStrip(),
                  const SizedBox(height: 12),
                  _buildFilterTabs(),
                  const SizedBox(height: 14),
                  _buildFusionsGrid(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () => widget.onNavigate(1),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.fusionButton,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cursedPurple.withValues(alpha: 0.6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
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
        GestureDetector(
          onTap: () => widget.onNavigate(0),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
          ),
        ),
        Column(
          children: [
            Text(
              'FUSION ARCHIVE',
              style: AppStyles.headlineSm(color: Colors.white).copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              '// SYNCHRONIZED VAULT',
              style: AppStyles.labelCyberSm(color: AppColors.primary),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 8),
            ],
          ),
          child: Text(
            '[ ${widget.savedFusions.length} FUSIONS ]',
            style: AppStyles.labelCyberSm(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsStrip() {
    int maxPower = widget.savedFusions.isEmpty
        ? 0
        : widget.savedFusions.map((f) => f.powerLevel).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text('REGISTRY', style: AppStyles.labelCyberSm(color: AppColors.outline)),
                const SizedBox(height: 2),
                Text('${widget.savedFusions.length} TOTAL', style: AppStyles.labelCyberMd(color: Colors.white)),
              ],
            ),
          ),
          Container(width: 1, height: 26, color: AppColors.outlineVariant.withOpacity(0.3)),
          Expanded(
            child: Column(
              children: [
                Text('MAX CURSED', style: AppStyles.labelCyberSm(color: AppColors.tertiaryContainer)),
                const SizedBox(height: 2),
                Text('$maxPower PWR', style: AppStyles.labelCyberMd(color: AppColors.tertiary)),
              ],
            ),
          ),
          Container(width: 1, height: 26, color: AppColors.outlineVariant.withOpacity(0.3)),
          Expanded(
            child: Column(
              children: [
                Text('AVG RATING', style: AppStyles.labelCyberSm(color: AppColors.primary)),
                const SizedBox(height: 2),
                Text('SPEC. GRADE', style: AppStyles.labelCyberMd(color: AppColors.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryContainer.withOpacity(0.2) : AppColors.surfaceContainerLow.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary.withOpacity(0.7) : AppColors.outlineVariant.withOpacity(0.4),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 10,
                        )
                      ]
                    : [],
              ),
              child: Text(
                filter,
                style: AppStyles.labelCyberSm(
                  color: isSelected ? AppColors.primary : AppColors.outline,
                ).copyWith(fontSize: 9),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFusionsGrid() {
    final list = filteredFusions;

    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(Icons.bookmark_border, size: 48, color: AppColors.outline),
            const SizedBox(height: 12),
            Text('No Fusions Found', style: AppStyles.headlineSm(color: AppColors.outline)),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.82,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return _buildFusionGridCard(item);
      },
    );
  }

  Widget _buildFusionGridCard(FusionCharacter item) {
    return GestureDetector(
      onTap: () {
        widget.onSelectFusion(item);
        widget.onNavigate(2); // Go to Result
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: item.primaryColor.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              color: item.primaryColor.withOpacity(0.25),
              blurRadius: 14,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image / Artwork header
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    if (item.imageUrl != null)
                      (item.imageUrl!.startsWith('assets/')
                          ? Image.asset(
                              item.imageUrl!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildFallbackGridIcon(item),
                            )
                          : Image.network(
                              item.imageUrl!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildFallbackGridIcon(item),
                            ))
                    else
                      _buildFallbackGridIcon(item),
                    // Scrim
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                              AppColors.surfaceContainerLow,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Rank badge
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: item.primaryColor.withOpacity(0.5)),
                        ),
                        child: Text(
                          item.rank == 'SPECIAL GRADE' ? 'SPEC. GRADE' : item.rank,
                          style: AppStyles.labelCyberSm(color: item.primaryColor).copyWith(fontSize: 7),
                        ),
                      ),
                    ),
                    // Star button
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(Icons.star, color: item.primaryColor, size: 12),
                      ),
                    ),
                  ],
                ),
              ),
              // Card Details
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: AppStyles.headlineSm(color: Colors.white).copyWith(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${item.jjkParent} × ${item.mcuParent}',
                            style: AppStyles.bodySm(color: AppColors.outline).copyWith(fontSize: 9),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PWR // ${item.powerLevel}',
                            style: AppStyles.labelCyberSm(color: AppColors.tertiaryContainer).copyWith(fontSize: 9),
                          ),
                          GestureDetector(
                            onTap: () => widget.onDeleteFusion(item.id),
                            child: const Icon(Icons.delete_outline, color: AppColors.outline, size: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackGridIcon(FusionCharacter item) {
    return Container(
      color: AppColors.surfaceContainerLowest,
      child: Center(
        child: Icon(item.avatarIcon, color: item.primaryColor, size: 40),
      ),
    );
  }
}

class RoundedRectangleWidget extends RoundedRectangleBorder {
  RoundedRectangleWidget() : super(borderRadius: BorderRadius.circular(16));
}
