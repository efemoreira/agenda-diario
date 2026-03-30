import '../entities/diary_entry.dart';
import '../repositories/diary_repository.dart';

class GetAllEntries {
  final DiaryRepository _repository;

  GetAllEntries(this._repository);

  Future<List<DiaryEntry>> call() => _repository.getAllEntries();
}
