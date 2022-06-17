## User Search

This is a simple one screen project presented to **youtap.com**. 

In this project I have used a **Layered Hexagonal Architecture**.

### Demonstration:

<img src="https://github.com/Mezo0099/youtap_user_search/blob/main/Demo.gif?raw=true" height="600px" width="350px"/>

> Realtime Full Demonstration

### Dependencies:
* Flutter 2.10 SDK
* shared_preferences: ^2.0.15
* dartz: ^0.10.1
* flutter_bloc: ^8.0.1
* get_it: ^7.2.0
* http: ^0.13.4
* connectivity_plus: ^2.3.4

### Data Flow:

The app is divided into three layers 
* **Core** 

All layers can depend on the classes in this layer it is the Core of the app and is not feature dependant.
This layer is purly Dart except for the Common Folder. 
* **Data** 

The middle layer of the app only the Presentation Layer can depend on the classes in this layer.
This layer is also pure dart.
* **Presentation**

This is the Outermost Layer none of the other layers can depend on it.
This layer is divided into features where each feature is made of two layers **Domain** (containing the feature service) and **Presentation** (Containing the feature UI Controller/Manager and the UI itself).


