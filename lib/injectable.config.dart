// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:testrickmortyapp/injectable_singleton_module.dart' as _i18;
import 'package:testrickmortyapp/layers/core/api/api.dart' as _i6;
import 'package:testrickmortyapp/layers/core/api/api_consumer.dart' as _i3;
import 'package:testrickmortyapp/layers/core/api/dio_consumer.dart' as _i4;
import 'package:testrickmortyapp/layers/data/character_repository_impl.dart'
    as _i12;
import 'package:testrickmortyapp/layers/data/episode_repository_impl.dart'
    as _i14;
import 'package:testrickmortyapp/layers/data/source/local/local_character_storage.dart'
    as _i9;
import 'package:testrickmortyapp/layers/data/source/local/local_episodes_storage.dart'
    as _i10;
import 'package:testrickmortyapp/layers/data/source/network/remote_character_repository.dart'
    as _i5;
import 'package:testrickmortyapp/layers/data/source/network/remote_episode_repository.dart'
    as _i7;
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart'
    as _i11;
import 'package:testrickmortyapp/layers/domain/repository/episode_repository.dart'
    as _i13;
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart'
    as _i15;
import 'package:testrickmortyapp/layers/domain/usecase/get_all_episodes.dart'
    as _i16;
import 'package:testrickmortyapp/layers/domain/usecase/get_characters_by_id.dart'
    as _i17;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i3.ApiConsumer>(() => _i4.DioConsumer());
    gh.lazySingleton<_i5.RemoteCharacterRepository>(() =>
        _i5.RemoteCharacterRepositoryImpl(apiConsumer: gh<_i6.ApiConsumer>()));
    gh.lazySingleton<_i7.RemoteEpisodeRepository>(() =>
        _i7.RemoteEpisodeRepositoryImpl(apiConsumer: gh<_i6.ApiConsumer>()));
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i9.LocalCharacterStorage>(() =>
        _i9.LocalStorageImpl(sharedPreferences: gh<_i8.SharedPreferences>()));
    gh.lazySingleton<_i10.LocalEpisodeStorage>(() =>
        _i10.LocalEpisodesStorageImpl(
            sharedPreferences: gh<_i8.SharedPreferences>()));
    gh.lazySingleton<_i11.CharacterRepository>(
        () => _i12.CharacterRepositoryImpl(
              remoteCharacterRepository: gh<_i5.RemoteCharacterRepository>(),
              localCharacterStorage: gh<_i9.LocalCharacterStorage>(),
            ));
    gh.lazySingleton<_i13.EpisodeRepository>(() => _i14.EpisodeRepositoryImpl(
          remoteEpisodeRepository: gh<_i7.RemoteEpisodeRepository>(),
          localEpisodeStorage: gh<_i10.LocalEpisodeStorage>(),
        ));
    gh.lazySingleton<_i15.GetAllCharacters>(() =>
        _i15.GetAllCharacters(repository: gh<_i11.CharacterRepository>()));
    gh.lazySingleton<_i16.GetAllEpisodes>(
        () => _i16.GetAllEpisodes(repository: gh<_i13.EpisodeRepository>()));
    gh.lazySingleton<_i17.GetCharactersByIDs>(() =>
        _i17.GetCharactersByIDs(repository: gh<_i11.CharacterRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i18.InjectionModule {}
