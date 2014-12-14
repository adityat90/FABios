//
//  ADDZFabView.m
//  FabDemo 1
//
//  Created by Sunil N. Talpade on 12/12/14.
//  Copyright (c) 2014 Aditya Talpade. All rights reserved.
//

#import "ADDZFabView.h"
#define FABHEIGHT 50
#define FABWIDTH 50

@interface ADDZFabView () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *centerImageView;

@property (strong, nonatomic) NSMutableArray *fabButtons;

@property (strong, nonatomic) UIColor *scrimColor;

@property (nonatomic) FABVerticalDirection verticalDirection;

@property (nonatomic) FABHorizontalDirection horizontalDirection;

@property (strong, nonatomic) UIView *parentView;

@property (strong, nonatomic) UIView *scrimView;

@property (nonatomic) CGRect zeroFrame;

@property (nonatomic) CGRect scrimFrame;

@property (nonatomic) BOOL isFABOpen;

@property (nonatomic) BOOL isAnimating;

@property (strong, nonatomic) UIImageView *fabCenterImageView;

@property (strong, nonatomic) UITapGestureRecognizer *centerImageTapGesture;

@end

@implementation ADDZFabView

- (UITapGestureRecognizer *)centerImageTapGesture
{
    if (!_centerImageTapGesture) {
        _centerImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleFABMenu)];
        [_centerImageTapGesture setNumberOfTapsRequired:1];
        [_centerImageTapGesture setDelegate:self];
    }
    return _centerImageTapGesture;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0.0f;
        [self.fabCenterImageView addGestureRecognizer:self.centerImageTapGesture];
        
        self.isFABOpen = NO;
        
        self.verticalDirection = FABVerticalDirectionBOTTOM;
        self.horizontalDirection = FABHorizontalDirectionRIGHT;
        
        self.fabCenterImageView.layer.cornerRadius = FABHEIGHT / 2;
        self.fabCenterImageView.layer.masksToBounds = YES;
        
        self.isAnimating = NO;
    }
    
    return self;
}

- (UIView *)scrimView
{
    if (!_scrimView) {
        _scrimView = [[UIView alloc] init];
        [_scrimView setAlpha:1.0f];
        _scrimView.layer.cornerRadius = FABHEIGHT / 2;
        _scrimView.layer.masksToBounds = YES;
        [_scrimView setBackgroundColor:self.scrimColor];
    }
    return _scrimView;
}

- (UIColor *)scrimColor
{
    if (!_scrimColor) {
        _scrimColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.7f];
    }
    return _scrimColor;
}

- (CGRect)zeroFrame
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (self.verticalDirection == FABVerticalDirectionTOP) {
        y = 0.0f + 30;
    } else if (self.verticalDirection == FABVerticalDirectionBOTTOM) {
        y = self.parentView.frame.size.height - FABHEIGHT - 30;
    }
    
    if (self.horizontalDirection == FABHorizontalDirectionLEFT) {
        x = 0.0f + 30;
    } else if (self.horizontalDirection == FABHorizontalDirectionRIGHT) {
        x = self.parentView.frame.size.width - FABWIDTH - 30;
    }
    
    return CGRectMake(x, y, FABWIDTH, FABHEIGHT);
}

- (CGRect)scrimFrame
{
    return CGRectMake(0.0f, 0.0f, self.parentView.frame.size.width, self.parentView.frame.size.height);
}

- (UIImageView *)fabCenterImageView
{
    if (!_fabCenterImageView) {
        _fabCenterImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x"]];
        [_fabCenterImageView setBackgroundColor:[UIColor redColor]];
        [_fabCenterImageView setUserInteractionEnabled:YES];
    }
    return _fabCenterImageView;
}

- (void)setFABCenterImage:(UIImage *)image
{
    [self.centerImageView setImage:image];
    [self.fabCenterImageView setImage:image];
}

- (void)setFABButtons:(NSMutableArray *)fabButtons
{
    self.fabButtons = fabButtons;
    for (int i = 0 ; i < self.fabButtons.count ; i++) {
        [[self.fabButtons objectAtIndex:i] setIndex:i];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        [gestureRecognizer setNumberOfTapsRequired:1];
        [[self.fabButtons objectAtIndex:i] addGestureRecognizer:gestureRecognizer];
        
        [[self.fabButtons objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:CGColorGetComponents([self.scrimColor CGColor])[0] green:CGColorGetComponents([self.scrimColor CGColor])[1] blue:CGColorGetComponents([self.scrimColor CGColor])[2] alpha:1.0f]];
    }
}

- (void)buttonTapped:(UITapGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0 animations:^{
        [((ADDZFABButton *)[gesture view]) setBackgroundColor:[UIColor clearColor]];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [((ADDZFABButton *)[gesture view]) setBackgroundColor:[UIColor colorWithRed:CGColorGetComponents([self.scrimColor CGColor])[0] green:CGColorGetComponents([self.scrimColor CGColor])[1] blue:CGColorGetComponents([self.scrimColor CGColor])[2] alpha:1.0f]];
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(fabButtonClickedAtIndex:)]) {
        [self.delegate fabButtonClickedAtIndex:((ADDZFABButton *)[gesture view]).index];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isEqual:self.centerImageTapGesture]) {
        if (self.isAnimating) {
            return NO;
        }
    }
    return YES;
}

- (void)setFABScrimColor:(UIColor *)scrimColor
{
    self.scrimColor = scrimColor;
}

- (void)setFABVerticalDirection:(FABVerticalDirection)verticalDirection HorizontalDirection:(FABHorizontalDirection)horizontalDirection
{
    self.verticalDirection = verticalDirection;
    self.horizontalDirection = horizontalDirection;
}

- (void)addToView:(UIView *)view
{
    self.parentView = view;
    
    [self.parentView addSubview:self.scrimView];
    self.scrimView.frame = self.zeroFrame;
    
    for (ADDZFABButton *button in self.fabButtons) {
        [self.parentView addSubview:button];
        [button setFrame:CGRectMake(0.0f, self.zeroFrame.origin.y, self.parentView.frame.size.width, FABHEIGHT)];
        [button setAlpha:0.0f];
        [button setImageViewFrame:CGRectMake(button.frame.size.width - 70, 0.0f, 35, 40)];
        
        [button setLabelFrame:CGRectMake(100, 0.0f, button.frame.size.width - 70 - 35 - 10, 40)];
        
        [button.textLabel setAlpha:0.0f];
        [button.imageView setAlpha:0.0f];
    }
    
    [self.parentView addSubview:self.fabCenterImageView];
    self.fabCenterImageView.frame = self.zeroFrame;
}

- (void)showFAB
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)hideFAB
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    }];
}

- (void)toggleFABMenu
{
    self.isAnimating = YES;
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.isFABOpen) {
            [self performRecursiveHideMenuButtonsAnimation:0];
        } else {
            self.scrimView.frame = self.scrimFrame;
            [self.scrimView setAlpha:1.0f];
            
            self.scrimView.layer.cornerRadius = 0.0f;
            self.scrimView.layer.masksToBounds = YES;
            
            // Place what was cut here
            [self.fabCenterImageView setAlpha:0.5f];
            self.fabCenterImageView.transform = CGAffineTransformMakeRotation((90 * M_PI) / 180.0f);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            self.isFABOpen = !self.isFABOpen;
            if (self.isFABOpen) {
                [self performRecursiveShowMenuButtonsAnimation:0];
            } else {
            }
        }
    }];
}

- (void)performRecursiveHideMenuButtonsAnimation:(NSUInteger)index
{
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.isAnimating = YES;
        
        CGRect lowerRect = CGRectZero;
        
        if (index + 1 < self.fabButtons.count) {
            lowerRect = ((ADDZFABButton *)[self.fabButtons objectAtIndex:index+1]).frame;
            ((ADDZFABButton *)[self.fabButtons objectAtIndex:index+1]).frame = ((ADDZFABButton *)[self.fabButtons objectAtIndex:index]).frame;
        }
        
        CGRect tempRect = CGRectZero;
        for (int i = index+2; i < self.fabButtons.count; i++) {
            tempRect = ((ADDZFABButton *)[self.fabButtons objectAtIndex:i]).frame;
            ((ADDZFABButton *)[self.fabButtons objectAtIndex:i]).frame = lowerRect;
            lowerRect = tempRect;
        }
        
        [((ADDZFABButton *)[self.fabButtons objectAtIndex:index]) setFrame:CGRectMake(0.0f, self.zeroFrame.origin.y, ((ADDZFABButton *)[self.fabButtons objectAtIndex:index]).frame.size.width, FABHEIGHT)];
        
        [((ADDZFABButton *)[self.fabButtons objectAtIndex:index]) setAlpha:0.0f];
        [((ADDZFABButton *)[self.fabButtons objectAtIndex:index]).textLabel setAlpha:0.0f];
        [((ADDZFABButton *)[self.fabButtons objectAtIndex:index]).imageView setAlpha:0.0f];
        [((ADDZFABButton *)[self.fabButtons objectAtIndex:index]) setLabelFrame:CGRectMake(100, 0.0f, ((ADDZFABButton *)[self.fabButtons objectAtIndex:index]).frame.size.width - 70 - 35 - 10, 40)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            if (index+1 == self.fabButtons.count) {
                [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.scrimView.frame = self.zeroFrame;
                    [self.scrimView setAlpha:1.0f];
                    
                    self.scrimView.layer.cornerRadius = FABHEIGHT / 2;
                    self.scrimView.layer.masksToBounds = YES;
                    self.fabCenterImageView.transform = CGAffineTransformMakeRotation((0 * M_PI) / 180.0f);
                    
                    [self.fabCenterImageView setAlpha:1.0f];
                } completion:^(BOOL finished) {
                    self.isAnimating = NO;
                }];
            }
            
            if (index+1 < self.fabButtons.count) {
                [self performRecursiveHideMenuButtonsAnimation:index+1];
            }
        }
    }];
}

- (void)performRecursiveShowMenuButtonsAnimation:(NSUInteger)index
{
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.9f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.isAnimating = YES;
        [((ADDZFABButton *)self.fabButtons[index]) setFrame:self.zeroFrame];
        [((ADDZFABButton *)self.fabButtons[index]) setAlpha:1.0f];
        
        ((ADDZFABButton *)self.fabButtons[index]).layer.cornerRadius = 0.0f;
        ((ADDZFABButton *)self.fabButtons[index]).layer.masksToBounds = YES;
        
        CGFloat y = 0.0f;
        if (self.verticalDirection == FABVerticalDirectionBOTTOM) {
            y = self.zeroFrame.origin.y - FABHEIGHT - (45 * ((ADDZFABButton *)self.fabButtons[index]).index);
        } else if (self.verticalDirection == FABVerticalDirectionTOP) {
            y = self.zeroFrame.origin.y + FABHEIGHT + 15 + (45 * ((ADDZFABButton *)self.fabButtons[index]).index);
        }
        [((ADDZFABButton *)self.fabButtons[index]) setFrame:CGRectMake(0.0f, y, self.parentView.frame.size.width, 40)];
        
        [((ADDZFABButton *)self.fabButtons[index]) setImageViewFrame:CGRectMake(((ADDZFABButton *)self.fabButtons[index]).frame.size.width - 70, 0.0f, 35, 40)];
        
        [((ADDZFABButton *)self.fabButtons[index]) setLabelFrame:CGRectMake(35, 0.0f, ((ADDZFABButton *)self.fabButtons[index]).frame.size.width - 70 - 35 - 10, 40)];
        [((ADDZFABButton *)self.fabButtons[index]).textLabel setAlpha:1.0f];
        [((ADDZFABButton *)self.fabButtons[index]).imageView setAlpha:1.0f];
        
        [((ADDZFABButton *)self.fabButtons[index]) setBackgroundColor:[UIColor colorWithRed:CGColorGetComponents([self.scrimColor CGColor])[0] green:CGColorGetComponents([self.scrimColor CGColor])[1] blue:CGColorGetComponents([self.scrimColor CGColor])[2] alpha:1.0f]];
        
    } completion:^(BOOL finished) {
        if (finished) {
            int i = index +1;
            if (i < self.fabButtons.count) {
                [[self.fabButtons objectAtIndex:i] setFrame:[self.fabButtons[index] frame]];
            }
            if (index+1 < self.fabButtons.count) {
                [self performRecursiveShowMenuButtonsAnimation:index+1];
            } else {
                self.isAnimating = NO;
            }
        }
    }];
}

@end

@interface ADDZFABButton ()

@end

@implementation ADDZFABButton

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_textLabel setTextAlignment:NSTextAlignmentRight];
        [_textLabel setUserInteractionEnabled:YES];
//        [_textLabel setBackgroundColor:[UIColor greenColor]];
    }
    return _textLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageView setBackgroundColor:[UIColor blueColor]];
        [_imageView setUserInteractionEnabled:YES];
    }
    return _imageView;
}

- (void)setImageViewFrame:(CGRect)frame
{
    self.imageView.frame = frame;
}

- (void)setLabelFrame:(CGRect)frame
{
    self.textLabel.frame = frame;
}

- (instancetype)initWithTitle:(NSString *)title AndImage:(NSString *)image
{
    self = [self init];
    if (self) {
        [self.textLabel setText:title];
        [self.imageView setImage:[UIImage imageNamed:image]];
        
        [self addSubview:self.textLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

@end
