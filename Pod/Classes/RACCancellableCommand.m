//
//  RACCancellableCommand.m
//  ReactUI
//
//  Created by Hui Xu on 1/24/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "RACCancellableCommand.h"

@implementation RACCancellableCommand

- (instancetype) initWithEnabled:(RACSignal *)enabledSignal signalBlock:(RACSignal *(^)(id))signalBlock {
    RACSignal *cancelSignal = [self rac_signalForSelector:@selector(prepareForCommandExecution:)];
    if (self = [super initWithEnabled:enabledSignal
                          signalBlock:^RACSignal *(id input) {
                              return [signalBlock(input) takeUntil:cancelSignal];
                          }]) {
                          };
    
    return self;
}

- (void) prepareForCommandExecution: (id) sender{
}

- (RACSignal *)execute:(id)input {
    // Trigger the cancel signal
    [self prepareForCommandExecution:nil];
    
    return [super execute:input];
}

@end
