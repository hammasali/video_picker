// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cam App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Cam App'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen1(),
//     Text(
//       'Index 1: Business',
//       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
//
// class HomeScreen1 extends StatefulWidget {
//   const HomeScreen1({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreen1State createState() => _HomeScreen1State();
// }
//
// class _HomeScreen1State extends State<HomeScreen1> {
//   File? _image;
//   PickedFile? _imageFile;
//   dynamic _pickImageError;
//   String? _retrieveDataError;
//   final ImagePicker _picker = ImagePicker();
//
//   Widget get _imageUpload => FutureBuilder<void>(
//         future: retrieveLostData(),
//         builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               return Container(
//                 height: 500,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.teal,
//                   borderRadius: BorderRadius.circular(100.0),
//                 ),
//                 child: FittedBox(fit: BoxFit.cover, child: _previewImage()),
//               );
//             default:
//               return Container(
//                 height: 80,
//                 width: 80,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(40)),
//                 child: Center(
//                     child: Icon(
//                   Icons.account_circle_outlined,
//                   color: Colors.white,
//                   size: 70,
//                 )),
//               );
//           }
//         },
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Home',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         InkWell(
//             onTap: () {
//               showSheet(context);
//             },
//             child: _imageUpload),
//         SizedBox(
//           height: 20.0,
//         ),
//         ElevatedButton(onPressed: () {}, child: Text('Processing'))
//       ],
//     );
//   }
//
//   void _onImageButtonPressed(ImageSource source,
//       {BuildContext? context}) async {
//     try {
//       final pickedFile = await _picker.getImage(
//         source: source,
//       );
//       setState(() {
//         _imageFile = pickedFile;
//       });
//     } catch (e) {
//       setState(() {
//         _pickImageError = e;
//       });
//     }
//   }
//
//   Widget _previewImage() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//
//     if (_imageFile != null) {
//       _image = File(_imageFile!.path);
//       print('image File : $_image');
//       return Semantics(
//           child: Image.file(
//             _image!,
//           ),
//           label: 'image_picker_example_picked_image');
//     } else if (_pickImageError != null) {
//       return Container(
//         height: 80,
//         width: 80,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
//         child: Center(
//             child: Icon(
//           Icons.account_circle_outlined,
//           color: Colors.white,
//           size: 70,
//         )),
//       );
//     } else {
//       return Container(
//         height: 80,
//         width: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         child: Center(
//             child: Icon(
//           Icons.account_circle_outlined,
//           color: Colors.white,
//           size: 70,
//         )),
//       );
//     }
//   }
//
//   Future<void> retrieveLostData() async {
//     final LostData response = await _picker.getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         _imageFile = response.file;
//       });
//     } else {
//       _retrieveDataError = response.exception!.code;
//     }
//   }
//
//   Text? _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError!);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
//
//   void showSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             height: 140.0,
//             color: Color(0x00ff3E4346),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 FloatingActionButton(
//                   onPressed: () {
//                     _onImageButtonPressed(ImageSource.gallery,
//                         context: context);
//                     Navigator.of(context).pop();
//                   },
//                   backgroundColor: Color(0x00ffA60000),
//                   heroTag: 'image0',
//                   tooltip: 'Pick Image from gallery',
//                   child: const Icon(Icons.photo_library),
//                 ),
//                 FloatingActionButton(
//                   onPressed: () {
//                     _onImageButtonPressed(ImageSource.camera, context: context);
//                     Navigator.of(context).pop();
//                   },
//                   backgroundColor: Color(0x00ffA60000),
//                   heroTag: 'image1',
//                   tooltip: 'Take a Photo',
//                   child: const Icon(Icons.camera_alt),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }


