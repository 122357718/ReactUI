//
//  UITableViewCell+ReactUI.m
//  Pods
//
//  Created by Xu Hui on 3/31/16.
//
//

#import <objc/runtime.h>
#import "UITableViewCell+ReactUI.h"
#import "UIView+ReactUI.h"


const void *UITableViewCellTableViewKey = &UITableViewCellTableViewKey;


@implementation UITableViewCell (ReactUI)

#pragma mark - Property getters and setters

- (UITableView *) tableView {
    return objc_getAssociatedObject(self, UITableViewCellTableViewKey);
}


- (void) setTableView:(UITableView *)tableView {
    if (objc_getAssociatedObject(self, UITableViewCellTableViewKey) != tableView) {
        objc_setAssociatedObject(self, UITableViewCellTableViewKey, tableView, OBJC_ASSOCIATION_ASSIGN);
    }
}


#pragma mark - Override super methods

- (void) setViewModel:(RXUViewModel *)viewModel {
    [super setViewModel:viewModel];
    
    // render the viewmodel immediately.
    [self renderViewModel:viewModel];
    [self reloadSubviews:viewModel.viewModels];
}


- (void) setupViewModelBindings:(RXUViewModel *)viewModel {
    RACSignal *reloadSignal = [[RACSignal merge:@[[viewModel onRenderSignal], [viewModel onReloadSignal], [viewModel onDataReadySignal]]]
                                          takeUntil: [self rac_signalForSelector:@selector(prepareForSettingViewModel:)]];
    
    @weakify(self);
    [reloadSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}


@end
