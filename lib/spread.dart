library spread;

/// An abstract class representing a generic entity.
///
/// This class serves as a foundation for other entities requiring a unique identifier.
/// All subclasses must implement the `entityId` property, which acts as a unique ID.
export 'package:spread_core/spread_core.dart' show Entity;

/// A mixin named `StateEmitter` designed to facilitate state emission.
///
/// This mixin provides methods to emit states in various ways - by type, by a named identifier,
/// or based on an entity. It interacts with the `SpreadState` to dispatch these emitted states.
export 'package:spread_core/spread_core.dart' show StateEmitter;

/// An abstract class named `SpreadObserver` designed for observing state changes of type `T`.
///
/// This class serves as a base for other classes aiming to observe specific state types.
/// Classes extending `SpreadObserver` should provide an implementation for the `onState` method,
/// which acts as a callback when the observed state type changes.
///
/// Generic Type:
///   - `T`: The type of state this observer is interested in.
export 'package:spread_core/spread_core.dart' show SpreadObserver;

/// Manages state storage and notifications in the Spread framework.
///
/// `SpreadState` offers a singleton pattern, ensuring a single point of state storage and
/// management. States can be stored based on type, name, or associated entities.
/// It also offers subscription mechanisms to listen to state changes.
export 'package:spread_core/spread_core.dart' show SpreadState, Subscription;

/// Represents an abstract use case in the application.
///
/// A use case signifies a single unit of business logic or domain logic. It embodies a specific
/// task or action the application can perform. Classes that extend `UseCase` are expected
/// to provide a concrete implementation for the `execute` method, indicating how the use case
/// operates when invoked.
export 'package:spread_core/spread_core.dart' show UseCase;

/// The `Spread` widget invokes a build function when a state event
/// is received. The state type is defined by the TypeParameter <T>`.
///
/// This widget can be used with a specific type or with the `dynamic` type. If a specific type
/// is not provided (i.e., `dynamic`), a `stateName` must be specified. Optionally, an `Entity`
/// can be associated with this widget.
///
/// The `builder` function is required and provides a means to build the widget in relation to
/// its held data of type `T`.
///
/// Optionally, you can provide state condition function to control if the widget must be rebuilt or not.
///
/// Generic Type:
///   - `T`: The type of data this widget deals with.
export 'src/spread_builder.dart' show Spread;
