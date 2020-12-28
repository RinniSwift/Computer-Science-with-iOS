
# URL Components

`URLComponents` is a struct that parses and contructs URLs from their smaller parts

An advantage of `URLComponents` over `URL` is that when inspecting the URL on a URLComponent, you can inspect the query and query items, unlike URL where you can't.

URL components in Swift are comprised of
- scheme
- host
- path
- URLQueryItems

<img src="/Images/urlComponents.png" width="900"/>

*This image is from an article I published on [creating a clean networking layer in Swift 5](https://medium.com/hackernoon/about-the-networking-layer-in-swift-5-4bb2704a1a4f)*.\
*And implemented in a [sample app here](https://github.com/RinniSwift/NetworkChallenge)*.
