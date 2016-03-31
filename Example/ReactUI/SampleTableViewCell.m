//
//  SampleTableViewCell.m
//  ReactUI
//
//  Created by Xu Hui on 3/30/16.
//  Copyright © 2016 Hui Xu. All rights reserved.
//

#import "SampleTableViewCell.h"
#import "UIView+ReactUI.h"
#import "BasicViewModel.h"

@interface SampleTableViewCell ()


@end


@implementation SampleTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    
    return self;
}

- (void) setViewModel:(RXUViewModel *)viewModel {
    [super setViewModel:viewModel];
}

- (void) renderViewModel:(BasicViewModel *)viewModel {
    [super renderViewModel:viewModel];
    self.messageLabel.text = viewModel.busyMessage;
}

@end
