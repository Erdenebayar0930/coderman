import 'dart:ffi';
import 'dart:io';

typedef AddFuncNative = Int32 Function(Int32, Int32);
typedef AddFuncDart = int Function(int, int);

class NativeLib {
  late DynamicLibrary _lib;
  late AddFuncDart add;

  NativeLib() {
    if (Platform.isAndroid) {
      _lib = DynamicLibrary.open("libnative-lib.so");
    } else if (Platform.isIOS) {
      _lib = DynamicLibrary.process();
    }

    add = _lib.lookup<NativeFunction<AddFuncNative>>("add").asFunction();
  }
}
