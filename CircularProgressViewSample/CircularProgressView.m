//
//  CircularProgressView.m
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import "CircularProgressView.h"

#define DefaultProgressValue 0.0
#define DefaultProgressWidth 3.0
#define DefaultProgressBarColor [UIColor blueColor]
#define DefaultProgressBarBackgroundColor [UIColor clearColor]
#define DefaultPercentageTextColor [UIColor blueColor]

@interface CircularProgressView ()

@property (nonatomic, strong) UILabel *percentageLabel;
@property (nonatomic, strong) ProgressUpdator *progressUpdator;

@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    self.progressBarColor = DefaultProgressBarColor;
    self.progressBarBackgroundColor = DefaultProgressBarBackgroundColor;
    self.progressWidth = DefaultProgressWidth;
    self.progressValue = DefaultProgressValue;
    self.percentageTextColor = DefaultPercentageTextColor;
    self.percentageTextHidden = NO;
    
    self.percentageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.percentageLabel.backgroundColor = [UIColor clearColor];
    self.percentageLabel.textAlignment = NSTextAlignmentCenter;
    self.percentageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:34];
    
    [self addSubview:self.percentageLabel];
    
    self.progressUpdator = [[ProgressUpdator alloc] init];
    self.progressUpdator.delegate = self;
}

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [self.progressBarBackgroundColor CGColor]);
    CGContextSetLineWidth(ctx, self.progressWidth);
    CGContextAddArc(ctx, center.x, center.y, self.frame.size.width / 2.0 - self.progressWidth, 0, 2*(float)M_PI, 0);

    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [self.progressBarColor CGColor]);
    CGContextSetLineWidth(ctx, self.progressWidth);
    CGContextAddArc(ctx, center.x, center.y, self.frame.size.width / 2.0 - self.progressWidth, -0.5*(float)M_PI, MIN(2*self.progressValue-0.5, 2)*(float)M_PI, 0);
    CGContextStrokePath(ctx);
    
    [self refreshCurrentPercentageText];
}

- (void)setProgressValue:(CGFloat)progressValue animated:(BOOL)animated {
    if (self.progressValue != progressValue) {
        if (animated) {
            [self.progressUpdator scheduleUpdateFromProgress:self.progressValue toProgress:progressValue];
        } else {
            self.progressValue = progressValue;
        }
    }
}

- (void)setProgressValue:(CGFloat)progressValue animatedFromProgressValue:(CGFloat)startProgressValue {
    self.progressValue = startProgressValue;
    if (progressValue != startProgressValue) {
        [self.progressUpdator scheduleUpdateFromProgress:self.progressValue toProgress:progressValue];
    }
}

#pragma mark - Overriding Setters/Getters

- (void)setProgressBarColor:(UIColor *)progressBarColor {
    _progressBarColor = progressBarColor;
    [self setNeedsDisplay];
}

- (void)setProgressBarBackgroundColor:(UIColor *)progressBarBackgroundColor {
    _progressBarBackgroundColor = progressBarBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    [self setNeedsDisplay];
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    [self setNeedsDisplay];
}

- (void)setPercentageTextHidden:(BOOL)percentageStringHidden {
    self.percentageLabel.hidden = percentageStringHidden;
}

- (BOOL)percentageTextHidden {
    return self.percentageLabel.hidden;
}

- (void)setAnimatedDeltaSize:(CGFloat)animatedDeltaSize {
    self.progressUpdator.deltaSize = animatedDeltaSize;
}

- (CGFloat)animatedDeltaSize {
    return self.progressUpdator.deltaSize;
}

#pragma mark - ProgressAnimatorDelegate
- (void)progressUpdator:(ProgressUpdator *)progressUpdator didUpdateProgress:(double)progress {
    self.progressValue = progress;
}

#pragma mark - Percentage String

- (void)refreshCurrentPercentageText {
    NSInteger percentage = self.progressValue * 100;
    
    NSString *percentageString = [NSString stringWithFormat:@"%lu%%",(long)percentage];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:percentageString];
    
    [attString addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"HelveticaNeue" size:13]
                      range:NSMakeRange(percentageString.length-1, 1)];
    [attString addAttribute:NSForegroundColorAttributeName
                      value:self.percentageTextColor
                      range:NSMakeRange(0, percentageString.length)];

    self.percentageLabel.attributedText = attString;
    [self.percentageLabel sizeToFit];
    
    self.percentageLabel.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}

@end
