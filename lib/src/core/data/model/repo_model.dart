import '../../domain/entity/repo.dart';

class RepoModel extends Repo {
  RepoModel({
    required super.name,
    required super.description,
    required super.stargazersCount,
    required super.htmlUrl,
    required super.updatedAt,

  });

  factory RepoModel.fromJson(Map<String, dynamic> map) {
    return RepoModel(
      name:  map['name'] ?? '',
      description:  map['name'] ?? '',
      stargazersCount:  map['stargazers_count'] ?? '',
      htmlUrl:  map['html_url'] ?? '',
      updatedAt:  DateTime.parse(map['updated_at']),
    );
  }
}