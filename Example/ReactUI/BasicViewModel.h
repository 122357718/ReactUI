//
//  BasicViewModel.h
//  ReactUI
//
//  Created by Xu Hui on 3/28/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "RXUViewModel.h"

@interface BasicViewModel : RXUViewModel

@property (nonatomic, copy) NSString *welcomeMessage;
@property (nonatomic, copy) NSString *busyMessage;
@property (nonatomic, assign) BOOL busy;

@property (nonatomic, strong) RACCommand *toggleCommand;

+ (instancetype) viewModelForSample;
- (instancetype) initForTableViewSample;

@end
