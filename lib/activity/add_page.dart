import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license_plate_recognition_app/model/validators.dart';

import '../model/custom_dialog_box.dart';

class AddDatePage extends StatefulWidget {
  AddDatePage({Key? key}) : super(key: key);

  @override
  State<AddDatePage> createState() => _AddDatePageState();
}

class _AddDatePageState extends State<AddDatePage> {
  String dropdownValue = 'กรุงเทพมหานคร';

  late String _chosenValue;

  static final Map<String, String> genderMap = {
    'นักศึกษา': 'นักศึกษา',
    'อาจารย์': 'ครู/อาจารย์',
    'บุคลากร': 'บุคลากร',
  };

  String _selectedGender = genderMap.keys.first;

  final _formKey = GlobalKey<FormState>();

  var licensesController = TextEditingController();
  var provinceController = TextEditingController();
  var brandController = TextEditingController();
  var modelController = TextEditingController();
  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final genderSelectionTile = Material(
      color: Colors.transparent,
      textStyle: const TextStyle(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('สถานะ',
              style: TextStyle(
                color: CupertinoColors.systemRed,
                fontSize: 15.0,
              )),
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
          ),
          CupertinoRadioChoice(
              notSelectedColor: Colors.red.shade200,
              selectedColor: Colors.red,
              choices: genderMap,
              onChange: onGenderSelected,
              initialKeyValue: _selectedGender)
        ],
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Card(
          color: Colors.red,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(18, 4, 18, 8),
            child: Text(
              'เพิ่มข้อมูล',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: TextFormField(
                        controller: licensesController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: "เลขป้ายทะเบียน :"),
                        validator: Validators.compose([
                          Validators.required('กรุณากรอกเลขป้ายทะเบียน'),
                        ])
                        // (value) =>
                        //     value!.isEmpty ? 'กรุณากรอกเลขป้ายทะเบียน' : null,
                        )),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.orange,
                        ),
                        isExpanded: true,
                        elevation: 0,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'กรุงเทพมหานคร',
                          'สมุทรปราการ',
                          'นนทบุรี',
                          'ปทุมธานี',
                          'พระนครศรีอยุธยา',
                          'อ่างทอง',
                          'ลพบุรี',
                          'สิงห์บุรี',
                          'ชัยนาท',
                          'สระบุรี',
                          'ชลบุรี',
                          'ระยอง',
                          'จันทบุรี',
                          'ตราด',
                          'ฉะเชิงเทรา',
                          'ปราจีนบุรี',
                          'นครนายก',
                          'สระแก้ว',
                          'นครราชสีมา',
                          'บุรีรัมย์',
                          'สุรินทร์',
                          'ศรีสะเกษ',
                          'อุบลราชธานี',
                          'ยโสธร',
                          'ชัยภูมิ',
                          'อำนาจเจริญ',
                          'หนองบัวลำภู',
                          'ขอนแก่น',
                          'อุดรธานี',
                          'เลย',
                          'หนองคาย',
                          'มหาสารคาม',
                          'ร้อยเอ็ด',
                          'กาฬสินธุ์',
                          'สกลนคร',
                          'นครพนม',
                          'มุกดาหาร',
                          'เชียงใหม่',
                          'ลำพูน',
                          'ลำปาง',
                          'อุตรดิตถ์',
                          'แพร่',
                          'น่าน',
                          'พะเยา',
                          'เชียงราย',
                          'แม่ฮ่องสอน',
                          'นครสวรรค์',
                          'อุทัยธานี',
                          'กำแพงเพชร',
                          'ตาก',
                          'สุโขทัย',
                          'พิษณุโลก',
                          'พิจิตร',
                          'เพชรบูรณ์',
                          'ราชบุรี',
                          'กาญจนบุรี',
                          'สุพรรณบุรี',
                          'นครปฐม',
                          'สมุทรสาคร',
                          'สมุทรสงคราม',
                          'เพชรบุรี',
                          'ประจวบคีรีขันธ์',
                          'นครศรีธรรมราช',
                          'กระบี่',
                          'พังงา',
                          'ภูเก็ต',
                          'สุราษฎร์ธานี',
                          'ระนอง',
                          'ชุมพร',
                          'สงขลา',
                          'สตูล',
                          'ตรัง',
                          'พัทลุง',
                          'ปัตตานี',
                          'ยะลา',
                          'นราธิวาส',
                          'บึงกาฬ',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.orange),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: TextFormField(
                        controller: brandController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: "ยี่ห้อรถ :"),
                        validator: Validators.compose([
                          Validators.required('กรุณากรอกยี่ห้อรถ'),
                        ]))),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: TextFormField(
                        controller: modelController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: "รุ่น :"),
                        validator: Validators.compose([
                          Validators.required('กรุณากรอกรุ่นรถ'),
                        ]))),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: "เจ้าของรถ :"),
                        validator: Validators.compose([
                          Validators.required('กรุณากรอกเจ้าของรถ'),
                        ]))),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: TextFormField(
                        controller: numberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            labelText: "เบอร์ติดต่อ :"),
                        validator: Validators.compose([
                          Validators.required('กรุณากรอกเบอร์ติดต่อ'),
                          Validators.maxLength(
                              10, 'กรุณากรอกเบอร์ติดต่อไม่เกิน 10 ตัวอักษร')
                        ]))),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: <Widget>[genderSelectionTile]),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    bool validate = _formKey.currentState!.validate();
                    if (validate) {
                      addData(
                          licensesController.text,
                          dropdownValue,
                          brandController.text,
                          modelController.text,
                          nameController.text,
                          numberController.text,
                          _selectedGender,
                          licensesController.text);
                      //print(dropdownValue);
                    } else {
                      print('error');
                    }
                  },
                  child: const Center(
                    child: Text(
                      "ยืนยัน",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      "ยกเลิก",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  Future<void> addData(String licenses, String province, String brand,
      String model, String name, String number, String status, var keys) async {
    bool keyId = false;
    var CheckKey = '';
    final databaseRefences =
        await FirebaseDatabase.instance.reference().child("user");
    databaseRefences.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        if (key == keys) {
          print("######if#####");
          print(key);
          setState(() {
            keyId = true;
            CheckKey = key;
          });
          print(keyId);
          print("######if#####");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "ลงทะเบียนไม่สำเร็จ",
                  descriptions:
                      "เนื่องจากป้ายทะเบียน $licenses มีอยู่ในระบบแล้ว กรุณาตรวจสอบข้อมูลใหม่",
                  text: "ตกลง",
                  img: Image.asset('assets/icons/erase.png'),
                );
              });
          setState(() {
            keyId = false;
          });
          print(CheckKey);
        }
      });
    }).then((value) {
      if (keys != CheckKey) {
        print(CheckKey);

        FirebaseDatabase.instance.reference().child('user/' + keys).set({
          "licenses": licenses,
          "province": province,
          "brand": brand,
          "model": model,
          "name": name,
          "number": number,
          "status": status,
        }).then((value) {
          print('sss');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "ลงทะเบียนสำเร็จ",
                  descriptions:
                      "ข้อมูลทะเบียน $licenses $province ถูกบันทึกลงในฐานข้อมูลเรียบร้อยแล้ว",
                  text: "ตกลง",
                  img: Image.asset('assets/icons/data.png'),
                );
              });
        }).onError((error, stackTrace) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "ลงทะเบียนไม่สำเร็จ",
                  descriptions: "กรุณาตรวจสอบข้อมูลใหม่ ไม่สามารถลงทะเบียนได้",
                  text: "ตกลง",
                  img: Image.asset('assets/icons/erase.png'),
                );
              });
        });
        licensesController.clear();
        provinceController.clear();
        brandController.clear();
        modelController.clear();
        nameController.clear();
        numberController.clear();
        statusController.clear();
      }
    });
  }
}
