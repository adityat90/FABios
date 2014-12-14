//
//  ViewController.m
//  FabDemo 1
//
//  Created by Sunil N. Talpade on 12/12/14.
//  Copyright (c) 2014 Aditya Talpade. All rights reserved.
//

#import "ViewController.h"
#import "ADDZFabView.h"

@interface ViewController () <FABButtonDelegate>

@property (strong, nonatomic) ADDZFabView *fabView;

@end

@implementation ViewController

- (ADDZFabView *)fabView
{
    if (!_fabView) {
        _fabView = [[ADDZFabView alloc] init];
        [_fabView setFABVerticalDirection:FABVerticalDirectionBOTTOM HorizontalDirection:FABHorizontalDirectionRIGHT];
        [_fabView setFABButtons:[[NSMutableArray alloc] initWithObjects:
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 1" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Element 2" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Mon, 15 Dec" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Tue, 16 Dec" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Wed, 17 Dec" AndImage:@"x"],
                                 [[ADDZFABButton alloc] initWithTitle:@"Thu, 18 Dec" AndImage:@"x"],
                                 nil]];
        [_fabView setDelegate:self];
//        [_fabView setFABScrimColor:[UIColor blueColor]];
    }
    return _fabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fabView addToView:self.view];
    [self.fabView showFAB];
}

- (void)fabButtonClickedAtIndex:(NSInteger)index
{
    NSLog(@"Fab Button clicked at index: %d", index);
}

- (IBAction)buttonClicked:(id)sender {
    [self.fabView toggleFABMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
