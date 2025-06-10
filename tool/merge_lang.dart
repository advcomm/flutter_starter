import 'dart:convert';
import 'dart:io';

void main() async {
  final modulesRoot = Directory('lib');
  final outputDir = Directory('lib/custom/lang');

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  final supportedLocales = ['en', 'ar','de'];

  for (final locale in supportedLocales) {
    final mergedContent = <String, dynamic>{};

    // Search all module folders
    for (final entity in modulesRoot.listSync()) {
      if (entity is Directory && File('${entity.path}/lang/$locale.json').existsSync()) {
        final file = File('${entity.path}/lang/$locale.json');
        final content = jsonDecode(await file.readAsString());

        mergedContent.addAll(content);
        print('✅ Merged: ${file.path}');
      }
    }

    // Write final merged file
    final outFile = File('${outputDir.path}/$locale.json');
    await outFile.writeAsString(JsonEncoder.withIndent('  ').convert(mergedContent));
    print('✅ Output: ${outFile.path}');
  }
}
