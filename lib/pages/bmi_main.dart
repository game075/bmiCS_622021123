import 'package:bmi_app/bmi_calculate.dart';
import 'package:bmi_app/pages/bmi_result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  _BmiMainState createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'น้ำหนักของคุณ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      weightfield(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'ส่วนสูงของคุณ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      heightfield(),
                      const SizedBox(height: 48),
                      calcButton(context)
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox calcButton(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Row(
        children: const [Text('ข้อมูลหาย')],
      ),
      // title: ,
      content: const Text(
        'ต้องการส่วนสูงและน้ำหนัก!',
        style: TextStyle(fontSize: 18),
      ),

      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(const Color(0xFF000000)),
          ),
          // textColor: Color(0xFF6200EE),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
    return SizedBox(
      width: 230,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            if (_weight.text.isNotEmpty && _height.text.isNotEmpty) {
              Calculator cal = Calculator(
                  double.parse(_weight.text), double.parse(_height.text));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BmiResult(
                    bmiResult: cal.calculateBMI(),
                    resultText: cal.resultText(),
                  ),
                ),
              );
            } else {
              showDialog<void>(context: context, builder: (context) => dialog);
            }
          },
          child: const Text(
            'คำนวณ',
            style: TextStyle(fontSize: 20),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
        ),
      ),
    );
  }

  Widget weightfield() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _weight,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 28),
      decoration: InputDecoration(
        hintText: 'KG',
        hintStyle: const TextStyle(fontSize: 22),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }

  Widget heightfield() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: _height,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 28),
      textAlign: TextAlign.start,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'CM',
        hintStyle: const TextStyle(fontSize: 22),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}
