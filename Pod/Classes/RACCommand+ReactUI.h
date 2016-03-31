//
//  RACCommand+ReactUI.h
//  ReactUI
//
//  Created by Hui Xu on 12/30/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACCommand (ReactUI)

- (RACSignal *) completionSignal;

@end
