# FABiOS

A simple floating action button for iOS.

Tries to mimic the FAB on Android L

On clicking the FAB the menu buttons show up.

This was put together over the course of a few hours.
Not much is customizable right now and I intend to improve the API as I go along.

## Screenshots
![Example](http://i.imgur.com/uN75tvT.gif)


## Installation

Copy the ADDZFabView .h and .m files to your project and use them.

## Usage

Init a new FABView

````
fabView = [[ADDZFabView alloc] init];
````
Add FAB Menu Buttons
````
[fabView setFABButtons:[[NSMutableArray alloc] initWithObjects:
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 1" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 2" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 3" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 4" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 5" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 6" AndImage:@"x"],
                                 nil]];
````
Set the delegate for click events
````
[fabView setDelegate:self];
````
Set the scrim color
````
[fabView setFABScrimColor:[UIColor blueColor]];
````
Add it to the subview
````
[fabView addToView:self.view];
````
Make it Visible
````
[fabView showFAB];
````
Toggle the FAB menu open and close
````
[fabView toggleFABMenu];
````
