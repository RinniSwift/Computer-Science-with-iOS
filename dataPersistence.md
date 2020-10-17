*[previous page: closures](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/closures.md)*

# Data Persistance

## Local Persistance

### Core Data

Is a wrapper for the SQLite database and is used to save and present any type of user data.

Setting up Core data typically consists of creating a helper class that stores the persistent container, `NSPersistentContainer` which the class will be used for adding entities, fetching data, and removing entities.

### NSUserDefaults

Stores default information of the application or the user. Examples are saving the users selected primary page to show first where it should be persisted between app launches.

Main functionality

- `saveValue(forKey:value:userID:)`
- `readValue(forKey:userID:)`
- `removeObject(forKey:)`

### User Keychain

### File Manager

### Property List (Plists)

## Server Persistance

### Firebase

*[next page: software architectural patterns](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/softwareArchitectPatterns.md)*
