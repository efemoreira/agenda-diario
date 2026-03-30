import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'diary_controller.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final ctrl = context.read<DiaryController>();
    final entry = await ctrl.addEntry(
      title: _titleCtrl.text,
      content: _contentCtrl.text,
    );

    if (!mounted) return;
    setState(() => _saving = false);

    if (entry != null) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova entrada'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Salvar'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Título (opcional)',
                hintText: 'Ex.: Reflexão do dia',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 80,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentCtrl,
              decoration: const InputDecoration(
                labelText: 'Conteúdo',
                hintText: 'Escreva o que você está pensando...',
                alignLabelWithHint: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              minLines: 8,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'O conteúdo não pode estar vazio.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
