//
//  UITableView+Adaptor.h
//  ReactUI
//
//  Created by Hui Xu on 12/27/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RXUViewModel;

@interface UITableView (ReactUI)<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *viewModels;

- (void) rxu_registerViewClass:(Class)cellClass
             forViewModelClass:(Class)viewModelClass
              cellInStoryboard:(BOOL)inStoryboard;


- (void) rxu_registerViewClass:(Class)cellClass
          forViewModelInstance:(RXUViewModel *)viewModel
              cellInStoryboard:(BOOL)inStoryboard;


@end
