#CoreDataKit

CoreDataKit is a small convenience wrapper framework written in Swift.


## The Stack

The `CoreDataStack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. In the following example a fully functional stack is instanciated, popullated with a persistent store and made into a shared instance.

### Instantiation

A `CoreDataStack` will by default initialize with a merged Model from all Bundles but can be initialized with an optional Model.

```objc
CoreDataStack *stack = [[CoreDataStack alloc] init];

NSManagedObjectModel *model = [[NSManagedObjectModel alloc] init];
CoreDataStack *stack = [[CoreDataStack alloc] initWithModel:model];
```

### Store

Adding a store will by default initialize an SQLite store named after the main bundles executable.

```objc
[stack addStore];
```
