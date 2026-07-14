import 'biota_model.dart';

class IslandCheckpointModel {
  final String id;
  final String islandId;
  final String title;
  final String bannerImage;
  final String progressTitle;
  final double progress;
  final List<BiotaModel> biotas;
  final String checkpointCode;
  final String scanButtonText;
  final String manualInputLabel;
  final String manualCodeHint;
  final String infoText;
  final String detailSubtitle;
  final String theme;
  final String reward;
  final String quizButtonText;

  const IslandCheckpointModel({
    required this.id,
    required this.islandId,
    required this.title,
    required this.bannerImage,
    required this.progressTitle,
    required this.progress,
    required this.biotas,
    required this.checkpointCode,
    this.scanButtonText = 'Scan QR',
    this.manualInputLabel = 'atau masukkan kode manual',
    this.manualCodeHint = '',
    this.infoText =
        'Scan QR dari panel edukatif atau masukkan kode manual jika scan gagal',
    this.detailSubtitle = 'Yuk, pelajari ketiga biota sebelum memulai kuis!',
    this.theme = '',
    this.reward = '',
    this.quizButtonText = 'Mulai Quiz',
  });

  int get totalBiota {
    return biotas.length;
  }

  int get learnedBiota {
    return biotas.where((biota) => biota.isLearned).length;
  }

  int get progressPercentage {
    return (progress.clamp(0.0, 1.0) * 100).round();
  }

  String get progressText {
    return '$progressPercentage%';
  }

  String get biotaSectionTitle {
    return '$totalBiota Biota Khas';
  }

  bool get isCompleted {
    return progressPercentage >= 100;
  }

  factory IslandCheckpointModel.fromJson(Map<String, dynamic> json) {
    final rawBiotas = json['biotas'];

    final biotas = rawBiotas is List
        ? rawBiotas.map((item) {
            return BiotaModel.fromJson(
              Map<String, dynamic>.from(item),
            );
          }).toList()
        : <BiotaModel>[];

    return IslandCheckpointModel(
      id: json['id']?.toString() ?? '',
      islandId:
          json['islandId']?.toString() ?? json['island_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      bannerImage: (json['bannerImage']?.toString() ??
          json['banner_image']?.toString() ??
          '').trim().replaceAll('"', ''),
      progressTitle: json['progressTitle']?.toString() ??
          json['progress_title']?.toString() ??
          'Progress Pulau',
      progress: _parseProgress(
        progress: json['progress'],
        progressPercentage:
            json['progressPercentage'] ?? json['progress_percentage'],
        biotas: biotas,
      ),
      biotas: biotas,
      checkpointCode: json['checkpointCode']?.toString() ??
          json['checkpoint_code']?.toString() ??
          json['qrCode']?.toString() ??
          json['qr_code']?.toString() ??
          '',
      scanButtonText: json['scanButtonText']?.toString() ??
          json['scan_button_text']?.toString() ??
          'Scan QR',
      manualInputLabel: json['manualInputLabel']?.toString() ??
          json['manual_input_label']?.toString() ??
          'atau masukkan kode manual',
      manualCodeHint: json['manualCodeHint']?.toString() ??
          json['manual_code_hint']?.toString() ??
          '',
      infoText: json['infoText']?.toString() ??
          json['info_text']?.toString() ??
          'Scan QR dari panel edukatif atau masukkan kode manual jika scan gagal',
      detailSubtitle: json['detailSubtitle']?.toString() ??
          json['detail_subtitle']?.toString() ??
          'Yuk, pelajari ketiga biota sebelum memulai kuis!',
      theme: json['theme']?.toString() ?? json['tema']?.toString() ?? '',
      reward: json['reward']?.toString() ?? '',
      quizButtonText: json['quizButtonText']?.toString() ??
          json['quiz_button_text']?.toString() ??
          'Mulai Quiz',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'islandId': islandId,
      'title': title,
      'bannerImage': bannerImage,
      'progressTitle': progressTitle,
      'progress': progress,
      'progressPercentage': progressPercentage,
      'biotas': biotas.map((biota) => biota.toJson()).toList(),
      'checkpointCode': checkpointCode,
      'scanButtonText': scanButtonText,
      'manualInputLabel': manualInputLabel,
      'manualCodeHint': manualCodeHint,
      'infoText': infoText,
      'detailSubtitle': detailSubtitle,
      'theme': theme,
      'reward': reward,
      'quizButtonText': quizButtonText,
    };
  }

  IslandCheckpointModel copyWith({
    String? id,
    String? islandId,
    String? title,
    String? bannerImage,
    String? progressTitle,
    double? progress,
    List<BiotaModel>? biotas,
    String? checkpointCode,
    String? scanButtonText,
    String? manualInputLabel,
    String? manualCodeHint,
    String? infoText,
    String? detailSubtitle,
    String? theme,
    String? reward,
    String? quizButtonText,
  }) {
    return IslandCheckpointModel(
      id: id ?? this.id,
      islandId: islandId ?? this.islandId,
      title: title ?? this.title,
      bannerImage: bannerImage ?? this.bannerImage,
      progressTitle: progressTitle ?? this.progressTitle,
      progress: progress ?? this.progress,
      biotas: biotas ?? this.biotas,
      checkpointCode: checkpointCode ?? this.checkpointCode,
      scanButtonText: scanButtonText ?? this.scanButtonText,
      manualInputLabel: manualInputLabel ?? this.manualInputLabel,
      manualCodeHint: manualCodeHint ?? this.manualCodeHint,
      infoText: infoText ?? this.infoText,
      detailSubtitle: detailSubtitle ?? this.detailSubtitle,
      theme: theme ?? this.theme,
      reward: reward ?? this.reward,
      quizButtonText: quizButtonText ?? this.quizButtonText,
    );
  }

  static double _parseProgress({
    required dynamic progress,
    required dynamic progressPercentage,
    required List<BiotaModel> biotas,
  }) {
    final parsedProgress = _asDouble(progress);

    if (parsedProgress != null) {
      return _normalizeProgress(parsedProgress);
    }

    final parsedPercentage = _asDouble(progressPercentage);

    if (parsedPercentage != null) {
      return _normalizeProgress(parsedPercentage);
    }

    if (biotas.isEmpty) {
      return 0;
    }

    final learnedCount = biotas.where((biota) => biota.isLearned).length;

    return learnedCount / biotas.length;
  }

  static double _normalizeProgress(double value) {
    if (value > 1) {
      return (value / 100).clamp(0.0, 1.0);
    }

    return value.clamp(0.0, 1.0);
  }

  static double? _asDouble(dynamic value) {
    if (value == null) return null;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    if (value is num) return value.toDouble();

    if (value is String) {
      final cleanedValue = value.replaceAll('%', '').trim();

      return double.tryParse(cleanedValue);
    }

    return null;
  }
}
