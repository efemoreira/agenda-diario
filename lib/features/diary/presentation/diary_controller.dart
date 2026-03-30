import 'package:flutter/material.dart';

import '../domain/entities/diary_entry.dart';
import '../domain/usecases/create_entry.dart';
import '../domain/usecases/delete_entry.dart';
import '../domain/usecases/get_all_entries.dart';

enum DiaryStatus { idle, loading, success, error }

class DiaryController extends ChangeNotifier {
  final GetAllEntries _getAllEntries;
  final CreateEntry _createEntry;
  final DeleteEntry _deleteEntry;

  DiaryController({
    required GetAllEntries getAllEntries,
    required CreateEntry createEntry,
    required DeleteEntry deleteEntry,
  })  : _getAllEntries = getAllEntries,
        _createEntry = createEntry,
        _deleteEntry = deleteEntry;

  List<DiaryEntry> _entries = [];
  DiaryStatus _status = DiaryStatus.idle;
  String? _errorMessage;

  List<DiaryEntry> get entries => List.unmodifiable(_entries);
  DiaryStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == DiaryStatus.loading;

  Future<void> loadEntries() async {
    _status = DiaryStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      _entries = await _getAllEntries();
      _status = DiaryStatus.success;
    } catch (e) {
      _status = DiaryStatus.error;
      _errorMessage = 'Não foi possível carregar as entradas.';
    }
    notifyListeners();
  }

  Future<DiaryEntry?> addEntry({
    String? title,
    required String content,
  }) async {
    try {
      final entry = DiaryEntry(
        title: title?.trim().isEmpty == true ? null : title?.trim(),
        content: content.trim(),
        createdAt: DateTime.now(),
      );
      final saved = await _createEntry(entry);
      _entries.insert(0, saved);
      notifyListeners();
      return saved;
    } catch (_) {
      return null;
    }
  }

  Future<bool> removeEntry(int id) async {
    try {
      await _deleteEntry(id);
      _entries.removeWhere((e) => e.id == id);
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }
}
