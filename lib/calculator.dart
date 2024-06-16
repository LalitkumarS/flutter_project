import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BMICalculator(),
    debugShowCheckedModeBanner: false,
  ));
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Color myColor = Colors.transparent;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightCmsController = TextEditingController();
  String mainResult = "";
  String bmiCategory = "";

  void calculateBMI(String weight, String heightCms) {
    double myDoubleWeight = double.parse(weight);
    double myDoubleHeight = double.parse(heightCms) / 100;

    double res = (myDoubleWeight / (myDoubleHeight * myDoubleHeight));

    setState(() {
      mainResult = res.toStringAsFixed(2);
      if (res < 18.5) {
        myColor = Color(0xFF87B1D9);
        bmiCategory = "Underweight";
      } else if (res >= 18.5 && res <= 24.9) {
        myColor = Color(0xFF3DD365);
        bmiCategory = "Normal";
      } else if (res >= 25 && res <= 29.9) {
        myColor = Color(0xFFEEE133);
        bmiCategory = "Overweight";
      } else if (res >= 30 && res <= 34.9) {
        myColor = Color(0xFFFD802E);
        bmiCategory = "Obese";
      } else if (res >= 35) {
        myColor = Color(0xFFF95353);
        bmiCategory = "Extreme";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.black), // Changed color of "BMI Calculator" to black
        ),
        backgroundColor: Color(0xFFFFC107), // Changed AppBar background color
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Changed background color of the web page
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Enter your details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 25,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildTextField(nameController, "Enter your name"),
                  SizedBox(height: 15),
                  _buildTextField(ageController, "Enter your age"),
                  SizedBox(height: 15),
                  _buildTextField(weightController, "Enter your weight (kg)"),
                  SizedBox(height: 15),
                  _buildTextField(heightCmsController, "Enter your height (cm)"),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          calculateBMI(weightController.text, heightCmsController.text);
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF0038FF)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          elevation: MaterialStateProperty.all(10),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: myColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BMI: $mainResult",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Category: $bmiCategory",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  _buildBMICategories(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildBMICategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategory(Color(0xFF87B1D9), "Underweight", Icons.arrow_downward, BorderRadius.only(topLeft: Radius.circular(15))),
        _buildCategory(Color(0xFF3DD365), "Normal", Icons.check_circle, BorderRadius.only(topRight: Radius.circular(15))),
        _buildCategory(Color(0xFFEEE133), "Overweight", Icons.arrow_upward, BorderRadius.only(bottomLeft: Radius.circular(15))),
        _buildCategory(Color(0xFFFD802E), "Obese", Icons.warning, BorderRadius.only(bottomRight: Radius.circular(15))),
        _buildCategory(Color(0xFFF95353), "Extreme", Icons.error, BorderRadius.all(Radius.circular(15))),
      ],
    );
  }

  Widget _buildCategory(Color color, String label, IconData iconData, BorderRadius borderRadius) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black),
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
