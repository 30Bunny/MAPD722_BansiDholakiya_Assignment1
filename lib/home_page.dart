import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  final _formKey = GlobalKey<FormState>();
  var _numberOfHours = 0.0;
  var _hourlyRate = 0.0;
  var _regularPay = 0.0;
  var _overtimePay = 0.0;
  var _totalPay = 0.0;
  var _tax = 0.0;

  _calculate(){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();



      if(_numberOfHours <= 40){
        _regularPay = _numberOfHours * _hourlyRate;
        _overtimePay = 0;
        _totalPay = _regularPay;
      }else{
        _regularPay = 40 * _hourlyRate;
        _overtimePay = (_numberOfHours - 40) * _hourlyRate * 1.5;
        _totalPay = _overtimePay + _regularPay;
      }

      _tax = _totalPay * 0.18;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Pay Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Number of hours',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Number of hours';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _numberOfHours = double.parse(value!);
                        },
                      ),
                      const SizedBox(height: 8,),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Hourly rate',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Hourly rate';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _hourlyRate = double.parse(value!);
                        },
                      ),
                      const SizedBox(height: 16,),
                      ElevatedButton(onPressed: () => _calculate(), child: const Text('Calculate')),
                      const SizedBox(height: 16,),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                          children: [
                            const Text('Report'),
                            Text('Regular Pay : ${_regularPay.toStringAsFixed(2)}'),
                            Text('Overtime Pay : ${_overtimePay.toStringAsFixed(2)}'),
                            Text('Total Pay : ${_totalPay.toStringAsFixed(2)}'),
                            Text('Tax : ${_tax.toStringAsFixed(2)}'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              const StudentDetailCard()
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDetailCard extends StatelessWidget {
  const StudentDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4)
      ),
      child: const Column(
        children: [
          Text('Name : Bansi Dholakiya'),
          Text('College ID : 301363508'),
        ],
      ),
    );
  }
}
