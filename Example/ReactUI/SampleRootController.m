//
//  SampleTableViewController.m
//  ReactUI
//
//  Created by Xu Hui on 3/28/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "SampleRootController.h"
#import "UIView+ReactUI.h"
#import "BasicViewModel.h"
#import "UITableView+ReactUI.h"
#import "SampleTableViewCell.h"

@interface SampleRootController ()

@end

@implementation SampleRootController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow
                                  animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"render"]) {
        [self configureRenderController: segue];
    }
    else if ([segue.identifier isEqualToString:@"reload"]) {
        [self configureReloadController: segue];
    }
    else if ([segue.identifier isEqualToString:@"loading"]) {
        [self configureLoadingController: segue];
    }
    else if ([segue.identifier isEqualToString:@"tableView"]) {
        [self configureTableViewControllre:segue];
    }
}


- (void) configureRenderController:(UIStoryboardSegue *) segue {
    segue.destinationViewController.view.viewModel = [BasicViewModel viewModelForSample];
}


- (void) configureReloadController: (UIStoryboardSegue *) segue {
    BasicViewModel *viewModel = [[BasicViewModel alloc] init];
    segue.destinationViewController.view.viewModel = viewModel;
}


- (void) configureLoadingController: (UIStoryboardSegue *) segue {
    BasicViewModel *viewModel = [[BasicViewModel alloc] init];
    segue.destinationViewController.view.viewModel = viewModel;
}


- (void) configureTableViewControllre: (UIStoryboardSegue *) segue {
    UITableViewController *controller = (UITableViewController *)segue.destinationViewController;
    
    if (controller.view != nil) {
        // Configure the view
        controller.tableView.estimatedRowHeight = 40;
        controller.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //Create view models
        BasicViewModel *viewModel = [[BasicViewModel alloc] initForTableViewSample];
        
        RXUCellViewModel *cellViewModel = [[RXUCellViewModel alloc] init];
        cellViewModel.title = @"Cell View Model";
        cellViewModel.didSelectCommand = viewModel.toggleCommand;
        
        // Register the cells
        [controller.tableView rxu_registerViewClass:[SampleTableViewCell class]
                               forViewModelInstance:viewModel
                                   cellInStoryboard:YES];
        
        [controller.tableView rxu_registerViewClass:[UITableViewCell class]
                                  forViewModelClass:[cellViewModel class]
                                   cellInStoryboard:NO];
        
        controller.tableView.viewModels = @[viewModel, cellViewModel];
    }
}

@end
