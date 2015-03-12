//
//  CircularProgressView.h
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressUpdator.h"

@interface CircularProgressView : UIView <ProgressUpdatorDelegate>

@property (nonatomic) CGFloat progressValue;
@property (nonatomic, strong) UIColor *progressBarColor;
@property (nonatomic, strong) UIColor *progressBarBackgroundColor;
@property (nonatomic) CGFloat progressWidth;

@property (nonatomic) BOOL percentageTextHidden;
@property (nonatomic, strong) UIColor *percentageTextColor;

@property (nonatomic) CGFloat animatedDeltaSize;

- (void)setProgressValue:(CGFloat)progressValue animated:(BOOL)animated;
- (void)setProgressValue:(CGFloat)progressValue animatedFromProgressValue:(CGFloat)startProgressValue;

@end
