import '../core/constants/app_images.dart';
import '../models/profile_avatar_model.dart';

class ProfileAvatarData {
  ProfileAvatarData._();

  static const String defaultAvatar = AppImages.avatarCrab;

  static const List<ProfileAvatarModel> avatars = [
    ProfileAvatarModel(
      id: 'dolphin',
      name: 'Dolphin',
      image: AppImages.avatarDolphin,
    ),
    ProfileAvatarModel(
      id: 'clownfish',
      name: 'Clownfish',
      image: AppImages.avatarClownfish,
    ),
    ProfileAvatarModel(
      id: 'turtle',
      name: 'Turtle',
      image: AppImages.avatarTurtle,
    ),
    ProfileAvatarModel(
      id: 'whale',
      name: 'Whale',
      image: AppImages.avatarWhale,
    ),
    ProfileAvatarModel(
      id: 'octopus',
      name: 'Octopus',
      image: AppImages.avatarOctopus,
    ),
    ProfileAvatarModel(
      id: 'jellyfish',
      name: 'Jellyfish',
      image: AppImages.avatarJellyfish,
    ),
    ProfileAvatarModel(
      id: 'starfish',
      name: 'Starfish',
      image: AppImages.avatarStarfish,
    ),
    ProfileAvatarModel(
      id: 'crab',
      name: 'Crab',
      image: AppImages.avatarCrab,
    ),
    ProfileAvatarModel(
      id: 'blue_fish',
      name: 'Blue Fish',
      image: AppImages.avatarBlueFish,
    ),
  ];
}