//
//  UITableView+Adaptor.m
//  ReactUI
//
//  Created by Hui Xu on 12/27/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+ReactUI.h"
#import "RXUViewModel.h"
#import "UIView+ReactUI.h"
#import "UITableViewCell+ReactUI.h"

const void *UITableViewClassRegistry = &UITableViewClassRegistry;

@interface UITableView ()

@property (nonatomic, strong, readonly) NSMutableDictionary *classRegistry;


@end

@implementation UITableView (ReactUI)

#pragma mark - Property accessors


- (NSArray *)viewModels {
    return self.viewModel.viewModels;
}


- (void) setViewModels:(NSArray *)viewModels {
    RXUViewModel *internalViewModel = [[RXUViewModel alloc] init];
    internalViewModel.viewModels = viewModels;
    self.viewModel = internalViewModel;
}


- (NSDictionary *) classRegistry {
    NSMutableDictionary *registry = objc_getAssociatedObject(self, UITableViewClassRegistry);
    
    if (registry == nil) {
        registry = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, UITableViewClassRegistry, registry, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return registry;
}


#pragma mark - Override super methods

- (void) reloadSubviews:(NSArray *)subViewModels {
    // Set delegate and data source to self
    self.delegate = self;
    self.dataSource = self;
    [self reloadData];
}


#pragma mark - Class registration

- (void) rxu_registerViewClass:(Class)cellClass
             forViewModelClass:(Class)viewModelClass
              cellInStoryboard:(BOOL)inStoryboard {
    NSString *cellReuseIdentifier = NSStringFromClass(cellClass);
    NSString *viewModelClassName = NSStringFromClass(viewModelClass);
    if (!inStoryboard) {
        [self registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifier];
    }
    [self.classRegistry setObject:cellClass forKey:viewModelClassName];
}


- (void) rxu_registerViewClass:(Class)cellClass
          forViewModelInstance:(RXUViewModel *)viewModel
              cellInStoryboard:(BOOL)inStoryboard {
    if (cellClass != nil && viewModel != nil) {
        NSString *cellReuseIdentifier = NSStringFromClass(cellClass);
        if (!inStoryboard) {
            [self registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifier];
        }
        [self.classRegistry setObject:cellClass forKey:[NSValue valueWithNonretainedObject:viewModel]];
    }
}


- (Class) rxu_viewClassForViewModel: (RXUViewModel *)viewModel {
    Class class = [self.classRegistry objectForKey:[NSValue valueWithNonretainedObject:viewModel]];
    if (class == nil) {
        class = [self.classRegistry objectForKey:NSStringFromClass([viewModel class])];
    }
    return class;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModels count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Resolve view class
    RXUViewModel *viewModel = [self.viewModels objectAtIndex:indexPath.row];
    Class cellClass = [self rxu_viewClassForViewModel:viewModel];
    NSString *cellIdentifier = NSStringFromClass(cellClass);
    
    // Deque the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Set the view model to the cell
    if (cell != nil) {
        cell.tableView = self;
        cell.viewModel = viewModel;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RXUViewModel *viewModel = [self.viewModels objectAtIndex:indexPath.row];
    if ([viewModel isKindOfClass:[RXUCellViewModel class]]) {
        // Execute the selection command
        RXUCellViewModel *cellViewModel = (RXUCellViewModel *)viewModel;
        if (cellViewModel.didSelectCommand != nil) {
            [cellViewModel.didSelectCommand execute:self];
        }
    }
}

@end
