//
//  BasicViewModel.m
//  ReactUI
//
//  Created by Xu Hui on 3/28/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "BasicViewModel.h"
#import "RACCancellableCommand.h"

@implementation BasicViewModel

+ (instancetype) viewModelForSample {
    return [[self alloc] initForSample];
}


- (instancetype) initForSample {
    if (self = [super init]) {
        [self configureSample];
    }
    
    return self;
}


- (instancetype) initForTableViewSample {
    if (self = [super init]) {
        [self configureTableViewSample];
    }
    
    
    return self;
}


- (void) configureSample {
    self.welcomeMessage = @"Welcome to the basic example page";
    
    // Set up the busy relationship
    RAC(self, busyMessage) = [RACObserve(self, busy) map:^id(NSNumber *busy) {
                                       NSString *busyMessage = @"";
                                       if ([busy boolValue]) {
                                           busyMessage = @"The View Model is busy with some background tasks!The View Model is busy with some background tasks!The View Model is busy with some background tasks!";
                                       }
                                       else {
                                           busyMessage = @"The View Model has finished background tasks :D";
                                       }
                                       
                                       return busyMessage;
                                   }];
    
    // The initial state of "busy"
    self.busy = YES;
    
    // The toggle command
    @weakify(self);
    self.toggleCommand = [[RACCancellableCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.busy = !self.busy;
        return [RACSignal return:self];
    }];
    
    // Trigger render
    [self rac_liftSelector:@selector(render:)
               withSignals:[RACSignal combineLatest:@[RACObserve(self, welcomeMessage),
                                                      RACObserve(self, busyMessage),
                                                      RACObserve(self, busy)]], nil];
}


- (void) configureTableViewSample {
    [self configureSample];
//    [self rac_liftSelector:@selector() withSignals:RACObserve(self, busyMessage), nil];
}

- (void) dealloc {
    NSLog(@"%s", __func__);
}

@end
