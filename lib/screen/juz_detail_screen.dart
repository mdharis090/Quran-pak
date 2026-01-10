// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class JuzDetailScreen extends StatefulWidget {
//   final int juzNumber;
//   const JuzDetailScreen({super.key, required this.juzNumber});
//
//   @override
//   State<JuzDetailScreen> createState() => _JuzDetailScreenState();
// }
//
// class _JuzDetailScreenState extends State<JuzDetailScreen> {
//   List ayahs = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchJuz();
//   }
//
//   Future<void> fetchJuz() async {
//     final res = await http.get(
//       Uri.parse(
//         'https://api.alquran.cloud/v1/juz/${widget.juzNumber}/quran-uthmani',
//       ),
//     );
//
//     if (res.statusCode == 200) {
//       final data = json.decode(res.body);
//       setState(() {
//         ayahs = data['data']['ayahs'];
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Juz ${widget.juzNumber}')),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.separated(
//         itemCount: ayahs.length,
//         separatorBuilder: (_, __) => const Divider(
//           color: Colors.grey,
//           height: 1,
//         ),
//         itemBuilder: (context, index) {
//           final ayah = ayahs[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Ayah number
//                 Container(
//                   width: 30,
//                   alignment: Alignment.center,
//                   child: CircleAvatar(
//                     radius: 14,
//                     backgroundColor: Colors.green,
//                     child: Text(
//                       ayah['numberInSurah'].toString(),
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 // Ayah text
//                 Expanded(
//                   child: Text(
//                     ayah['text'],
//                     textAlign: TextAlign.right,
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JuzDetailScreen extends StatefulWidget {
  final int juzNumber;
  const JuzDetailScreen({super.key, required this.juzNumber});

  @override
  State<JuzDetailScreen> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<JuzDetailScreen> {
  List ayahs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchJuz();
  }

  Future<void> fetchJuz() async {
    final res = await http.get(
      Uri.parse(
        'https://api.alquran.cloud/v1/juz/${widget.juzNumber}/quran-uthmani',
      ),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      setState(() {
        ayahs = data['data']['ayahs'];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
          title: Text('Juz ${widget.juzNumber}'

      )),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            final ayah = ayahs[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ayah number circle
                  Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.green,
                      child: Text(
                        ayah['numberInSurah'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Ayah text
                  Expanded(
                    child: Text(
                      ayah['text'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.5, // line spacing like Mushaf
                        fontFamily: 'Amiri', // use uthmani/arabic font
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
