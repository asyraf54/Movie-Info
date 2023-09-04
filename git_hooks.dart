import 'package:git_hooks/git_hooks.dart';
// import 'dart:io';

void main(List<String> arguments) {
  // ignore: omit_local_variable_types
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  String commitMessage = Utils.getCommitEditMsg();
  bool isValid =  RegExp(
            r"((version):[0-9]+[.][0-9]+[.][0-9]+\s(message):[a-zA-Z0-9\s. - ""]+)")
        .hasMatch(commitMessage);
  if(!isValid){
    // ignore: avoid_print
    print('Correct commit format: "version:x.x.x message:xxxxx"');
  }
  return isValid;
}

Future<bool> preCommit() async {
  // try {
  //   ProcessResult result = await Process.run('dartanalyzer', ['bin']);
  //   print(result.stdout);
  //   if (result.exitCode != 0) return false;
  // } catch (e) {
  //   return false;
  // }
  return true;
}
