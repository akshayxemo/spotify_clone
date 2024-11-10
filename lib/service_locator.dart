import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_clone/data/soruces/auth/auth_firebase_service.dart';
import 'package:spotify_clone/domain/repository/auth/auth.dart';
import 'package:spotify_clone/domain/usecases/auth/signin.dart';
import 'package:spotify_clone/domain/usecases/auth/signup.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );
  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
  serviceLocator.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );
  serviceLocator.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );
}
