import 'dart:math';

class Calculator {
  late double weight;
  late double height;
  double bmi = 0.0;

  Calculator(this.weight, this.height);

  String calculateBMI() {
    bmi = weight / pow((height / 100), 2);

    return bmi.toStringAsFixed(1);
  }

  String resultText() {
    if (bmi < 18.5) {
      return 'น้ำหนักน้อย';
    } else if (bmi < 23) {
      return 'น้ำหนักปกติ';
    } else if (bmi < 25) {
      return 'น้ำหนักเกิน';
    } else if (bmi < 30) {
      return 'โรคอ้วนระดับ 1 (ความเสี่ยงบางอย่าง)';
    } else if (bmi < 40) {
      return 'โรคอ้วนระดับ 2 (ความเสี่ยงบางอย่าง)';
    } else {
      return 'โรคอ้วนระดับ 3 (ความเสี่ยงบางอย่าง)';
    }
  }
}
