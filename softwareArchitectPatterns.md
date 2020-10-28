*[previous page: data persistence](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/dataPersistence.md)*

# Software Architectural Patterns

*for creating iOS apps*

## App Architecture
*The entire structure of the application. How applications are divided into different interfaces and layers. As well as the control flow and data flow paths between the different components.*

- The importance of app architecture:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - who constructs the model and views and connects the two.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how view actions are handled.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how the model data is applied to the view.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how the *view state* is handled.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how events flow through layers.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - expectations on whether components should have _compile time_ or _run time_ references to each other.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - how data should be read or mutated.

There are 2 common layers in app atchitecture:
- *Model Layer*:  Contains the applications contents which is in full control of the programmer without having to depend on any framework. Typically contains *model object*(any data used in the app) and *coordinating object*(objects that persist data on disk)
- *View Layer*:  The application dependent framework which makes the model layer visible and user interactable. Usually always uses UIKit or AppKit/SceneKit/OpenGL. The view layer typically forms a view controller hierarchy. Where views are structured like a tree where the screen is the trunk and branches out with smaller views toward the leaves.

#### Applications are a feedback loop
Since having to communicate between layers, there are 2 actions
- The *Interactive Logic* consists of the *view action*(user initiated event) which can lead to *model actions*(instruction to perform an action or update)
- The *Presentation Logic* consists of a *model notification*(usually triggered from the model action) which leads to *view change*

## Model-View-Controller

Apple's common design pattern which is built on top of *object oriented programming*.

As it's name, MVC is made up of 3 main objects

- Model: the data object.

    Examples of models are the networking layer(network error handling, URL construction, codable parsing), persistance layer, wrapper class/ factory class, constants(for UIColor, UIImage, NotificationCenter.Name), helper and extensions.

- View: layer for the UI. e.g. `UILabel` , custom views that are part of UIKit

    There's the seperation of concern where the ideal case, the view should know nothing about the data but rather deals with an abstracted data.

    Consider making a view reusable when you have multiple use cases. There're times you might create a view to be generic/reusable but it never actually being used anywhere else in the app.

- Controller: controls logic between the Model and View layer. Communicated through delegation/segues/dependancy injection.

    The controller also breaks into another type which is the ***model controller*** where the controller mostly only communicates with the model. Pretty much owns the model.

An example of component in UIKit that uses MVC is the UITableView where there's the delegates that communicate the abstracted data — UITableViewDataSource.

#### Discussion
There are two common problems to MVC: Observer pattern failures, and massive view controllers

1. **Observer pattern failures**: This is when the model and view fall out of synchronization. Common mistake is to read model value on construction and not subsribe subsequent noifications. Another is to change the view hierarchy at the same time of changing the model (assuming the result of the change instead of waiting for an observation on model change)\
\
*Improvements* Using KVO and notifications. We can use NotificationCenter and the concept of KVO together allowing us to combine the concepts of *set initial value* and *observe subsequent values* into a single pipeline. (example of where we would use this is with notification observers in the viewDidLoad which calls another @objc function) {pg.68} this reduces the number of change paths in our code.
2. **Massive view controllers**: MVC in particular can lead to large view controllers where it must contain the view layer responsibility and the model layer responsibility. When the entire file is a single class, any mutable state will be shared across the all parts of the file with each function having to cooperatively read and maintain the state to prevent inconsistency.\

## Atomic Design Pattern

The atomic design pattern is initially introduced for web applications but since they're similar, you can use them with mobile applications as well.

This is mainly focused around the interface being able to be broken down into finite set of elements.

The atomic design pattern is made up of 5 main objects
*Each relating to UI components*

- Atoms

    The smallest UI component in the app.

    Examples are; custom UILabel, UIButton

- Molecules

    A collection of atoms. This is usually a group of views that will general be together.

    Examples is a UIStackView which can consist of UILabel and UIImage, two UIButtons

- Organisms

    A collectionof components composed of groups of molecules and/or atoms.

    Examples of this is a custom page header.

- Templates

    An generic outline for displaying UI

    Examples are a tableview template, 

- Pages

    A collection of all or some of the above to configure a complete functional interface in the given space.

## Protocol Oriented Programming

Protocols play a big role in data abstraction. 

You can find a plarethra of places in Swift that use this desing pattern. Some are:

- UITableviewDelegate and UITableviewDataSource
- Codable wich supports two underlying protocols — Decodable, Encodable

The protocol oriented programming usually starts out from designing the protocol before moving to the classes. The protocol will ultimately be the abstracted core functionality for different classes and use cases.

Protocols are not inherited — they are conformd to.

Benefits of protocols

- Created high level abstraction with a template — no implementation.
- All types can conform to multiple protocols — huge benifit over class ingeritance.
- Seperation of Concern; you can create multiple protocols for very specific tasks.
- Protocol extensions; there may be a case where you need to create extra functionality, that's where you'd use protocol extensions. (Unlike class inheritance where you'd have to mdify the main parent class)

## Networking

How networking fits into an app. There are two ways to add networking support into our app. The first variant(*controller-owned networking*) removes the model layer and lets the view controller handle the network requests. The second variant(*model-owned networking*) retains the model of the *MVC* and adds a networking layer beneath it.
- *Controller-owned Networking*: This version fetches data directly from the network and the data is not persisted. The data is cached in memory in the view controller as a *view state*. Which means this will only work with a network connection. This way makes it difficult to share data between view controllers since controller-owned networking is independent on its own. (**in memory cache**) Unlike *model-owned networking* where they instead observe changes in the model.
- *Model-owned Networking*: This version retains the model layer of the *MVC* and serves as an offline cache for the data. Additionally, changes in the model are picked up from the controller using the observe pattern. An advantage to this is that all view controllers draw their data from the store and subsribe to its change notifications.

*[next page: app frameworks / libraries](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/frameworks.md)*
