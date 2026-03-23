import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/gen/leveldb/'),
          structure: OutputStructure.packageStructure,
        ),
      ),
      mavenDownloads:
          MavenDownloads(sourceDeps: ['org.iq80.leveldb:leveldb:0.12']),
      classes: [
        'org.iq80.leveldb.DB',
        'org.iq80.leveldb.Options',
        'org.iq80.leveldb.DBIterator',
        'org.iq80.leveldb.impl.Iq80DBFactory',
        'org.iq80.leveldb.impl.SeekingIteratorAdapter',
        'java.io.File'
      ],
    ),
  );
}
