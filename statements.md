*[previous page: access control](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/accessControl.md)*

# Statements

In Swift there're three statements

- **simple statements** consists of either an expression or declaration.
- **compiler control statements** allow the program to change aspects of the compiler’s behavior.
- **control flow statements** are used to control the flow of execution in a program.

## Loop statements

#### for-in statement

```swift
for .item. in .collection. {
    .statements.
}
```

#### while-statement

```swift
while .condition. {
    .statements.
}
```

#### repeat-while-statement

```swift
repeat {
    .statements.
} while .condition.
```

## Branch statements

#### if-statement

```swift
if .condition. {
    .statements.
}
```

*The condition of the if-statement must be of tpye Bool or optional binding declaration.*

#### guard-statement

A guard statement is used to transfer program control out of a scope if one or more conditions aren’t met.

```swift
guard .condition. else {
    .statements.
}
```

Any constants or variables assigned a value from an optional binding declaration in a guard statement condition can be used for the rest of the guard statement’s enclosing scope.

The else clause of a guard statement is required, and must either call a function with the Never return type or transfer program control outside the guard statement’s enclosing scope using one of the following statements:

> - return
> - break
> - continue
> - throw

#### switch-statement

```swift
switch .control statement. {
    case .pattern one.:
        .statements.
    case .pattern two.:
        .statements.
    case .pattern three.:
        .statements.
    default:
        .statements.
}
```

The control statement is matched with each case and executes the statements that fall in the case. If no cases are found, the default statements are executed. The program executes only the code within the first matching case in source order.

The statements can't be empty and you must include at least one statement. Use the `break` statement if you don't intend to do anything and use the `fallthrough` statement if you want the statement to execute in the next case.\
Read more on enums [here](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/enums.md)

You can add `where` clause after each pattern. Declare the `where` keyword followed by an expression.

Patterns can also bind constants or variables to be referenced later on. i.e. in the `where` clause.

**Switch Statements Must Be Exhaustive** where every possible value of the control expression’s type must match the value of at least one pattern of a case. Which may have to end up adding the default case such as `Int` type where it's not feasible to include all cases.

**Switching over future enumeration cases**

*Frozen enums* are frozen in size and frozen in composition. Meaning that there's a set of expected unchangeable cases.
*Non-Frozen enums* contain changeable cases. And when switching through, you must provide a default value as the compiler knows that there can be future cases added. Therefore, your switch statement must include either `default` or `@unknown default`.

`default` and `@unknown default` both handle cases that aren't explicitly specified, but `@unknown default` differs in how it will show a warning of any non handled existing case.

> The reason for frozen and non frozen is API's evolve and this is a handy way to determine wether there will be other cases.


## Labeled statements

You can prefix a loop statement, an if statement, a switch statement, or a do statement with a statement label, which consists of the name of the label followed immediately by a colon (:).

i.e.
```swift
outerLoop: for _ in 1...3 {
    for _ in 4...6 {
        continue outerLoop // OR break outerloop
    }
}
```

You can use the break or continue statement followed by a label name to have more control over the control flow.

## Control transfer statements

Control the order in which code is executed by transferring it to other parts. There are 5 control transfer statements:

- `break-statement`
- `continue-statement`
- `fallthrough-statement`
- `return-statement`
- `throw-statement`

## Defer statements

A defer statement is used for executing code just before transferring program control outside of the scope that the defer statement appears in.

See an example of how I use a defer statement [here](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/sequence.md#create-one-yourself).

The statements within the defer statement are executed no matter how program control is transferred. This means that a defer statement can be used, for example, to perform manual resource management such as closing file descriptors, and to perform actions that need to happen even if an error is thrown.

## Do statements

## Compiler Control Statements

## Availability Condition

When calling API's in your project, Swift will check if the usage is available in the minimum iOS deployment target (Can be found in your project info folder), if it's not, you'll receive an error. In that case, you can just bump your minimum supporting version to the latest / the version the API supports, or, add checks since you probably don't want to be limiting yourself from using the new API.

You can execute this code below

```swift
if #available(iOS 13, *) {
    // is executed if platform is running iOS 13 or above, from the * sign.
    // use API
} else {
    // use another API
}
```

**If you're writing more low level code and want to specify your API to be called from a certain iOS**, you mark the function or class with `@available`

```swift
@available(iOS 13, *)
func iOS13Supported() {
    // ...
}
```


*[next page: types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/types.md)*
