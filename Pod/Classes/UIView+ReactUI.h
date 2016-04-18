//
//  UIView+ReactUI.h
//  ReactUI
//
//  Created by Hui Xu on 1/2/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXUViewModel.h"

@interface UIView (ReactUI)

@property (nonatomic, strong) RXUViewModel *viewModel;

- (void) renderViewModel: (RXUViewModel *)viewModel;
- (void) reloadSubviews: (NSArray *)subViewModels;

- (void) prepareForSettingViewModel: (id) sender;
- (void) setupViewModelBindings: (RXUViewModel *)viewModel;

@end
