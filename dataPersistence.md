*[previous page: closures](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/closures.md)*

# Data Persistance

## Local Persistance

### Core Data

Is a wrapper for the SQLite database and is used to save and present any type of user data.

Setting up Core data typically consists of creating a helper class that stores the persistent container, `NSPersistentContainer` which the class will be used for adding entities, fetching data, and removing entities.

### UserDefaults

Stores default information of the application or the user. Examples are saving the users selected primary page to show first where it should be persisted between app launches.

Main functionality

- `saveValue(forKey:value:userID:)`
- `readValue(forKey:userID:)`
- `removeObject(forKey:)`

### User Keychain

### FileManager

An object that let's you examine contents in the file ststem and make changes to it.\
A file system handles the persistent storage of data files, apps, and the files associated with the operating system itself.

<img src="/Images/ios_app_layout.png" width="400"/>

During installation of a new app, the installer creates a number of container directories within the sandbox directory.\
&nbsp;&nbsp; - **Bundle container directory** which holds the app's bundle -- app and all it's resources.\
&nbsp;&nbsp; - **Data container directory** which is further divided into multiple subdirectories the app can use to sort/organize data storage.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - **Documents** store user generated content that will be exposed by the user.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - **Library** store files that you don't want to expose to the user.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - **Temp** store temporary files that don't need to persist between app launches.\
&nbsp;&nbsp; - **iCloud container directory** an additional container directory.

#### Where you should put your app's files

Put user data in `Documents\` directory. This directory contains files that the user can create, import, delete, or edit.\
Put app-created support files in `Library/Application support/`. This should contain files that are needed for the app to run that should be hidden from the user.

> Callout: `Documents\`  and `Library/Application support/` directories are backedup by default which can sometimes consume a large amount of user's storage and can encourage the user to delete the app or disable back up. So when storing large files, it's encouraged to avoid including them from being backed up.\
> To exclude backing up, use `-[NSURL setResourceValue:forKey:error:]` using the `NSURLIsExcludedFromBackupKey key`

Put temporary data in `tmp/`. This contains files that do not need to persist for an extended amount of time.

### Property List (Plists)

## Server Persistance

### Firebase

*[next page: software architectural patterns](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/softwareArchitectPatterns.md)*
