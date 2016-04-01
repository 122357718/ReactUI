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


- (void) renderViewModel:(RXUViewModel *)viewModel {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self];
    
    if (indexPath != nil) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void) reloadSubviews:(NSArray *)subViewModels {
    [self.tableView reloadData];
}

@end
