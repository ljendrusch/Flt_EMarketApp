## Project Docs Overview

A Flutter app is generally made up of webs of "widgets," i.e. UI elements, that make screens, and tools to route between screens and handle important data. This project has been structured to reflect this. Additionally, this project utilizes header files - also called barrel files - to facilitate simple linking of the myriad class files. All header/barrel file names in this project end with "_h."

Below you will find a detailed explanation of the class files (.dart) in the parent directory (/lib) and a general explanation of what contect can be found in each of its sub-directories.

Note: Generally, the only files outside of the lib folder that a Flutter app developer is concerned with are pubspec.yaml and analysis_options.yaml. pubspec.yaml defines project dependencies, such as the "http.dart" package, and analysis_options.dart customizes IntelliSense and compiler warning/error settings. Other files and directories, such as /android and /windows, are mostly settings, definitions, or software data on how to turn Flutter code into an executable app, and editing any such file must be done with care.

## Parent Directory (/lib) Class Files

- [global_h.dart] A dual-purpose universal header/barrel file and global constant variable collection.
- [inventory_app.dart] Boiler-plate code to define this project as a "Material" app and bind important connective tissue to it, such as light-theme/dark-theme definitions, how to move between screens (routing), and instantiation of overhead data "Providers."
- [main.dart] Sets up local storage and starts the app. The entry-point for running Flutter code.

## Sub-Directories

- [/crafted_widgets] Custom-made UI elements, i.e. "widgets", that are used in many places and screens throughout the app.
- [/models] Class definitions of important data pieces and helper functions to facilitate transporting them to and from the internet.
- [/providers] Overhead data clouds that communicate with the internet or local storage and incite subscribed widgets to change to reflect changes in data.
- [/screens] Definition of all screens shown in the app.
- [/setup] Miscellaneous code that either extends functionality of Dart/Flutter code, defines type defaults or dummy data for debugging, or defines the app connective tissue that inventory_app.dart calls.



## Flutter Code-Editing, Debugging, and Testing Set-Up
## Installation
Select the operating system on which you are installing Flutter:

- [Windows](https://docs.flutter.dev/get-started/install/windows)
- [macOS](https://docs.flutter.dev/get-started/install/macos)
- [Linux](https://docs.flutter.dev/get-started/install/linux)
- [Chrome OS](https://docs.flutter.dev/get-started/install/chromeos)

## Set up an editor
You can build apps with Flutter using any text editor combined with command-line tools. However, we recommend using one of our editor plugins for an even better experience; particularly VS Code. These plugins provide you with code completion, syntax highlighting, widget editing assists, run & debug support, and more.

- [Android Studio and IntelliJ](https://docs.flutter.dev/get-started/editor?tab=androidstudio)
- [Visual Studio Code](https://docs.flutter.dev/get-started/editor?tab=vscode)
- [Emacs](https://docs.flutter.dev/get-started/editor?tab=emacs)

## Set up a device
To run a Flutter app you need a device; either an emulator or a physical device. Read the following guides to set up an emulator or set up a physical device for use with app debugging.

- [Android Emulator via Android Studio](https://docs.flutter.dev/get-started/install/windows#android-setup)
- [Physical Android Device](https://docs.flutter.dev/get-started/install/windows#set-up-your-android-device)
- [IOS Emulator - Mac machines only](https://docs.flutter.dev/get-started/install/macos#set-up-the-ios-simulator)
- [IOS Device - Mac machines only](https://docs.flutter.dev/get-started/install/macos#deploy-to-ios-devices)

Note: To use an IOS device, physical or emulated, you need to configure a Podfile in /ios. First, run the app and a Podfile will be generated.

    `flutter run`

Then find the Podfile in /ios, uncomment line 2 and change the version number in line 2 to 13.0. More information may be found here:

- [Creating an IOS App](https://docs.flutter.dev/deployment/ios#create-a-build-archive)

## Run the app
1. Open a terminal and go to the app directory (the folder containing /lib and pubspec.yaml)
2. Check that a device is running.

    `flutter device`

3. Run the app with the following command:

    `flutter run`
