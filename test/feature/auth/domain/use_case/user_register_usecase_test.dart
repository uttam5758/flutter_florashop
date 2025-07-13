import 'package:bagaicha_florashop/core/error/failure.dart';
import 'package:bagaicha_florashop/feature/auth/domain/entity/user_entity.dart';
import 'package:bagaicha_florashop/feature/auth/domain/repository/user_repository.dart';
import 'package:bagaicha_florashop/feature/auth/domain/use_case/user_register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class
class MockUserRepository extends Mock implements IuserRepository {}

void main() {
  late MockUserRepository repository;
  late UserRegisterUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = UserRegisterUsecase(userReposiotry: repository);

    // Register fallback for UserEntity used internally in the use case
    registerFallbackValue(UserEntity.empty());
  });

  final params = const RegisterUserParams.intial(
    name: 'Test User',
    email: 'test@email.com',
    password: 'securepassword',
    phoneNumber: '9815524624',
  );

  final expectedUserEntity = UserEntity(
    username: params.name,
    email: params.email,
    phoneNumber: params.phoneNumber,
    password: params.password,
    confirmpassword: '',
    name: '',
  );

  test('should call registerUser and return Right(null)', () async {
    // Arrange
    when(
      () => repository.registerUser(any()),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right<Failure, void>(null));
    verify(() => repository.registerUser(expectedUserEntity)).called(1);
  });
}
