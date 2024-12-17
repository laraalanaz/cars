import 'package:flutter/material.dart';
import 'Car.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
  String totalPrice = cars.first.getTotalPrice();
  Car car =cars.first;
  void updateCar(Car car){
    setState((){
      this.car = car;
      totalPrice=car.getTotalPrice();
    });
  }
  void updateWarranty(int warranty){
    setState((){
      car.warranty= warranty;
      totalPrice = car.getTotalPrice();
    });
  }
  void updateInsurance(bool val){
    setState((){
      car.insurance =val;
      totalPrice= car.getTotalPrice();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const Text('Select car model', style:  TextStyle(fontSize: 25.0)),
            const SizedBox(height: 30,),
            MyDropdownMenu(updateCar: updateCar),
            const SizedBox(height: 20.0),
            WarrantyWidget(updateWarranty: updateWarranty, car: car),
            const SizedBox(height: 20.0),
            InsuranceWidget(updateInsurance: updateInsurance, car: car,),
            const SizedBox(height: 10.0),
            Text('Total Price: $totalPrice', style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}


class MyDropdownMenu extends StatefulWidget {
  final Function(Car) updateCar;
  const MyDropdownMenu({required this.updateCar,super.key});
  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}
class _MyDropdownMenuState extends State<MyDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: cars.map<DropdownMenuEntry<Car>>((Car car){
        return DropdownMenuEntry(value: car, label:car.toString());
      }).toList(),
      width: 200.0,
      initialSelection: cars.first,
      onSelected: (Car? car){
        widget.updateCar(car as Car);
      },
    );
  }
}


class WarrantyWidget extends StatefulWidget {
  final Function(int) updateWarranty;
  Car car;
  WarrantyWidget({required this.car, required this.updateWarranty,super.key});
  @override
  State<WarrantyWidget> createState() => _WarrantyWidgetState();
}
class _WarrantyWidgetState extends State<WarrantyWidget> {
  int _years =1;
  void changedSelection (int val){
    setState(() {
      this._years = val;
      widget.updateWarranty(this._years);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Warranty', style:TextStyle(fontSize: 25.0),),
        Radio(value: 1, groupValue: widget.car.warranty, onChanged: (int? val){changedSelection(val as int);}),
        Text('1 year', style:TextStyle(fontSize: 25.0),),
        Radio(value: 5, groupValue: widget.car.warranty, onChanged: (int? val){changedSelection(val as int);}),
        Text('5 years', style:TextStyle(fontSize: 25.0),),
      ],
    );
  }
}


class InsuranceWidget extends StatefulWidget {
  final Function(bool) updateInsurance;
  Car car;
  InsuranceWidget({required this.updateInsurance, required this.car, super.key});
  @override
  State<InsuranceWidget> createState() => _InsuranceState();
}
class _InsuranceState extends State<InsuranceWidget> {
  bool _insurance = false;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Insurance ?", style: TextStyle(fontSize: 25.0),),
        Checkbox(value: widget.car.insurance, onChanged: (bool? val){
          setState(() {
            this._insurance = val as bool;
            widget.updateInsurance(this._insurance);
          });})
      ],
    );
  }
}