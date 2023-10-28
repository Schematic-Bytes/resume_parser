import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resumify/routes/resumeData.dart';
import 'package:resumify/routes/widgets/historyList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resumify/routes/widgets/selectedFiles.dart';

class Home extends StatefulWidget {
  bool fileChoosed = false;
  var file;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Text(
              "History",
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "Tap any file to preview",
              style: GoogleFonts.inter(fontSize: 12),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: ListView(
              shrinkWrap: true,
              children: const [
                HistoryList(),
                HistoryList(),
                HistoryList(),
                HistoryList(),
                HistoryList(),
              ],
            ),
          ),
        ],
      )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Upload Your Files",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                strokeWidth: 1.5,
                dashPattern: const [10],
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/folder.png"),
                      Text(
                        "Choose your files here",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color.fromRGBO(179, 181, 182, 1)),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ["pdf"],
                );
                if (result != null) {
                  widget.file = result.files.first;
                  // Client(widget.file.path);
                  setState(() {
                    widget.fileChoosed = true;
                  });
                } else {
                  setState(() {
                    widget.fileChoosed = false;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            if (widget.fileChoosed)
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    SelectedFiles(),
                    SelectedFiles(),
                    SelectedFiles(),
                    SelectedFiles(),
                    SelectedFiles(),
                    SelectedFiles(),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(243, 243, 244, 1),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.inter(fontSize: 13),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(0, 111, 245, 1),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Upload",
                          style: GoogleFonts.inter(
                              fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.fileChoosed
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResumeData(),
                              ),
                            )
                          : null;
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
