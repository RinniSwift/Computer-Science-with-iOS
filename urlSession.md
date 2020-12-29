*[previous page: url components](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/urlComponents.md)*

### URLSession

`URLSession` coordinates a group of related network tasks. provides APIs for downloading and uploading data indicated by URLs.

Tasks within `URLSession`s share a `URLSessionConfiguration` object which defines connection behaviour.

`URLSession` contain a `shared` instance object for basic requests. You can further customize the object by instantiating by defining a `URLSessionConfiguration`

> `URLSessionConfiguration` contains\
> `.default`: basically the shared instance object.\
> `.background`: used if wanting to perform uploads and downloads while the app is suspended.\
> `.ephemeral`: used for more secure sessions since they don't write caches, cookies, or credentials to disk.


`URLSession` contain `URLSessionDelegate` that provides information such as:\
&nbsp;&nbsp;&nbsp;Authentication failure\
&nbsp;&nbsp;&nbsp;Session became unavailable\
&nbsp;&nbsp;&nbsp;Events completed

`URLSessionTaskDelegate`\
`URLSessionWebSocketDelegate` which is derived from `URLSessionTaskDelegate` which recently has been introduced in iOS 13.


#### Some APIs

- `URLSessionConfiguration.waitsForConnectivity`\
This is a settable and gettable Bool variable that when set to true, the system will automatically wait some time to see if connectivity becomes available before starting the request.\
And control the timeout interval with the `timeoutIntervalForResource` property on the configuration.

- `URLSessionConfiguration.taskIsWaitingForConnectivity`\
Introduced in iOS 11. This is settable Bool value that when set to true, the URLSession waits until there's a network connectivity that's available before trying the connection.\
This is used pair with the `URLSessionTaskDelegate` where it contains `urlSession(_:taskIsWaitingForConnectivity:)` for some action.

