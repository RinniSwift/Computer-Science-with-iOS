*[previous page: data persistence](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/dataPersistence.md)*

# Software Architectural Patterns

*for creating iOS apps*

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
