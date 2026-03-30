import '../entities/diary_entry.dart';
import '../repositories/diary_repository.dart';

class CreateEntry {
  final DiaryRepository _repository;

  CreateEntry(this._repository);

  Future<DiaryEntry> call(DiaryEntry entry) => _repository.createEntry(entry);
}
