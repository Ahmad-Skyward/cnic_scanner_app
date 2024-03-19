import 'package:cnic/model.dart';
import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cnicModel =CnicModel();
  TextEditingController nameTEController = TextEditingController(),
      fatherNameTEController = TextEditingController(),
      cnicTEController = TextEditingController(),
      dobTEController = TextEditingController(),
      doiTEController = TextEditingController(),
      doeTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,
        title: const Text(
          'CNIC Scanner',
          style: TextStyle(
              fontWeight: FontWeight.bold, backgroundColor: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Enter "CNIC" Details',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameTEController,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: fatherNameTEController,
                decoration: const InputDecoration(
                    labelText: 'Father Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: cnicTEController,
                decoration: const InputDecoration(
                    labelText: 'CNIC Number',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: dobTEController,
                decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: doiTEController,
                decoration: const InputDecoration(
                    labelText: 'Date of Issue',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: doeTEController,
                decoration: const InputDecoration(
                    labelText: 'Date of Expiry',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton.icon(
                    label: const Text(
                      'Scan ID card',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.amber,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () async {
                      await _scanCnic();
                    },
                    icon: const Icon(
                      Icons.credit_card_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanCnic() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        final cnicModel =
            await CnicScanner().scanImage(imageSource: ImageSource.camera);
        if (cnicModel != null) {
          setState(() {
            nameTEController.text = cnicModel.cnicHolderName ?? '';
            fatherNameTEController.text = cnicModel.cnicFatherName.toString() ?? '';
            cnicTEController.text = cnicModel.cnicNumber ?? '';
            dobTEController.text = cnicModel.cnicHolderDateOfBirth ?? '';
            doiTEController.text = cnicModel.cnicIssueDate ?? '';
            doeTEController.text = cnicModel.cnicExpiryDate ?? '';
          });
        } else {
          _showErrorDialog('Error', 'Failed to scan CNIC.');
        }
      }
    } catch (e) {
      _showErrorDialog('Error', 'An error occurred: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
