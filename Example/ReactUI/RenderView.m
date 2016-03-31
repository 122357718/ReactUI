//
//  RenderView.m
//  ReactUI
//
//  Created by Xu Hui on 3/28/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "RenderView.h"
#import "UIView+ReactUI.h"
#import "BasicViewModel.h"

@interface RenderView ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *busyMessage;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@end


@implementation RenderView

- (void) setViewModel:(RXUViewModel *)viewModel {
    [super setViewModel:viewModel];
}


- (void) renderViewModel:(BasicViewModel *)viewModel {
    self.welcomeLabel.text = viewModel.welcomeMessage;
    self.activityIndicator.hidden = !viewModel.busy;
    self.busyMessage.text = viewModel.busyMessage;
    self.toggleButton.rac_command = viewModel.toggleCommand;
}


- (void) dealloc {
    NSLog(@"%s", __func__);
}


@end
