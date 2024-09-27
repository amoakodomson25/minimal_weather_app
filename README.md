# Minimal Weather App
A simple Flutter application that provides current weather information based on the user's location. The app uses the OpenWeatherMap API to fetch weather data and displays it in an easy-to-read format.

## Features
Displays current weather conditions based on the user's geographical location.
Shows the city name and temperature in Celsius.
Retrieves the user's current position using GPS.
Provides animated weather conditions using Lottie animations.
Responsive design with support for dark mode.

## Technologies Used
- Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- Dart: The programming language used to write the application.
- OpenWeatherMap API: A service that provides weather data for any location worldwide.
- Geolocator: A Flutter plugin for getting the current location of the device.
- Geocoding: A Flutter plugin for converting coordinates into human-readable addresses.
- Lottie: A library for rendering animations in the app, providing smooth and lightweight animations. `[Lottie](https://lottiefiles.com/)`


## Installation
To run this app locally, follow these steps:
1. Clone the repository
2. Install dependencies: Ensure you have Flutter installed on your machine. Then run: flutter pub get
3. Obtain API Key: Sign up for an API key from OpenWeatherMap(https://openweathermap.org/).
4. Configure API Key:
   Replace the placeholder API key in the weather_page.dart file:
   (Line 16) final _weatherService = WeatherService('YOUR_API_KEY_HERE');
6. Run the app: You can run the app using the following command: flutter run


## Usage
Upon launching the app, it will request permission to access your location. Once permission is granted, it will fetch and display the current weather for your location, including the city name and temperature.

## Screenshots

## Contributing
Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request.

## License
This project is licensed under the MIT License.

## Contact
For any inquiries or feedback, please feel free to reach out:
Email: amodom132@gmail.com
