import '../core/constants/app_images.dart';
import '../models/biota_model.dart';
import '../models/island_checkpoint_model.dart';

class CheckpointData {
  CheckpointData._();

  static List<IslandCheckpointModel> checkpoints = [
    nttCheckpoint,
  ];

  static IslandCheckpointModel nttCheckpoint = IslandCheckpointModel(
    id: 'checkpoint_ntt',
    islandId: 'ntt',
    title: 'Biota Pulau NTT',
    bannerImage: AppImages.checkpointNttBanner,
    progressTitle: 'Progress Pulau',
    progress: 1.0,
    checkpointCode: 'QR_NTT_001',
    manualCodeHint: '',
    detailSubtitle: 'Yuk, pelajari ketiga biota sebelum memulai kuis!',
    theme: 'Kawasan laut Komodo, karang, dan wisata bahari bertanggung jawab',
    reward: 'Stamp NTT',
    quizButtonText: 'Mulai Quiz',
    biotas: nttBiotas,
  );

  static List<BiotaModel> nttBiotas = [
    const BiotaModel(
      id: 'biota_ntt_001',
      islandId: 'ntt',
      name: 'Komodo Damselfish',
      scientificName: 'Pomacentrus komodoensis',
      image: AppImages.biotaKomodoDamselfish,
      summary:
          'Komodo Damselfish adalah ikan karang kecil yang hidup di perairan sekitar Pulau Komodo, Indonesia. Ikan ini banyak ditemukan di perairan dangkal yang berbatu dan dekat tempat berlindung.',
      habitat:
          'Habitat Komodo Damselfish berada di perairan dangkal, terumbu karang, dan area pesisir yang memiliki banyak celah untuk berlindung.',
      threat:
          'Ancaman utama biota ini adalah kerusakan terumbu karang, pencemaran laut, dan perubahan kualitas habitat pesisir.',
      funFact:
          'Walaupun ukurannya kecil, Komodo Damselfish berperan penting dalam menjaga keseimbangan ekosistem karang.',
      food:
          'Makanan Komodo Damselfish berupa plankton kecil, organisme mikro, dan partikel makanan yang berada di sekitar terumbu karang.',
      videoUrl: 'https://youtu.be/5mkVld0FpvQ?si=10yk7Mzh_Pu2Y6hb',
      isLearned: true,
      order: 1,
    ),
    const BiotaModel(
      id: 'biota_ntt_002',
      islandId: 'ntt',
      name: 'Rennya’s Flasher Wrasse',
      scientificName: 'Paracheilinus rennyae',
      image: AppImages.biotaRennyaFlasherWrasse,
      summary:
          'Rennya’s Flasher Wrasse adalah ikan kecil berwarna cerah yang hidup di kawasan terumbu karang. Warna tubuhnya yang mencolok membuatnya mudah dikenali.',
      habitat:
          'Biota ini hidup di sekitar terumbu karang tropis, terutama pada area yang memiliki arus tenang dan banyak tempat bersembunyi.',
      threat:
          'Ancaman terhadap Rennya’s Flasher Wrasse meliputi kerusakan habitat karang, penangkapan ikan hias berlebihan, dan pencemaran laut.',
      funFact:
          'Ikan ini dikenal karena warna tubuhnya yang menarik dan gerakan siripnya yang tampak seperti sedang memamerkan diri.',
      food:
          'Makanan utamanya adalah zooplankton dan organisme kecil yang melayang di kolom air.',
      videoUrl: '',
      isLearned: true,
      order: 2,
    ),
    const BiotaModel(
      id: 'biota_ntt_003',
      islandId: 'ntt',
      name: 'Greentail Triplefin',
      scientificName: 'Enneapterygius viridicauda',
      image: AppImages.biotaGreentailTriplefin,
      summary:
          'Greentail Triplefin adalah ikan kecil yang hidup di area karang dan bebatuan laut. Tubuhnya membantu ikan ini berkamuflase di lingkungan sekitarnya.',
      habitat:
          'Habitat Greentail Triplefin berada di perairan dangkal, sela-sela batu karang, dan area terumbu yang kaya perlindungan.',
      threat:
          'Ancaman utama biota ini adalah degradasi habitat, sedimentasi, pencemaran laut, dan rusaknya ekosistem terumbu karang.',
      funFact:
          'Nama triplefin berasal dari ciri sirip punggungnya yang terbagi menjadi tiga bagian.',
      food:
          'Greentail Triplefin memakan organisme kecil seperti krustasea mikro dan plankton yang hidup di sekitar karang.',
      videoUrl: '',
      isLearned: true,
      order: 3,
    ),
  ];

  static IslandCheckpointModel? findCheckpointByIslandId(String islandId) {
    final normalizedIslandId = islandId.trim().toLowerCase();

    for (final checkpoint in checkpoints) {
      if (checkpoint.islandId.trim().toLowerCase() == normalizedIslandId) {
        return checkpoint;
      }
    }

    return null;
  }

  static IslandCheckpointModel getCheckpointByIslandId(String islandId) {
    final checkpoint = findCheckpointByIslandId(islandId);

    if (checkpoint == null) {
      throw StateError('Checkpoint untuk $islandId belum tersedia');
    }

    return checkpoint;
  }

  static void resetForGuest() {
    nttBiotas = nttBiotas.map((biota) => biota.copyWith(isLearned: false)).toList();
    nttCheckpoint = nttCheckpoint.copyWith(progress: 0.0, biotas: nttBiotas);
    checkpoints = [nttCheckpoint];
  }
}
