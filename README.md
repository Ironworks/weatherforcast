# weatherforcast
Simple 5 day weather forecast for London

To run this project clone this repository 
Open the OpenWeather5Day.xcodeproj in XCODE
Select a simulator and run.

To run the tests use command-U, to run the test suite 


## Approach taken

I have used a simple MVVM architecture for this app. Given as it is a simple app I opted to use Storyboards for the layout although I usually tend to do the layout in code to avoid merge issues. 
As the navigation is simple I decided against using a coordinator in the app, again this is something I would look to use in a more complex app.I have written tests for the network client, the objectFactory and the mainViewModel, but haven't for other parts of the code as I concentrated on getting a working app within the time constraints.

## Potential enhancements

Given more time I would have done the following: 

* Allowed the user to enter a city and request the weather forecast for that city
* Grouped the forecasts by day on the tableView. 
* Added more tests around the viewController and the extensions I wrote
* Add tests around the 
* Built a better UI, potentially using images to represent the weather conditions
* Implemented a coordinator to allow navigation in the app to be easily extended


