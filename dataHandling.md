*[previous page: optionals](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/optionals.md)*

# Passing data between view controllers

View controllers contain a lot of information. And it would make sense for an app with many view controllers to have the same data. With some data in view controllers being inherited from others. There are multiple ways to do this as below.\
There are multiple examples to this. Some are - Populating an information page based on what service users select, and - Displaying images on new view controller based on what users searched. Both these examples use some form of code reuse or inheritance. Let's see some ways we can create this using some following choices below.

## Delegates and protocols
Also called as the delegation pattern. A high level would be where you create a protocol which will act as a collection of actions that any view controller can instantiate and access. Then different view controllers that want to have access to when the view controllers call the methods, can conform to the protocol and specify which view controllers they want to have access to from the protocol.\
\
Here are the steps to successfully set up the delegation pattern:
1. Declare a protocol. Which will contain the methods that will act as the delegation actions.
2. Create a delegate instance to the protocol in a view controller (*ViewControllerB*)
3. Conform another view controller (*ViewControllerA*) to the protocol.
4. Inform somehow that *ViewControllerB*'s delegate is tied to *ViewControllerA* to ensure data retrieval.
5. Actoins will occur whenever *ViewControllerB* calls methods on the delegate.

*ViewControllerA* would be actioned by *ViewControllerB*'s actions since it created that *ViewControllerB*'s delegate is of *ViewControllerA*'s. The delegation pattern allows in proficcient acess. Where a controller wants access based on other view controller's action. The delegator (*ViewControllerB*) will not need to know anything about the viewController but instead comminicates to the protocol and any viewController that sets conforms to the delegate, setting it to the delegator view controller, will have access to everytime the delegator calls a function (within the protocol).

#### Sample delegation pattern setup among two view controllers 

```Swift

protocol DataDelegate {
    func viewLoaded()
}

class ViewControllerA: UIViewController, DataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func viewLoaded() {
        print("delegator view loaded")
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewB = storyboard.instantiateViewController(withIdentifier: "viewControllerB") as! ViewControllerB
        viewB.delegate = self
        
        self.present(viewB, animated: true, completion: nil)
    }
}

class ViewControllerB: UIViewController {
    
    var delegate: DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.viewLoaded()
    }
}
```

Whenever *ViewControllerB* is instantiated from *ViewControllerA*, by specifically stating the delegate is of *ViewControllerA*'s, the `viewLoaded` with get called in *ViewControllerA*. Therefore, printing `"delegator view loaded"` in the console

> Note: \
> Wherever the delegator view controller is going to be presented, the delegate must be declared of which it belongs to. Or else the delegation would not work.

## Singleton

> Singletons are objects that should only ever be created once, then shared everywhere they need to be used

Singletons are a quick and easy way to solve complex problems of sharing resources across  view controllers with few lines of code. It is also used widely across the iOS SDK. Such as: `UIApplication.shared`, `UserDefaults.standard`, `URLSession.shared`.\
*So, how do they work?* \
Singletons contian a static variable (global variable) that returns an instance of itself and the initializer is usually `private` to prevent creating new objects. Meaning the singleton will only get instantiated through the static variable.

#### Sample singleton creation 
```swift 
// reference type
class SingletonA {

    static let shared = SingletonA()
    private init() { }

    var username: String?
}

// value type
struct SingletonB {

    static let shared = SingletonB()
    private init() { }

    var username: String?
}
```

Singletons that are *reference types* and *value types* act differently. If you have familiarity with reference types, each instance has a reference to the same object. Therefore each instance accessing the same object's properties. Value types, on the other hand, creates new copies on instantiation. Therefore each object being unique to itself.\
View controllers can also be singletons.

#### Sample view controller singleton creation 
```swift
class ViewController: UIViewController {

    static let shared = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
```
This allows you to create an instance of `ViewController` by calling `ViewController.shared`. Keep in mind that the `ViewDidLoad()` will only be called once no matter how many times you instantiate it because it will be the same object.\
\
While it's easy to create and use singletons as a shared resource, it's global accesiblity can be harming in the following ways
- Does not support *seperation of concern*. Singletons can be used anywhere across the app which makes it hard to keep track of when a seperation is changed.
- Misuse of singletons. Without internal implementation of the singleton, developers can mistake this with assuming that instantiating it creates an isolated object.
- Singletons carry state for the entirety of the application.
- Hard to create tests for. Each sequence of method called on the singleton leads to the same internal state.


## Dependancy Injection

> Dependancy injection is a mechanism where an object receives its dependancies from another, external object.

Since dependancies are passed through other objects, the objects receiving dependancies (*client*) is isolated from impacting the dependancy implementation. Whereas the client can work with everything that supports the interface it expects.\
Most dependancies are passed to the client in the initializer and does not change throughout the clients life cycle.

#### Sample of creating a dependancy injection
```swift

struct Profile {

    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


class ViewControllerA: UIViewController {

    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile = Profile(name: "Swift", age: 20)
    }

    func passData() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewControllerB") as! ViewControllerB
        viewController.profile = profile
        self.present(viewController, animated: true, completion: nil)
    }
}


class ViewControllerB: UIViewController {

    var profile: Profile? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

In this example, `ViewControllerB` acts as the client and recieves it's dependancies(`Profile`) from `ViewControllerA` on instantiation. *ViewControllerA is injecting a Profile into ViewControllerB*. This makes it easy to understand that `ViewControllerB` depends on the `Profile`.



## Notification Center

> The observing pattern to inform registered observers when a notification comes in, using a central dispatch called Notification Center.

The Notification Center API is used to broadcast notifications whenever an action accurs. \
NotificationCenter uses named notifications to identify what event is either observed or triggered.\
Apple uses this for keyboard events.

Downsides of Notification Center:
- NotificationCenter is an obective-C API which makes the code fragile because of not being able to use generics to retain type safety.
- Does not supporty seperation of concerns. Notifications are broadcasted app-wide. This is really convenient but makes relationships between objects loose.



## KVO
## Instantiation / prepareForSegue / unwindSegue
