import 'dart:io';
import 'dart:convert';

main() async {
  await samplesList();

  Process.run('cat', ['./samples']).then((ProcessResult results) async {
    List<dynamic> list = jsonDecode(results.stdout);

    for (var i = 0; i < list.length; i++) {
      String id = list[i]['id'];

      var name = id.split(".")[1] + i.toString();

      await create(id, name);
    }
  });
}

samplesList() async {
  await removeSamples();

  return Process.run('flutter', ['create', '--list-samples=samples'])
      .then((ProcessResult results) {
    // print(results.stdout);
    print(results.stderr);
  });
}

removeSamples() async {
  return Process.run('rm', ['./samples']).then((ProcessResult results) {
    // print(results.stdout);
    print(results.stderr);
  });
}

create(String id, String name) async {
  print('$id, $name');
  return Process.run('flutter', ['create', '--sample=$id', name.toLowerCase()])
      .then((ProcessResult results) {
    // print(results.stdout);
    print(results.stderr);
  });
}
