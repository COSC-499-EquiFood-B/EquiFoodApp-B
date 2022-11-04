# EquiFood App

## Context
Project Equifood tries to reduce food wastage and promotes sustainable food systems in Kelowna. The designed app will help to reduce food wastage by donating leftovers from restaurants.

## Description 
The students will build a mobile app that would connect restaurants with individuals in order to allow the individuals to obtain the restaurants' food leftovers for free or at a significantly reduced price. 

The app will also streamline EquiFood's current donations tracking process, as it will automatically keep track of the money amount worth of food that EquiFood has contributed to donating via its restaurant partners, which is currently done manually.  

The system will involve three types of users:

- **Individuals**: anyone who signs up on the app to be connected to restaurants or food chains and obtain food donations.
- **Restaurant representatives**: restaurant managers or their delegate who are able to post donations onto the system and manage their restaurant’s information in the EquiFood app. These users must be vetted by the administrators.
- **Administrators**: members of the EquiFood team who can approve restaurant managers and view the donation amounts.

## Gantt Chart
Click [here](https://github.com/COSC-499-EquiFood-B/EquiFoodApp-B/blob/d826f26935d77273503aef18e6ba02f6b407e75d/Gantt%20Chart%20Oct%2031-Nov%204.png) for this week's Gantt Chart.


## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

### IMPORTANT:

For projects with Firestore integration, you must first run the following commands to ensure the project compiles:

```
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This command creates the generated files that parse each Record from Firestore into a schema object.

### Getting started continued:

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
