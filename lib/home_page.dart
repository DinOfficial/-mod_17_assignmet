import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

enum WeightType { kg, lb }

enum HeightType { cm, feetInc, m }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeightType weightType = WeightType.kg;
  HeightType heightType = HeightType.cm;

  final kgCtrl = TextEditingController();
  final lbCtrl = TextEditingController();
  final cmCtrl = TextEditingController();
  final feetCtrl = TextEditingController();
  final inchCtrl = TextEditingController();
  final mCtrl = TextEditingController();

  String bmiResult = '';
  double bmiValue = 0.0;

  // 1 kg = 0.453592 lb
  double? lbToKg() {
    final kgText = kgCtrl.text;
    final lbText = lbCtrl.text;
    if (kgText.isNotEmpty) {
      final kg = double.tryParse(kgText.trim());
      if (kg == null || kg <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid weight in KG')));
        return null;
      }
      return kg;
    } else if (lbText.isNotEmpty) {
      final lb = double.tryParse(lbText.trim());
      if (lb == null || lb <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid weight in KG')));
        return null;
      }
      return lb * 0.453592;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a weight')));
      return null;
    }
  }

  // 1 m = 100 cm

  double? weightTypeCalculation() {
    final cmText = cmCtrl.text;
    final feetText = feetCtrl.text;
    final inchText = inchCtrl.text;
    final mText = mCtrl.text;

    if (cmText.isNotEmpty) {
      final cm = double.tryParse(cmText.trim());
      if (cm == null || cm <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid height in CM')));
        return null;
      }
      return cm / 100;
    } else if (feetText.isNotEmpty || inchText.isNotEmpty) {
      final feet = double.tryParse(feetText.trim()) ?? 0.0;
      final inch = double.tryParse(inchText.trim()) ?? 0.0;
      if (feet <= 0 && inch <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid height in Feet/Inch')));
        return null;
      }
      double totalFeet = feet + (inch / 12.0);
      // 1 feet = 0.3048 meters
      return totalFeet * 0.3048;
    } else if (mText.isNotEmpty) {
      final m = double.tryParse(mText.trim());
      if (m == null || m <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid height in Meter')));
        return null;
      }
      return m;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a height')));
    return null;
  }

  void calculateBMI() {
    final weight = lbToKg();
    final height = weightTypeCalculation();

    if (weight == null || height == null) {
      return;
    }

    final bmi = weight / (height * height);
    setState(() {
      bmiValue = bmi;
      bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)}';
    });
  }

  @override
  void dispose() {
    kgCtrl.dispose();
    lbCtrl.dispose();
    cmCtrl.dispose();
    feetCtrl.dispose();
    inchCtrl.dispose();
    mCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Text(
            'Weight Type',
            style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SegmentedButton<WeightType>(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              selectedBackgroundColor: Colors.blueGrey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.blueGrey, width: 3),
              ),
            ),
            segments: [
              ButtonSegment<WeightType>(value: WeightType.kg, label: Text('KG')),
              ButtonSegment<WeightType>(value: WeightType.lb, label: Text('LB')),
            ],
            selected: {weightType},
            onSelectionChanged: (value) {
              setState(() {
                weightType = value.first;
              });
              if (weightType == WeightType.kg) {
                kgCtrl.clear();
                lbCtrl.clear();
              }
              bmiResult = '';
            },
          ),
          if (weightType == WeightType.kg) ...[
            SizedBox(height: 10),
            TextField(
              controller: kgCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Weight (KG)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ] else ...[
            SizedBox(height: 10),
            TextField(
              controller: lbCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Weight (LB)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
          SizedBox(height: 20),
          Text(
            'Height Type',
            style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SegmentedButton<HeightType>(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              selectedBackgroundColor: Colors.blueGrey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.blueGrey, width: 3),
              ),
            ),
            segments: [
              ButtonSegment<HeightType>(value: HeightType.cm, label: Text('CM')),
              ButtonSegment<HeightType>(value: HeightType.feetInc, label: Text('INCH/FEET')),
              ButtonSegment<HeightType>(value: HeightType.m, label: Text('MEETER')),
            ],
            selected: {heightType},
            onSelectionChanged: (value) {
              setState(() {
                heightType = value.first;
              });

              if (heightType == HeightType.cm) {
                cmCtrl.clear();
                feetCtrl.clear();
                inchCtrl.clear();
              }
              bmiResult = '';
            },
          ),
          if (heightType == HeightType.cm) ...[
            SizedBox(height: 10),
            TextField(
              controller: cmCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Height (CM)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ] else if (heightType == HeightType.feetInc) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: feetCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Height (Feet)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: inchCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Height (INCH)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: 10),
            TextField(
              controller: mCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Height (MEETER)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[300],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: calculateBMI,
            child: Text(
              'Show The Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blueGrey[100],
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 300,
              child: Center(
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 2000,
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 40,
                      pointers: <NeedlePointer>[
                        NeedlePointer(
                          needleLength: 0.8,
                          value: bmiValue,
                          enableAnimation: true,
                          needleColor: Colors.blueGrey,
                        ),
                      ],
                      ranges: <GaugeRange>[
                        GaugeRange(startValue: 0, endValue: 18, color: Colors.red),
                        GaugeRange(startValue: 18, endValue: 25, color: Colors.green),
                        GaugeRange(startValue: 25, endValue: 40, color: Colors.yellow),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bmiResult.isEmpty ? 'Your BMI Result' : bmiResult,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              if (bmiValue <= 18.5 && bmiValue >= 5) ...[
                                Text(
                                  'You are underweight',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ] else if (bmiValue >= 18.5 && bmiValue <= 25) ...[
                                Text(
                                  'You are Healthy',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ] else if (bmiValue >= 25 && bmiValue <= 30) ...[
                                Text(
                                  'You are overweight',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ],
                          ),
                          angle: 90,
                          positionFactor: 0.3,
                          horizontalAlignment: GaugeAlignment.center,
                          verticalAlignment: GaugeAlignment.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
