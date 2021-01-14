*[previous page: higher order functions](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/higherOrderFunctions.md)*

# Closures

Closures that are marked as *escaping* mean that they will outlive the function

Closures are *non-escaping* by default. 

Some examples of closures that will outlive the function scope are:

- performing asynchronous tasks — switching queues. (main thread/ background thread)

*escaping* really just signals that the closure will outlive the scope of the recieving function so the caller must take precautions against retain cycles and memort leaks.

Using closures to communicate between view controllers:

```swift
typealias CompletionHandler = (_ services: [Service]) -> ()

class NetworkModel {
        var services
        var didCompleteNetworkCall: CompletionHandler?

        func getServices() {
            // some logic to set self.services
            didCompleteNetworkCall(services)
        }

        // ... 
}

class ServicesViewController: UIViewController {

        let networkModel = NetworkModel()
        var services: [Service] {
            didSet {
                page.services = services
            }
        }
        var page: ServicePage! // Check the Atomic Design Pattern

        override func loadView() {
            page = ServicePage()
        }

        func loadServices() {
            networkModel.didCompleteNetworkCall = { [weak self] services in
                self?.services = services
            }
            networkModel.getServices()
        }
        
        // ...
}
```

Whenever defining an *escaping closure*, it'll implicitly capture any objects, values, functions that are referenced within it's scope. And since escaping closures not always return right away, memory issues can arise.

let's say within our view controller we have an asynchronous network call which passes back a value and that takes roughly 5 seconds, depending on your connectivity and we want to change properties of the view controller based on the returned value. We're not gauranteed that the the outer scope of the closure -- the object that holds the closure --, -- the view controller -- still exists in memory. i.e. It got dealloced.

```swift
// within some view controller scope
func getServices() {
    // calling a class func on `ServiceLayer` object.
    ServiceLayer.request(router: Router.getServiceInfo) { (result: Result<[Service], Error>) in
        switch result {
        case let .success(services):
            self.services = services
        case .failure:
            // do something with failure case
        }
    }
}
```

Since the closure is capturing self strongly, given that the view controller can be dealloced, this can cause a [retain cycle](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/memoryManagement.md#retain-cycles), preventing both objects from ever getting deallocated (since they can’t reach a reference count of zero).

Here's when we can introduce **capture lists** to break the strong reference cycles like below:

```swift
ServiceLayer.request(router: Router.getServiceInfo) { [weak self] result in // not explicitly stating the result type like I did above.
    switch result {
    case let .success(services):
        self?.services = services // weak sets the object to be optional. i.e. must be unwrapped to call it's the property.
    case .failure:
        // do something with failure case
    }
}
```

*[next page: error handling](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/errorHandling.md)*
