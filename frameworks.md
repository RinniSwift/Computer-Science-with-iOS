*[previous page: software architectural patterns](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/softwareArchitectPatterns.md)*

# App Frameworks / Libraries

## Built in Apple Frameworks

- **`SafariServices`**
- **`MapKit`**
    - **`CoreLocation`**
- **`Foundation`**
- **`UIKit`**
- **`UserNotifications`**

    Apple allows push notifcations through APNS, Apple Push Notification Services. In order to recieve notifications, you'd have to register the apns token to server and create a class that will conform to `UNUserNotificationCenterDelegate`. Where you would create the instance in the app delegate in userDidFinishLaunching() and you should recieve a delegate function when users enable push notifications through the delegate function `applicationDidRegisterForRemoteNotificationsWithDeviceToken`

- **`CoreBluetooth`**

    Provides classes needed for the app to communicate with devices that are equiped with BLE, Bluetooth Low Energy, *only

- **`CoreData`**

    Must create a layer between communicating with the persistance object to save, retrieve, and remove data.

- **Deep Linking**

    When there's an external platform that calls the app, it will call the UIApplicatedDelegates function `openURL` which you can then handle whatever you want to happen within the app like linking to a specific controller. But with keeping in mind if there's existing controllers that are already presented.

## External Frameworks

- **`SnapKit`**
- **`SwiftyJSON`**

    what are some built in ways to do this?

- **`Alamofire`**
- **Testing**
    - **`Quick`**

        behaviour driven testing framework

    - **`Nimble`**

        express expected outcomes

*[next page: testing](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/testing.md)*
