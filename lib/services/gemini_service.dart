import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/fusion_model.dart';
import '../theme/app_theme.dart';
import '../config/api_config.dart';

class GeminiFusionService {
  static const String _apiKey = ApiConfig.geminiApiKey;


  // Candidate models to attempt in order
  static const List<String> _candidateModels = [
    'gemini-3.5-flash',
    'gemini-2.5-flash',
    'gemini-3.8-flash',
    'gemini-3.7-flash',
    'gemini-flash-latest',
    'gemini-3.5-flash-lite',
  ];

  static Future<FusionCharacter> generateFusion({
    required Character mcuCharacter,
    required Character jjkCharacter,
  }) async {
    final String prompt = '''
You are the master cosmic synthesis engine for "MCU × JJK Fusion", an anime-superhero crossover multiverse.
Create a unique, creative, high-octane hybrid character fusing:
- MCU Warrior: ${mcuCharacter.name} (${mcuCharacter.titleTag})
- Jujutsu Kaisen Sorcerer: ${jjkCharacter.name} (${jjkCharacter.titleTag})

Provide the character details as a JSON object matching this schema:
{
  "name": "THE [CREATIVE AND IMPACTFUL FUSION NAME IN ALL CAPS]",
  "powerLevel": [integer between 7500 and 9999],
  "rank": "SPECIAL GRADE",
  "domainExpansion": "DOMAIN EXPANSION: [SIGNATURE CURSED TECHNIQUE DOMAIN NAME]",
  "domainDescription": "[Vivid 2-3 sentence description of their domain expansion combining cursed energy with MCU physics/sorcery]",
  "mcuPowersName": "[MCU ABILITY MATRIX TITLE IN ALL CAPS]",
  "mcuPowerTags": ["[TAG 1 IN CAPS]", "[TAG 2 IN CAPS]", "[TAG 3 IN CAPS]"],
  "mcuPowersDescription": "[Detailed explanation of how their MCU powers/relics/tech operate]",
  "originStory": "[A dramatic, cinematic 3-4 sentence narrative explaining how the Marvel multiverse and Jujutsu occult realm collided to forge this being]",
  "abilities": [
    {"name": "[SHORT UPPERCASE ABILITY NAME 1]", "description": "[Short tactical description]"},
    {"name": "[SHORT UPPERCASE ABILITY NAME 2]", "description": "[Short tactical description]"},
    {"name": "[SHORT UPPERCASE ABILITY NAME 3]", "description": "[Short tactical description]"},
    {"name": "[SHORT UPPERCASE ABILITY NAME 4]", "description": "[Short tactical description]"},
    {"name": "[SHORT UPPERCASE ABILITY NAME 5]", "description": "[Short tactical description]"},
    {"name": "[SHORT UPPERCASE ABILITY NAME 6]", "description": "[Short tactical description]"}
  ]
}
''';

    Map<String, dynamic>? parsedData;
    String lastErrorMessage = '';

    // Attempt through candidate models
    for (final model in _candidateModels) {
      try {
        final Uri url = Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$_apiKey',
        );

        final response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'contents': [
                  {
                    'parts': [
                      {'text': prompt}
                    ]
                  }
                ],
                'generationConfig': {
                  'responseMimeType': 'application/json',
                  'temperature': 0.8,
                }
              }),
            )
            .timeout(const Duration(seconds: 12));

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseJson = jsonDecode(response.body);
          final String? textContent = responseJson['candidates']?[0]?['content']
              ?['parts']?[0]?['text'];

          if (textContent != null && textContent.isNotEmpty) {
            parsedData = jsonDecode(textContent);
            break; // Success!
          }
        } else {
          lastErrorMessage = 'Model $model returned HTTP ${response.statusCode}';
        }
      } catch (e) {
        lastErrorMessage = e.toString();
        // Continue to next candidate model
      }
    }

    // If all models failed or timed out, synthesize dynamically with the occult algorithmic engine
    if (parsedData == null) {
      parsedData = _synthesizeLocalFallback(
        mcu: mcuCharacter,
        jjk: jjkCharacter,
      );
    }

    return _buildFusionObject(
      data: parsedData,
      mcuCharacter: mcuCharacter,
      jjkCharacter: jjkCharacter,
    );
  }

  static FusionCharacter _buildFusionObject({
    required Map<String, dynamic> data,
    required Character mcuCharacter,
    required Character jjkCharacter,
  }) {
    final List<dynamic> abilitiesRaw = data['abilities'] ?? [];
    final List<Color> abilityColors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.cursedPurple,
      AppColors.iceBlue,
      AppColors.tertiaryContainer,
      AppColors.crimsonSlash,
    ];

    final List<IconData> abilityIcons = [
      Icons.visibility,
      Icons.layers,
      Icons.remove_red_eye,
      Icons.auto_awesome,
      Icons.favorite,
      Icons.change_circle,
      Icons.flash_on,
      Icons.sports_mma,
    ];

    final List<FusionAbility> abilities = [];
    for (int i = 0; i < abilitiesRaw.length; i++) {
      final ab = abilitiesRaw[i];
      abilities.add(
        FusionAbility(
          name: ab['name']?.toString().toUpperCase() ?? 'TECHNIQUE // ${i + 1}',
          description: ab['description']?.toString() ?? 'Occult Combat Effect',
          icon: abilityIcons[i % abilityIcons.length],
          color: abilityColors[i % abilityColors.length],
        ),
      );
    }

    Color primaryColor = jjkCharacter.themeColor;
    if (primaryColor == Colors.transparent) {
      primaryColor = AppColors.cursedPurple;
    }

    // Automatically resolve corresponding high-res Stitch anime fusion artwork:
    String? imageUrl;
    final mcuId = mcuCharacter.id.toLowerCase();
    final jjkId = jjkCharacter.id.toLowerCase();

    if ((mcuId.contains('strange') && jjkId.contains('gojo')) ||
        (mcuId.contains('gojo') && jjkId.contains('strange'))) {
      imageUrl = 'assets/images/infinite_sorcerer.jpg';
    } else if (mcuId.contains('panther') || mcuId.contains('strange') && jjkId.contains('megumi')) {
      imageUrl = 'assets/images/thunder_shadow.jpg';
    } else if (mcuId.contains('spiderman') || jjkId.contains('yuji')) {
      imageUrl = 'assets/images/cursed_web.jpg';
    } else if (mcuId.contains('thor') || jjkId.contains('megumi')) {
      imageUrl = 'assets/images/thunder_shadow.jpg';
    } else if (jjkId.contains('sukuna')) {
      imageUrl = 'assets/images/cursed_titan.jpg';
    } else if (jjkId.contains('toji')) {
      imageUrl = 'assets/images/heavenly_hunter.jpg';
    } else if (jjkId.contains('nobara') || mcuId.contains('marvel')) {
      imageUrl = 'assets/images/binary_resonance.jpg';
    } else if (mcuId.contains('ironman')) {
      imageUrl = 'assets/images/boogie_tech.jpg';
    } else {
      // Intelligently cycle among the 8 high-res anime artworks
      final allImages = [
        'assets/images/infinite_sorcerer.jpg',
        'assets/images/cursed_titan.jpg',
        'assets/images/cursed_web.jpg',
        'assets/images/heavenly_hunter.jpg',
        'assets/images/thunder_shadow.jpg',
        'assets/images/crimson_chaos.jpg',
        'assets/images/boogie_tech.jpg',
        'assets/images/binary_resonance.jpg',
      ];
      final hash = (mcuCharacter.name.length * 7 + jjkCharacter.name.length * 13) % allImages.length;
      imageUrl = allImages[hash];
    }

    return FusionCharacter(
      id: id,
      name: data['name']?.toString().toUpperCase() ??
          'THE ${mcuCharacter.name} × ${jjkCharacter.name}',
      mcuParent: mcuCharacter.name,
      jjkParent: jjkCharacter.name,
      powerLevel: (data['powerLevel'] is int)
          ? data['powerLevel']
          : int.tryParse(data['powerLevel']?.toString() ?? '9500') ?? 9500,
      rank: data['rank']?.toString().toUpperCase() ?? 'SPECIAL GRADE',
      domainExpansion: data['domainExpansion']?.toString().toUpperCase() ??
          'DOMAIN EXPANSION: INFINITE SYNTHESIS',
      domainDescription: data['domainDescription']?.toString() ??
          'A catastrophic convergence of reality manipulation and cursed territory.',
      mcuPowersName: data['mcuPowersName']?.toString().toUpperCase() ??
          'COSMIC TECH MATRIX',
      mcuPowerTags: (data['mcuPowerTags'] as List<dynamic>?)
              ?.map((e) => e.toString().toUpperCase())
              .toList() ??
          ['QUANTUM MATRIX', 'ENERGY HARNESS', 'DIMENSIONAL BREACH'],
      mcuPowersDescription: data['mcuPowersDescription']?.toString() ??
          'Harnesses the multiversal quantum spectrum to amplify combat efficiency.',
      originStory: data['originStory']?.toString() ??
          'Born at the epicenter where timelines fractured and cursed energy surged across dimensions.',
      abilities: abilities.isNotEmpty
          ? abilities
          : [
              const FusionAbility(
                name: 'COSMIC STRIKE',
                description: 'Physical & energy strike',
                icon: Icons.electric_bolt,
                color: AppColors.secondary,
              ),
              const FusionAbility(
                name: 'CURSED REVERSAL',
                description: 'Nullifies incoming techniques',
                icon: Icons.visibility,
                color: AppColors.cursedPurple,
              ),
            ],
      primaryColor: primaryColor,
      avatarIcon: jjkCharacter.icon,
      imageUrl: imageUrl,
    );
  }

  static Map<String, dynamic> _synthesizeLocalFallback({
    required Character mcu,
    required Character jjk,
  }) {
    final rand = Random();
    final power = 8500 + rand.nextInt(1490);

    return {
      'name': 'THE ${mcu.name.split(' ').first} × ${jjk.name.split(' ').first} PROTOCOL',
      'powerLevel': power,
      'rank': power > 9500 ? 'SPECIAL GRADE' : 'RANK S',
      'domainExpansion': 'DOMAIN EXPANSION: ${jjk.titleTag} // ${mcu.titleTag}',
      'domainDescription':
          'Synthesizes the boundless cursed realm of ${jjk.name} with the quantum battle matrices of ${mcu.name}. Within this territory, attacks are multiplied through infinite multiversal loops.',
      'mcuPowersName': '${mcu.name} OMNI-REACTION MATRIX',
      'mcuPowerTags': [
        '${mcu.titleTag}',
        'QUANTUM INFUSION',
        'CELESTIAL HARNESS'
      ],
      'mcuPowersDescription':
          'Adapts ${mcu.name}\'s combat arsenal with refined cursed energy vectors.',
      'originStory':
          'When ${mcu.name}\'s reality breached the barriers of Jujutsu High, an unprecedented occult synthesis occurred, merging the spirit of ${jjk.name} with the cosmic essence of ${mcu.name}.',
      'abilities': [
        {
          'name': '${mcu.titleTag} STRIKE',
          'description': 'Devastating kinetic impact',
        },
        {
          'name': '${jjk.titleTag} CLEAVE',
          'description': 'Dimensional spatial slice',
        },
        {
          'name': 'CURSED REPULSOR',
          'description': 'Concentrated cursed plasma',
        },
        {
          'name': 'INFINITY BARRIER',
          'description': 'Impenetrable spatial shield',
        },
        {
          'name': 'BLACK FLASH SURGE',
          'description': 'Instant critical shockwave',
        },
        {
          'name': 'REVERSE HEALING',
          'description': 'Cellular matrix restoration',
        },
      ],
    };
  }
}
