import '../../domain/entities/diary_entry.dart';
import '../../domain/repositories/diary_repository.dart';
import '../datasources/diary_local_datasource.dart';
import '../models/diary_entry_model.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryLocalDatasource _datasource;

  DiaryRepositoryImpl(this._datasource);

  @override
  Future<List<DiaryEntry>> getAllEntries() => _datasource.getAllEntries();

  @override
  Future<DiaryEntry> createEntry(DiaryEntry entry) {
    final model = DiaryEntryModel.fromEntity(entry);
    return _datasource.insertEntry(model);
  }

  @override
  Future<void> deleteEntry(int id) => _datasource.deleteEntry(id);
}
