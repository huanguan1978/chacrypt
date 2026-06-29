# Action Widgets

This directory contains standardized, reusable components for the application's action-based interface modules.

## Components

### ActionLayout
Enforces a consistent three-part vertical layout architecture across all action pages:
- **Header (`inputWidget`)**: Typically `MultiPath` or `SinglePath`.
- **Body (`actionWidget`)**: The central control area, usually wrapped in `ActionSection`, containing settings and the main action trigger.
- **Footer (`logWidget`)**: The status or log display area, often a `LogStreamView` or `BriefingView`.

### ActionSection
A standardized wrapper for action settings. It provides a consistent `Card` container with defined vertical padding and layout spacing, ensuring that all action forms follow the same visual hierarchy.

### ActionButton
The standard button component for executing actions. It encapsulates:
- **State Handling**: Automatic display of `CircularProgressIndicator` when `isProcessing` is true.
- **Visual Feedback**: Manages the icon and label rendering.
- **Consistent Styling**: Defaults to a standard `ElevatedButton` style but supports complete overrides via the `style` parameter for custom action types (e.g., destructive actions).

## Implementation Pattern
To add a new action page:
1. Wrap the page body in `ActionLayout`.
2. Encapsulate form controls in `ActionSection`.
3. Use `ActionButton` for the primary operation trigger.
