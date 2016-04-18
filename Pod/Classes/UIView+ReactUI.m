//
//  UIView+ReactUI.m
//  ReactUI
//
//  Created by Hui Xu on 1/2/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+ReactUI.h"


@implementation UIView (ReactUI)

const void *UIViewModelAccessKey = &UIViewModelAccessKey;

#pragma mark - Internal helpers

- (void) prepareForSettingViewModel: (id) sender {}


#pragma mark - ViewModel accessors

- (RXUViewModel *)viewModel {
    RXUViewModel *viewModel = objc_getAssociatedObject(self, UIViewModelAccessKey);
    
    if (viewModel == nil) {
        viewModel = [[RXUViewModel alloc] init];
        [self setViewModel:viewModel];
    }
    
    return viewModel;
}


- (void) setViewModel:(RXUViewModel *)viewModel {
    if (objc_getAssociatedObject(self, UIViewModelAccessKey) != viewModel) {
        // Trigger a view model will change signal
        [self prepareForSettingViewModel:self];
        
        objc_setAssociatedObject(self, UIViewModelAccessKey, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setupViewModelBindings:viewModel];
    }
}


- (void) setupViewModelBindings: (RXUViewModel *)viewModel {
    // Bind to render signal
    RACSignal *renderSignal = [viewModel.onRenderSignal
                               takeUntil:[self rac_signalForSelector:@selector(prepareForSettingViewModel:)]];
    
    
    [self rac_liftSelector:@selector(renderViewModel:)
               withSignals:renderSignal, nil];
    
    
    // Bind to sub viewmodel reload signal
    RACSignal *reloadSignal = [[viewModel onReloadSignal]
                                          takeUntil: [self rac_signalForSelector:@selector(prepareForSettingViewModel:)]];
    [self rac_liftSelector:@selector(reloadSubviews:)
               withSignals:reloadSignal, nil];
}


#pragma mark - ViewModel render


- (void) renderViewModel: (RXUViewModel *)viewModel {
}


- (void) reloadSubviews: (NSArray *)subViewModels {
}

@end
