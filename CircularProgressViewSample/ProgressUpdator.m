//
//  ProgressUpdator.m
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import "ProgressUpdator.h"
#import <QuartzCore/QuartzCore.h>

@interface ProgressUpdator ()

@property (nonatomic, strong) CADisplayLink *displayLinkForProgress;

@end


@implementation ProgressUpdator {
    BOOL _isProgressIncreasing;
    CGFloat _updatingDelta;
}

- (id)init {
    self = [super init];
    if (self) {
        self.deltaSize = 0.01;
    }
    
    return self;
}

- (void)dealloc {
    [self.displayLinkForProgress invalidate];
}

- (void)scheduleUpdateFromProgress:(double)startProgress toProgress:(double)endProgress {
    _isProgressIncreasing = startProgress < endProgress ? YES : NO;
    
    _updatingDelta = _isProgressIncreasing ? 1.0*self.deltaSize : -1.0*self.deltaSize;
    
    self.currentProgress = startProgress;
    self.endProgress = endProgress;
    
    if (self.displayLinkForProgress) {
        [self.displayLinkForProgress invalidate];
    }
    self.displayLinkForProgress = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.displayLinkForProgress addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)update {
    self.currentProgress += _updatingDelta;
    
    if (((_isProgressIncreasing == YES) && (self.currentProgress > self.endProgress)) ||
        ((_isProgressIncreasing == NO) && (self.currentProgress < self.endProgress))){
        self.currentProgress = self.endProgress;
        [self.displayLinkForProgress invalidate];
    }
    
    [self.delegate progressUpdator:self didUpdateProgress:self.currentProgress];
}

@end
