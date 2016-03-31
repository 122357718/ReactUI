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
    return [super initWithEnabled:enabledSignal
                      signalBlock:signalBlock];
}


- (void) prepareForCommandExecution: (id) sender{
}

- (RACSignal *)execute:(id)input {
    // Trigger the cancel signal
    [self prepareForCommandExecution:nil];
    
    return [super execute:input];
}

@end
