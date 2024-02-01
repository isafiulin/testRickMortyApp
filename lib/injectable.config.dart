// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:testrickmortyapp/injectable_singleton_module.dart' as _i12;
import 'package:testrickmortyapp/layers/core/api/api.dart' as _i6;
import 'package:testrickmortyapp/layers/core/api/api_consumer.dart' as _i3;
import 'package:testrickmortyapp/layers/core/api/dio_consumer.dart' as _i4;
import 'package:testrickmortyapp/layers/data/character_repository_impl.dart'
    as _i10;
import 'package:testrickmortyapp/layers/data/source/local/local_character_storage.dart'
    as _i8;
import 'package:testrickmortyapp/layers/data/source/network/remote_character_repository.dart'
    as _i5;
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart'
    as _i9;
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart'
    as _i11;

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
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i8.LocalCharacterStorage>(() =>
        _i8.LocalStorageImpl(sharedPreferences: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i9.CharacterRepository>(
        () => _i10.CharacterRepositoryImpl(
              remoteCharacterRepository: gh<_i5.RemoteCharacterRepository>(),
              localCharacterStorage: gh<_i8.LocalCharacterStorage>(),
            ));
    gh.lazySingleton<_i11.GetAllCharacters>(
        () => _i11.GetAllCharacters(repository: gh<_i9.CharacterRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i12.InjectionModule {}
