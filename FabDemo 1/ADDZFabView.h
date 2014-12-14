//
//  ADDZFabView.h
//  FabDemo 1
//
//  Created by Sunil N. Talpade on 12/12/14.
//  Copyright (c) 2014 Aditya Talpade. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FABButtonDelegate <NSObject>

@optional

- (void)fabButtonClickedAtIndex:(NSInteger)index;

@end

@class ADDZFABButton;

typedef NS_ENUM(NSUInteger, FABVerticalDirection) {
    FABVerticalDirectionTOP = 1,
    FABVerticalDirectionBOTTOM
};

typedef NS_ENUM(NSUInteger, FABHorizontalDirection) {
    FABHorizontalDirectionLEFT = 1,
    FABHorizontalDirectionRIGHT
};

@interface ADDZFabView : UIView

@property (strong, nonatomic) id delegate;

- (void)setFABCenterImage:(UIImage *)image;

- (void)setFABButtons:(NSMutableArray *)fabButtons;

- (void)setFABScrimColor:(UIColor *)scrimColor;

- (void)setFABVerticalDirection:(FABVerticalDirection)verticalDirection HorizontalDirection:(FABHorizontalDirection)horizontalDirection;

- (void)addToView:(UIView *)view;

- (void)toggleFABMenu;

- (void)showFAB;

- (void)hideFAB;

@end

@interface ADDZFABButton : UIView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *textLabel;

- (instancetype)initWithTitle:(NSString *)title AndImage:(NSString *)image;

@property (nonatomic) NSUInteger index;

- (void)setImageViewFrame:(CGRect)frame;

- (void)setLabelFrame:(CGRect)frame;

@end
