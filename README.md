#CoreDataKit

CoreDataKit is a small convenience wrapper framework written in Swift.


## The Stack

The `CDKStack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. In the following example a fully functional stack is instanciated, popullated with a persistent store and made into a shared instance.

### Instantiation

A `CDKStack` will by default initialize with a merged Model from all Bundles but can be initialized with an optional Model.

```objc
CDKStack *stack = [[CDKStack alloc] init];

NSManagedObjectModel *model = [[NSManagedObjectModel alloc] init];
CDKStack *stack = [[CDKStack alloc] initWithModel:model];
```

### Store

Adding a store will by default initialize an SQLite store named after the main bundles executable.

```objc
[stack addStore];
```
