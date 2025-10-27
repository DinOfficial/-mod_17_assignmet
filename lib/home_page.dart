import 'package:flutter/material.dart';

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
            onSelectionChanged: (value) => setState(() => weightType = value.first),
          ),
          if (weightType == WeightType.kg) ...[
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Weight (KG)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ] else ...[
            SizedBox(height: 10),
            TextField(
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
            onSelectionChanged: (value) => setState(() => heightType = value.first),
          ),
          if (heightType == HeightType.cm) ...[
            SizedBox(height: 10),
            TextField(
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
                    decoration: InputDecoration(
                      hintText: 'Height (Feet)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
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
              decoration: InputDecoration(
                hintText: 'Height (MEETER)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
              onPressed: (){},
              child: Text('Show The Result', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), )
          ),
          SizedBox(height: 20,),
          Card(
            child: Center(
              child: Text('Result'),
            ),
          )
        ],
      ),
    );
  }
}
