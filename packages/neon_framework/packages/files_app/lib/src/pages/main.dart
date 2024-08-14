import 'dart:async';

import 'package:files_app/l10n/localizations.dart';
import 'package:files_app/src/blocs/files.dart';
import 'package:files_app/src/utils/dialog.dart';
import 'package:files_app/src/widgets/browser_view.dart';
import 'package:flutter/material.dart';
import 'package:neon_framework/theme.dart';
import 'package:neon_framework/utils.dart';
import 'package:neon_framework/widgets.dart';

class FilesMainPage extends StatefulWidget {
  const FilesMainPage({
    super.key,
  });

  @override
  State<FilesMainPage> createState() => _FilesMainPageState();
}

class _FilesMainPageState extends State<FilesMainPage> {
  late FilesBloc bloc;
  late final StreamSubscription<Object> errorsSubscription;

  @override
  void initState() {
    super.initState();
    bloc = NeonProvider.of<FilesBloc>(context);

    errorsSubscription = bloc.errors.listen((error) {
      // ignore: use_build_context_synchronously
      NeonError.showSnackbar(context, error);
    });
  }

  @override
  void dispose() {
    unawaited(errorsSubscription.cancel());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilesBrowserView(
        bloc: bloc.browser,
        filesBloc: bloc,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showFilesCreateModal(context),
        tooltip: FilesLocalizations.of(context).uploadFiles,
        child: Icon(AdaptiveIcons.add),
      ),
    );
  }
}
