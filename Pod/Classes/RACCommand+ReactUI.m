//
//  RACCommand+ReactUI.m
//  ReactUI
//
//  Created by Hui Xu on 12/30/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import "RACCommand+ReactUI.h"

@implementation RACCommand (ReactUI)

- (RACSignal *) completionSignal {
    return [self.executionSignals
            flattenMap:^id(RACSignal *signal) {
                return [signal collect];
            }];
}

@end
