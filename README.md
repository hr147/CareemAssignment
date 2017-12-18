# Movie Search List
 

## Project Overview

This project is developed using MVVM archtecture along with flow-controllers pettern to manage navigations.

### Prerequisites

- xcode 9.2
- swift 4
- carthage

### Code Structure & Sequence

- Dependencies injected (Core Data , Alamofire , View Model , Data Stores) in following files
   
   ```
   DependencyRegistry.swift
   SwinjectStoryboard+Extensions.swift
   
   ``` 
- First Storyboard Setup

   ```
   Movie.storyboard
   
   ```
- Initial Controller & ViewModel 

 ```
   MovieSearchViewController.swift
   MovieSearchViewModel
   ```


## Libraries Used

* [Swinject](https://github.com/Swinject/Swinject) - for Dependency injection
* [Alamofire](https://github.com/Alamofire/Alamofire) - for networking
* [Kingfisher](https://github.com/onevcat/Kingfisher) - for downloading and caching images 


## Authors

* **Haroon Ur Rasheed** 
