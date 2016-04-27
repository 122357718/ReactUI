//
//  RXUViewModel.m
//  ReactUI
//
//  Created by Hui Xu on 12/27/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import "RXUViewModel.h"
#import "RACCommand+ReactUI.h"

@interface RXUViewModel ()
//
//@property (nonatomic, strong, readonly) RACSignal *onDataReadySignal;
//@property (nonatomic, strong, readonly) RACSignal *onRenderSignal;
//@property (nonatomic, strong, readonly) RACSignal *onReloadSignal;

@end

@implementation RXUViewModel

@synthesize title                    = _title;
@synthesize viewModels               = _viewModels;
@synthesize loadDataCommand          = _loadDataCommand;
@synthesize onDataReadySignal        = _onDataReadySignal;
@synthesize onRenderSignal           = _onRenderSignal;
@synthesize onReloadSignal           = _onReloadSignal;


// Deprecated
//@synthesize onSubViewModelsReloadSignal = _onSubViewModelsReloadSignal;


- (instancetype) init {
    if (self = [super init]) {
        _title = @"";
        _viewModels = @[];
        
        @weakify(self);
        RACMulticastConnection *connection = [[[RACObserve(self, loadDataCommand)
                                                map:^id(RACCommand *command) {
                                                    return command.completionSignal;
                                                }]
                                                switchToLatest]
                                                publish];
        _onDataReadySignal = connection.signal;
        [connection connect];
        
        connection = [[[self rac_signalForSelector:@selector(render:)]
                             map:^id(id value) {
                                 return self_weak_;
                             }]
                             publish];
        _onRenderSignal = connection.signal;
        [connection connect];
        
        connection = [RACObserve(self, viewModels) publish];
        _onReloadSignal = connection.signal;
        [connection connect];
        
        [self rac_liftSelector:@selector(render:) withSignals:RACObserve(self, title), nil];
        [self rac_liftSelector:@selector(reload:) withSignals:self.onDataReadySignal, nil];
    }
    
    return self;
}


#pragma mark - Render & layout 


- (void) render: (id) sender {
    
}


- (void) reload: (id) sender {
}


@end


@implementation RXUCellViewModel

@synthesize didSelectCommand = _didSelectCommand;

@end