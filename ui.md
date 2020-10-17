*[previous page: types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/types.md)*

# UIKit

## View Hierarchy

The system uses a tree data structure where the root node is the window. layer contains NSArrays for representing subviews within the layer.

When user interaction occur, the view hierarchy gets traversed starting from root first, which is the UIWindow.

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

The main differences would be how their layout. Tableviews only support vertical scrolling whereas collectionviews support both horizontal scrolling and vertical scrolling in the same collectionView. Tableviews are also easier to setup and simpler as I believe they're collectionviews under the hood with just less customable. Collectionviews are more complex where as you'd use collectionviews if you want to achieve two way scroll within different sections of the collectionview.

*[next page: enums](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/enums.md)*
