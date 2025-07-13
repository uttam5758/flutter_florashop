import 'package:bagaicha_florashop/app/use_case/use_case.dart';
import 'package:bagaicha_florashop/core/error/failure.dart';
import 'package:bagaicha_florashop/feature/auth/domain/entity/user_entity.dart';
import 'package:bagaicha_florashop/feature/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required String username,
  });

  //intial constructor
  const RegisterUserParams.intial({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, phoneNumber, password];
}

class UserRegisterUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IuserRepository _userRepository;
  UserRegisterUsecase({required IuserRepository userReposiotry})
    : _userRepository = userReposiotry;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      username: params.name,
      email: params.email,
      phoneNumber: params.phoneNumber,
      password: params.password,
      confirmpassword: '',
      name: '',
    );
    return _userRepository.registerUser(userEntity);
  }
}
