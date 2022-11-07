import 'package:firstapp/services/auth/auth_service.dart';
import 'package:firstapp/utilities/dialog/cannot_share_empty_dialog.dart';
import 'package:firstapp/utilities/generics/get_arguments.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/cloud/cloud_note.dart';
import 'package:firstapp/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});
  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _noteService;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    _textEditingController = TextEditingController();
    super.initState();
  }

  void _textControllerListner() async {
    final note = _note;

    if (note == null) {
      return;
    }
    final text = _textEditingController.text;
    await _noteService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  void _setupTextControllerListner() {
    _textEditingController.removeListener(_textControllerListner);
    _textEditingController.addListener(_textControllerListner);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textEditingController.text = widgetNote.text;
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }

    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _noteService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textEditingController.text.isEmpty && note != null) {
      _noteService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfNotEmpty() async {
    final note = _note;
    final text = _textEditingController.text;

    if (note != null && text.isNotEmpty) {
      await _noteService.updateNote(
        documentId: note.documentId,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfNotEmpty();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        actions: [
          IconButton(
            onPressed: () async {
              final text = _textEditingController.text;
              if (_note == null || text.isEmpty) {
                await showCannotShareEmptyNoteDilog(context);
              } else {
                Share.share(text);
              }
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListner();
              return TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Start typing your notes Here'),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
