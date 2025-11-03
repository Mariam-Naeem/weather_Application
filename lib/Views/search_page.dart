import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_Application/models/weather_model.dart';
import 'package:weather_Application/providers/weather_provider.dart';
import 'package:weather_Application/services/weather_services.dart';


class SearchPage extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  Future<void> _searchWeather(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      final cityname = controller.text.trim();
      WeatherService service = WeatherService();
      WeatherModel? weather = await service.getWeather(cityname: cityname);

      if (weather != null) {
        Provider.of<WeatherProvider>(context, listen: false).weatherdata = weather;
        Provider.of<WeatherProvider>(context, listen: false).cityname = cityname;

        if (context.mounted) Navigator.of(context).pop(true);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('City not found, please try again')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Weather Search",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6DD5FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_outlined,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Find weather in your city 🌍",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                        controller: controller,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter a city" : null,
                        onFieldSubmitted: (_) => _searchWeather(context),
                        decoration: const InputDecoration(
                          hintText: "Enter city name",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.location_city),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () => _searchWeather(context),
                    child: const Text(
                      "Search Weather",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
