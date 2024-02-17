# Currency Converter


## Getting Started


**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/Abo-ghazalla/currency_converter.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `injectable` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Hide Generated Files

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:
```
**/*.freezed.dart
**/*.g.dart
**/*.config.dart
**/*.mocks.dart
```

### Libraries & Tools Used

* [Cached Network Image](https://pub.dev/packages/cached_network_image)
   I used it as it's the most popular and powerful library to work with network image. It show images from the internet and keep them in the cache directory
* [SQLite Plugin](https://pub.dev/packages/sqflite)
   sqflite and Hive are both popular choices for local database management in Flutter apps. While Hive offers simplicity and performance advantages through its NoSQL approach and in-memory operations, sqflite provides a more 
   traditional SQL-based approach and supporting complex queries and transactions. Therefore, I Used it to be suitable int this app for complex data manipulation, relationships between tables.



Here is the folder structure we have been using in this project

```
lib/
|- data/
|- di/
|- domain/
|- features/
|- utils/
|- widgets/
|- main.dart
```

## Features

This features contains all the application features, every feature has a separated folder as shown in example below:

```
converter/
|- data/
|- domain/
|- presentation/

```
  
