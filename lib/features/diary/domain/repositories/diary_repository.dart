import '../entities/diary_entry.dart';

abstract class DiaryRepository {
  Future<List<DiaryEntry>> getAllEntries();
  Future<DiaryEntry> createEntry(DiaryEntry entry);
  Future<void> deleteEntry(int id);
}
