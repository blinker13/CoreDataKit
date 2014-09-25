CoreDataKit
===========

CoreDataKit is a small convenience wrapper framework written in Swift.


## Getting Started

### Stack

The `Stack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. In the following example fully functional stack is instanciated, popullated with a persistent store and made into a shared instance.

```swift
import CoreDataKit

let stack = Stack()
stack.addStore()
stack.share()
```
