import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef c_run_code_func =
    ffi.Int32 Function(
      ffi.Pointer<ffi.Int8> lang,
      ffi.Pointer<ffi.Int8> codeFile,
      ffi.Pointer<ffi.Int8> outputFile,
    );
typedef dart_run_code_func =
    int Function(
      ffi.Pointer<ffi.Int8> lang,
      ffi.Pointer<ffi.Int8> codeFile,
      ffi.Pointer<ffi.Int8> outputFile,
    );

class Judge {
  late ffi.DynamicLibrary dylib;
  late dart_run_code_func runCode;

  Judge() {
    dylib = Platform.isAndroid
        ? ffi.DynamicLibrary.open("libjudge_engine.so")
        : ffi.DynamicLibrary.process();

    runCode = dylib.lookupFunction<c_run_code_func, dart_run_code_func>(
      "run_code",
    );
  }

  Future<String> execute(
    String lang,
    String codeFile,
    String outputFile,
  ) async {
    return await Future(() {
      final langPtr = lang.toNativeUtf8();
      final codePtr = codeFile.toNativeUtf8();
      final outputPtr = outputFile.toNativeUtf8();

      runCode(
        langPtr as ffi.Pointer<ffi.Int8>,
        codePtr as ffi.Pointer<ffi.Int8>,
        outputPtr as ffi.Pointer<ffi.Int8>,
      );

      malloc.free(langPtr);
      malloc.free(codePtr);
      malloc.free(outputPtr);

      final output = File(outputFile).readAsStringSync();
      return output;
    });
  }
}
