import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../constants/app_audio.dart';

enum AppMusicType {
  app,
  map,
  quiz,
  none,
}

class AudioController extends ChangeNotifier with WidgetsBindingObserver {
  AudioController._();

  static final AudioController instance = AudioController._();

  final AudioPlayer _introPlayer = AudioPlayer();
  final AudioPlayer _appMusicPlayer = AudioPlayer();
  final AudioPlayer _sceneMusicPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _stampPlayer = AudioPlayer();

  bool _isInitialized = false;
  bool _isMusicEnabled = true;
  bool _isSoundEnabled = true;
  bool _hasPlayedSplashIntro = false;
  bool _hasStartedAppBacksound = false;
  bool _hasStartedSceneMusic = false;

  AppMusicType _currentMusic = AppMusicType.none;
  String? _currentSceneAsset;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  AppMusicType get currentMusic => _currentMusic;

  Future<void> init() async {
    if (_isInitialized) return;

    WidgetsBinding.instance.addObserver(this);

    await _introPlayer.setReleaseMode(ReleaseMode.stop);
    await _appMusicPlayer.setReleaseMode(ReleaseMode.loop);
    await _sceneMusicPlayer.setReleaseMode(ReleaseMode.loop);
    await _effectPlayer.setReleaseMode(ReleaseMode.stop);
    await _stampPlayer.setReleaseMode(ReleaseMode.stop);

    await _introPlayer.setVolume(0.8);
    await _appMusicPlayer.setVolume(0.32);
    await _sceneMusicPlayer.setVolume(0.36);
    await _effectPlayer.setVolume(0.85);
    await _stampPlayer.setVolume(0.8);

    _isInitialized = true;
  }

  Future<void> playSplashUnderwaterOnce() async {
    if (!_isInitialized) {
      await init();
    }

    if (_hasPlayedSplashIntro) return;
    if (!_isSoundEnabled) return;

    _hasPlayedSplashIntro = true;

    await _introPlayer.stop();
    await _introPlayer.play(
      AssetSource(AppAudio.splashUnderwater),
    );
  }

  Future<void> playAppBacksound() async {
    if (!_isInitialized) {
      await init();
    }

    _currentMusic = AppMusicType.app;
    notifyListeners();

    if (!_isMusicEnabled) return;

    await _introPlayer.stop();

    await _sceneMusicPlayer.stop();
    _hasStartedSceneMusic = false;
    _currentSceneAsset = null;

    if (!_hasStartedAppBacksound) {
      _hasStartedAppBacksound = true;

      await _appMusicPlayer.setVolume(0.32);
      await _appMusicPlayer.play(
        AssetSource(AppAudio.appBacksound),
      );
      return;
    }

    await _appMusicPlayer.resume();
  }

  Future<void> playMapMusic() async {
    await _playSceneMusic(
      type: AppMusicType.map,
      asset: AppAudio.mapMusic,
      volume: 0.38,
    );
  }

  Future<void> playQuizMusic() async {
    await _playSceneMusic(
      type: AppMusicType.quiz,
      asset: AppAudio.quizMusic,
      volume: 0.36,
    );
  }

  Future<void> _playSceneMusic({
    required AppMusicType type,
    required String asset,
    required double volume,
  }) async {
    if (!_isInitialized) {
      await init();
    }

    final isSameScene = _currentMusic == type &&
        _currentSceneAsset == asset &&
        _hasStartedSceneMusic;

    _currentMusic = type;
    _currentSceneAsset = asset;
    notifyListeners();

    if (!_isMusicEnabled) return;

    await _introPlayer.stop();

    await _appMusicPlayer.pause();

    if (isSameScene) {
      await _sceneMusicPlayer.resume();
      return;
    }

    await _sceneMusicPlayer.stop();

    _hasStartedSceneMusic = true;

    await _sceneMusicPlayer.setVolume(volume);
    await _sceneMusicPlayer.play(
      AssetSource(asset),
    );
  }

  Future<void> pauseMusic() async {
    await _appMusicPlayer.pause();
    await _sceneMusicPlayer.pause();
  }

  Future<void> stopMusic() async {
    _currentMusic = AppMusicType.none;
    notifyListeners();

    await _appMusicPlayer.stop();
    await _sceneMusicPlayer.stop();

    _hasStartedAppBacksound = false;
    _hasStartedSceneMusic = false;
    _currentSceneAsset = null;
  }

  Future<void> setMusicEnabled(bool value) async {
    if (_isMusicEnabled == value) return;

    _isMusicEnabled = value;
    notifyListeners();

    if (!_isMusicEnabled) {
      await pauseMusic();
      return;
    }

    await _resumeCurrentMusic();
  }

  void setSoundEnabled(bool value) {
    if (_isSoundEnabled == value) return;

    _isSoundEnabled = value;
    notifyListeners();
  }

  Future<void> playStampSound() async {
    if (!_isInitialized) {
      await init();
    }

    if (!_isSoundEnabled) return;

    await _stampPlayer.stop();
    await _stampPlayer.play(
      AssetSource(AppAudio.stamp),
    );
  }

  Future<void> playPerfectStarSound() async {
    await _playEffect(AppAudio.star3);
  }

  Future<void> playNormalStarSound() async {
    await _playEffect(AppAudio.star012);
  }

  Future<void> _playEffect(String asset) async {
    if (!_isInitialized) {
      await init();
    }

    if (!_isSoundEnabled) return;

    await _effectPlayer.stop();
    await _effectPlayer.play(
      AssetSource(asset),
    );
  }

  Future<void> _resumeCurrentMusic() async {
    switch (_currentMusic) {
      case AppMusicType.app:
        await playAppBacksound();
        break;

      case AppMusicType.map:
        await playMapMusic();
        break;

      case AppMusicType.quiz:
        await playQuizMusic();
        break;

      case AppMusicType.none:
        await playAppBacksound();
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isInitialized) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      pauseMusic();
    }

    if (state == AppLifecycleState.resumed && _isMusicEnabled) {
      _resumeCurrentMusic();
    }
  }

  Future<void> disposeController() async {
    WidgetsBinding.instance.removeObserver(this);

    await _introPlayer.dispose();
    await _appMusicPlayer.dispose();
    await _sceneMusicPlayer.dispose();
    await _effectPlayer.dispose();
    await _stampPlayer.dispose();
  }
}
