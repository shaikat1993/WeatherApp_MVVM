# WeatherApp

I developed this App in one day time.
Here I used URLSession, RESTful API and animations.
The App follows MVVM Design pattern.

Libraries:
1. I used [Weatherbit](https://www.weatherbit.io/) API all of my weather needs. I accessed current weather data  and 7 day / daily forecasts for any location including over 376,000 cities. 
2. I used [Lottie](https://github.com/airbnb/lottie-android)
3. [ViewAnimator](https://github.com/marcosgriselli/ViewAnimator) packages and Core Animations to make animations also used URLSession for network data transfer tasks. 
4. I used SwiftyJSON(https://github.com/SwiftyJSON) to deal with JSOON Data.

When app starts, you can see city name, current temperature, sunrise, wind speed, rate of cloud, datetime (the city's own timezone) and weather forecast for 7 day. You can check the weather forecast of the city you want.


## Technology and structures
- [x] URLSession
- [X] RESTful API
- [x] Core Animation
- [x] CollectionView 
- [x] Auto layout
- [x] MVVM Pattern
- [x] Web services
- [x] [Lottie](https://github.com/airbnb/lottie-android)
- [x] [ViewAnimator](https://github.com/marcosgriselli/ViewAnimator)
- [x] [SwiftyJSON](https://github.com/SwiftyJSON)

Key Features of app:
- [x] LocationService: Utilizes the Location service class to access the current Latitude and Longitude of the App user, enabling the display of location-specific weather information.
- [x] Extensions: Includes extensions for String, Collection view, and view-related operations to streamline code and enhance functionality.
- [x] Incorporates Lottie files for animations and custom fonts to improve the visual appeal of the App.
- [x] Network Layer: Implements the WeatherAPI Service for seamless network communication, ensuring reliable retrieval of weather data.
- [x] Models: Includes Weather and Forecast Models for parsing JSON files and managing weather data efficiently.
- [x] LaunchScreen: Features a Launchscreen view controller with an animated launch animation, enhancing the initial user experience.
- [x] Collection View: Utilizes a Collection view and Collection cell to display a 7-day weather forecast, providing users with an overview of upcoming weather conditions.
- [x] Search Functionality: Implements a Search Textfield allowing users to search for specific cities and view their related weather information.
- [x] Error Handling: Introduces an Error view controller as a pop-up to gracefully handle any anomalies or errors that may occur during App usage.

Usage:
To use the Weather App:

1. Clone the repository to your local machine.
2. Install any necessary dependencies.
3. Build and run the project on your preferred iOS device or simulator.
4. Explore the various features and functionalities, including location-specific weather information, forecast display, and search functionality.

Recording of app:
https://www.loom.com/share/163cf553cef74584922477845647ec83?sid=e730454d-80fd-4c33-a039-407d2fb50229

Contributing:
Contributions to the Weather App project are welcome! Feel free to submit pull requests with any improvements, bug fixes, or new features.

License:
This project is licensed under the MIT License, allowing for open collaboration and usage.

Acknowledgments:
Special thanks to the creators of the libraries, APIs, and resources used in this project, as well as the community for their support and contributions.



