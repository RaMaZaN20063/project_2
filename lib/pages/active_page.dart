import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:realization_project/information_taxi.dart';
import 'package:realization_project/pages/completed_page.dart';
import 'package:realization_project/pages/main_page.dart';
import 'package:realization_project/pages/model/taxi.dart';
import 'package:realization_project/pages/provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({super.key});

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  final String phoneNumber = "+77001112233";
  TimeOfDay? selectedTime;
  double _saveRating = 3.0;
  final TextEditingController _commentController = TextEditingController();

  Future<void> _pickedTime() async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_pickedTime != null) {
      setState(() {
        selectedTime = _pickedTime;
      });
    }
  }
void _cancelRide() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Отмена поездки', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A56E2))),
        content: const Text("Вы уверены, что хотите отменить поездку?", style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Нет', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              final rideProvider = Provider.of<RideProvider>(context, listen: false);
              rideProvider.addCompletedRide(
                CompletedRide(
                  driverName: 'Abish Ramazan',
                  carNumber: 'AKE88808',
                  arrivalTime: selectedTime != null
                      ? "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                      : null,
                  driverImageUrl: 'https://t4.ftcdn.net/jpg/02/42/00/11/360_F_242001117_QerBPrW09wvbv7Sqp3JNQd0ygjlyPmpf.jpg',
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InformationTaxi()),
              );
            },
            child: const Text('Да', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 10,
      );
    },
  );
}
  void _messageDriver() async {
    final Uri uri = Uri.parse("sms:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _callDriver() async {
    final Uri uri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _submitComment() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Комментарий отправлен!'),
        backgroundColor: Color(0xFF4A56E2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    setState(() {
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Активная поездка', style: TextStyle(color: Color(0xFF4A56E2), fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4A56E2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/02/42/00/11/360_F_242001117_QerBPrW09wvbv7Sqp3JNQd0ygjlyPmpf.jpg',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.check, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Abish Ramazan',
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 5),
                          Text(
                            '4.8',
                            style: TextStyle(
                              color: Colors.amber[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.phone, size: 20),
                          onPressed: _callDriver,
                          label: Text('Позвонить', style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 3,
                          ),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton.icon(
                          icon: Icon(Icons.message, size: 20),
                          onPressed: _messageDriver,
                          label: Text('Написать', style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A56E2),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF4A56E2).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.directions_car, color: Color(0xFF4A56E2), size: 24),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Номер машины',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'AKE88808',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF4A56E2).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.access_time, color: Color(0xFF4A56E2), size: 24),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Время прибытия',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5),
                              selectedTime != null
                                ? Text(
                                    "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF333333),
                                    ),
                                  )
                                : Text(
                                    "Не выбрано",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickedTime,
                          child: Text("Выбрать", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A56E2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Оставьте отзыв',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: RatingBar.builder(
                        minRating: 1,
                        maxRating: 5,
                        allowHalfRating: true,
                        initialRating: _saveRating,
                        itemSize: 35,
                        unratedColor: Colors.grey[300],
                        onRatingUpdate: (rating) {
                          setState(() {
                            _saveRating = rating;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Icon(Icons.star, color: Colors.amber);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Напишите свой отзыв...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xFF4A56E2), width: 2),
                        ),
                        prefixIcon: Icon(Icons.comment, color: Color(0xFF4A56E2)),
                        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      ),
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitComment,
                        child: Text('Отправить отзыв', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A56E2),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200, // Высота карты
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(51.509364, -0.128928), // Центр карты (Лондон)
                      zoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _cancelRide,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
          ),
          child: Text(
            'Завершить поездку',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}