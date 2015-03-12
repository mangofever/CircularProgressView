//
//  ProgressUpdator.h
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgressUpdatorDelegate;

@interface ProgressUpdator : NSObject

@property (nonatomic) double deltaSize;
@property (nonatomic) double currentProgress;
@property (nonatomic) double endProgress;

@property (nonatomic, weak) id<ProgressUpdatorDelegate> delegate;

- (void)scheduleUpdateFromProgress:(double)startProgress toProgress:(double)endProgress;

@end


@protocol ProgressUpdatorDelegate <NSObject>

- (void)progressUpdator:(ProgressUpdator *)progressUpdator didUpdateProgress:(double)progress;
                          
@end