*[previous page: types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/types.md)*

# UIKit

## View Hierarchy

The system uses a tree data structure where the root node is the window. layer contains NSArrays for representing subviews within the layer.

When user interaction occur, the view hierarchy gets traversed starting from root first, which is the UIWindow.

> **UIWindow** is the backdrop for your app’s user interface and the object that dispatches events to your views.\
> [Apple docs](https://developer.apple.com/documentation/uikit/uiwindow)

### Hit testing

The function signature:
```
func hitTest(_ point: CGPoint, 
            with event: UIEvent?) -> UIView?
```

Hit-testing is UIKit's touch handling subsystem which is an algorithm that traverses the view hierarchy and finds/returns the deep most view that contains within the touch point and nil if it was completely outside the recievers view hierarchy.\
The deep most view in the view hierarchy will equate to the front most view on the user's screen.

This method traverses the view hierarchy by calling the `point(inside:with:)`, *a UIView instance method which returns bool determining wether the view contains within the specified point with the touch event*, method of each subview to determine which subview should receive a touch event.

**properties on the view that will be ignored in hit-testing**\
`isHidden` property is true\
`userInteractionEnabled` property is false\
`alpha` is less than 0.01

> `userInteractionEnabled = false` on a view cascades down it's subviews.
> All subviews will have *userInteractionEnabled* equal to false as well.

How hit testing might look under the hood:

```swift
override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard self.point(inside: point, with: event) else {
        return nil
    }

    guard alpha >= 0.01, isUserInteractionEnabled, !isHidden else {
        return nil
    }

    for subview in subviews.reversed() {
        if let hitView = subview.hitTest(point, with: event) {
            return hitView
        }
    }
    return nil
}
```

When you're dealing with complex views that you might want to handle more of the user interaction. you can override `hitTest:withEvent` or `pointInside:withEvent:` to achieve more custom user interactions. One thing that may come of help here is when you set a views `isUserInteractionEnabled = false`, this makes all of it's subviews to be disregarded.


## View Lifecycles

*view controller lifecycle is an event with several steps from the point of creation to deletion.*

> **viewDidLoad**\
> Notifies view controller that the view has been created and loaded into memory.\
> There shouldn't be any code that sets the frames or bounds of a child view as this function doesn't assure that the view has already been added to the user interface.
>
> **viewWillAppear**\
> Notifies view controller that the view is about to be added to a view hierarchy.
>
> **viewDidAppear**\
> Notifies view controller that the view has been added to a view hierarchy.
>
> **viewDidDisappear**\
> Notifies view controller that the view has been removed from a view hierarchy.
>
> **viewWillDisappear**\
> Notifies the view controller that it's view is about to be removed from a view hierarchy.
>
> **viewWillLayoutSubviews**\
> Notifies the view controller that it's view is about to layout subviews.\
> Call this method before the view lays out its subviews.
>
> **viewDidLayoutSubviews**\
> Notifies the view controller that it's view has just laid out its subviews.\
> Call this method after the view lays out its subviews to adjust the views subviews layout.
>
> **isBeingDismissed**\
> A Bool value indicating wether the view controller is being dismissed.
>
> **isBeingPresented**\
> A Bool value indicating wether the view controller is being presented.
>
> **isMovingFromParent**\
> A Bool value indicating wether the view controller is being removed from a parent view controller.
>
> **isMovingToParent**\
> A Bool value indicating wether the view controller is being moved to a parent view controller.


## Frame vs Bounds

both are properties of `UIView` and they both returb a `CGRect`

`CGRect` *is a rectangle containing their X and Y position and their width and height.*

A view's bounds refers to it's coordinates relative to it's own space. Whereas the frame refers to it's coordinate relative to it's parents space.

An example would be thinking of a view within the screen. the view is a subview of the screens view. and let's say that the view has a size of 100 by 100 — which is its CGPoint. whenever it moves within the view, the bounds will always stay the same. But the frame will change. since the frame of the view is relative to it's parent view, the X and Y position changes.

It's generally better to change the bounds and let UIKit calculate the frame for you.

Why knowing this is important:

- frame: to know where to place the view in the parent. Think of this when you're making outward changes like changing it's width or finding the distance between the view and the top of it's parent view.
- bound: to know the views content or subviews within itself. Thinl of this when you're making inward changes like drawing or arranging subviews within the view. Also use the bounds to get the size of the view if you have done some transformation on it.

## UITableView vs UICollectionView

The main differences would be how their layout. Tableviews only support vertical scrolling whereas collectionviews support both horizontal scrolling and vertical scrolling in the same collectionView. Tableviews are also easier to setup and simpler as they are less customizable than collectionviews. Collectionviews are more complex where as you'd use collectionviews if you want to achieve two way scroll within different sections of the collectionview.

**Commonalities**
- reuseIdentifier (`dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell`)\
Limits allocating new views for each row. As cells scroll off the view, they get enqueued onto an internal queue and from this function, we dequeue from that queue if there contains one. If not, it returns a newly allocated view.

## UITableView

*A view that presents data using rows arranged in a single column.*\
*[Apple Docs](https://developer.apple.com/documentation/uikit/uitableview)*

Tableviews display a single row of content which can be divided into seperate sections to make navigating easier. You can also provide header or footer views to provide additional information.

Tableviews are data driven and in order to maintain the up to date data, it's done through a data source object, `UITableViewDataSource`.

Which contains these **required** functions:
- `func tableView(UITableView, numberOfRowsInSection: Int) -> Int`
- `func tableView(UITableView, cellForRowAt: IndexPath) -> UITableViewCell`

and some additional APIs that allow functionality of:

- The number of sections and rows in the table
- The titles for section header and footers
- Responding to the user's updates that require changed to the underlying data

`cellForRowAt:` is where you'd usually configure the appropriate typed cell along with it's content. In here, use `dequeueReusableCell(withIdentifier:for:)` method to retrieve a cell object.\
When using custom tableviewcells, you would want to use either or of the following:

- `register(_:forCellReuseIdentifier:)`
- `func register(UINib?, forCellReuseIdentifier: String)`

When cells scroll of the screen, it calls the `prepareForResuse()` method.

Cell-reuse is a concept that is applied so a table view can reuse cells that it has already created. This minimizes the amount of view allocations needed. It would consume a lot of memory and be bad UX for having to wait for all the views to load in memory before.

A UITableViewCell object is only created when `dequeueReusableCell(withIdentifier:for:)` doesn't retrieve anything back -- there're no available reusable cells.

To manage the layout and data manipulation, use the delegate object, `UITableViewDelegate`.

It doesn't have any required functions and contains APIs that allow functionality for:

- Creating and managing custom headers and footers
- Specifying custom heights for rows, headers, and footers
- Responding to row selections
- Respond to swipes and other actions in table rows
- Support editing the table's content

Some common methods to use in UITableViewDelegate are:

- `func tableView(UITableView, didSelectRowAt: IndexPath)`
- `func tableView(UITableView, didDeselectRowAt: IndexPath)`
- `func tableView(UITableView, viewForHeaderInSection: Int) -> UIView?`
- `func tableView(UITableView, viewForFooterInSection: Int) -> UIView?`
- `func tableView(UITableView, heightForRowAt: IndexPath) -> CGFloat`
- `func tableView(UITableView, shouldHighlightRowAt: IndexPath) -> Bool`

You don't need to always use delegate methods to specify certain features of a tableview, you can call it on the propreties directly on the instantiated object for customization. Here's an example:

```swift
let tableView = UITableView(frame: .zero, style: .grouped)

tableview.separatorStyle = .none
tableview.showsVerticalScrollIndicator = false
tableview.backgroundView = someView()
tableview.rowHeight = // some CGFloat 
```

> `UITableView.Style` is an enum case that determines the tableview style.
>  
> - `plain`: the default style of a table view. Section headers and footers are displayed as inline separators and float when the table view is scrolled.
> - `grouped`: this makes section headers not clip to the top as you scroll, or as Apple docs calls "float" -- Section headers and footers do not float when the table view scrolls. 
> - `insetGrouped`: introduced in iOS 13 and above. The grouped sections have rounded corners.

#### Issues found in table view implementations

-  `viewForFooterInSection` and `viewForHeaderInSection` should also use the tableview's recycable method: `dequeueReusableHeaderFooterView`.
- Understanding threads and how you're updating UI. Make sure you run UI related code on the main queue.
- Checking if you can limit the call for `reloadData()` and call `reloadRows(at:with:)` or other methods that reload only a specific amount of cells.

#### Why you would want to use a tableview

- Table views keep the memory footprint low. Views added to the tableview stay in memory until the cell is scrolled off the screen.
- Can quickly reload, insert, reorder cells.

## UIScrollView

e.g. Photos or Maps

#### Why you would want to use a UIScrollView

- To display content with a vast area that you can zoom or scroll in any direction.


## UIVisualEffectView

*[next page: enums](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/enums.md)*
