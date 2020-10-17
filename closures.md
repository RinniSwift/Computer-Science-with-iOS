*[previous page: uikit](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/ui.md)*

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

*[next page: uitableview vs uicollectionview](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/uiTableViewVsUICollectionView.md)*
