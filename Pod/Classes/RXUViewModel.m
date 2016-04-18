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
        
        [self rac_liftSelector:@selector(render:) withSignals:RACObserve(self, title), nil];
        [self rac_liftSelector:@selector(reload:) withSignals:self.onDataReadySignal, nil];
    }
    
    return self;
}


#pragma mark - Property accessors


- (RACSignal *)onDataReadySignal {
    if (_onDataReadySignal == nil) {
        RACMulticastConnection *connection = [[[RACObserve(self, loadDataCommand)
                                               map:^id(RACCommand *command) {
                                                   return command.completionSignal;
                                               }]
                                               switchToLatest]
                                               publish];
        [connection connect];
        _onDataReadySignal = connection.signal;
    }
    
    return _onDataReadySignal;
}


- (RACSignal *) onRenderSignal {
    if (_onRenderSignal == nil) {
        @weakify(self);
        _onRenderSignal = [[[self rac_signalForSelector:@selector(render:)]
                                  map:^id(id value) {
                                      @strongify(self);
                                      return self;
                                  }]
                                  startWith:self];
    }
    
    return _onRenderSignal;
}


- (RACSignal *)onReloadSignal {
    if (_onReloadSignal == nil) {
        _onReloadSignal = RACObserve(self, viewModels);
    }
    
    return _onReloadSignal;
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