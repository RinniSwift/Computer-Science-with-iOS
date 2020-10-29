*[previous page: pagination](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/pagination.md)*

# Access Control

Swift provides 5 levels of access control

- ***private*** code that is used within it's scope — function or class.
- ***fileprivate*** code that keeps the declaration private within the file.
- ***internal*** code that will be visible to other code within the same module.
- ***public*** code that will be visible and usable to different modules.
- ***open*** most open level of access control — to subclass and modify functionality from different modules.

If we want to share a class with another module — such as when having a main app with an SDK — you may want to mark it as public for it to be visible to the other class. But ☝️, in order to initialize it, we would also have to create a public initilizer since ***a classes (implicit) initilizer is internal by default***. But in order to subclass it and add more functionality to it, the class must be marked open to do so as well as functions that want to be able to be subclassed must be marked open.

Distinguising between open and public access level; 
***open*** is *public overidable*, 
***public*** is *public access*.

Properties and functions in an *open* class also must be marked *open* if you want to make it overridable. If they were marked *public*, it can be accessed but not overridable.

### Module

We've heard modules quite a lot. A module is a single project, framework, or bundle. Imagine a single xcode project being a single module.

As Apple says

A module is a single unit of code distribution — a framework or application that is built and shipped as a single unit and that can be imported by another module with Swift’s import keyword.

> ❓ **Questions**
> 
> - What is the default access level when you declare a new type, propery, or function?\
>   *Internal access level.*

> **Good reads**
>
> [Access Control](https://www.bobthedeveloper.io/blog/the-complete-understanding-of-access-control-in-swift)

*[next page: types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/types.md)*
