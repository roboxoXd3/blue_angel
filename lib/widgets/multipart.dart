// import 'dart:async';
// // import 'dart:convert';
// import 'package:http_parser/http_parser.dart';

// class MultipartFile {
//   /// The size of the file in bytes. This must be known in advance, even if this
//   /// file is created from a [ByteStream].
//   final int length;

//   /// The basename of the file. May be null.
//   final String filename;

//   /// The content-type of the file. Defaults to `application/octet-stream`.
//   final MediaType contentType;

//   /// The stream that will emit the file's contents.
//   final Stream<List<int>> _stream;

//   /// Whether [finalize] has been called.
//   bool get isFinalized => _isFinalized;
//   bool _isFinalized = false;

//   static var _err = UnsupportedError(
//       'MultipartFile is only supported where dart:io is available.');

//   static Future<MultipartFile> multipartFileFromPath(String filePath,
//           {String filename, MediaType contentType}) =>
//       throw _err;

//   MultipartFile(
//     Stream<List<int>> stream,
//     this.length, {
//     this.filename,
//     MediaType contentType,
//   })  : _stream = stream,
//         contentType = contentType ?? MediaType('application', 'octet-stream');

//   static Future<MultipartFile> fromFile(
//     String filePath,
//     String filename, {
//     MediaType contentType,
//   }) =>
//       multipartFileFromPath(
//         filePath,
//         filename: filename,
//         contentType: contentType,
//       );

//   Stream<List<int>> finalize() {
//     if (isFinalized) {
//       throw StateError("Can't finalize a finalized MultipartFile.");
//     }
//     _isFinalized = true;
//     return _stream;
//   }
// }
