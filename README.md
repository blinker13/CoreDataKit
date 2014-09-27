#CoreDataKit

CoreDataKit is a small convenience wrapper framework written in Swift.


## The Stack

The `Stack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. In the following example a fully functional stack is instanciated, popullated with a persistent store and made into a shared instance.

### Instantiation

A `Stack` will by default initialize with a merged Model from all Bundles but can be initialized with an optional Model.

```swift
let stack = Stack()

let model = NSManagedObjectModel()
let stack = Stack(model)
```

### Store

Adding a store will by default initialize an SQLite store named after the main bundles executable.

```swift
stack.addStore()
```

Creating an in memory store is as easy as:

```swift
stack.addStore(NSInMemoryStoreType)
```


Most of the time we need only one shared stack in the whole application, therefore we can share our stack and make it accessible everywhere in our application. Most of the convenience methods in CoreDataKit will by default use the shared stacks main context.

```swift
stack.share()

let mainContext = Stack.shared.mainContext
```

## NSManagedObject Extensions

For faster inserts, fetches, etc, CoreDataKit introduces a few convenient class methods on `NSManagedObject`. By default the `Stack.shared.mainContext` is beeing used.

```swift
let newUser = User.insert()
let allUsers = User.fetch()
let userCount = User.count()
User.delete()
```


