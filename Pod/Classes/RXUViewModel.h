//
//  RXUViewModel.h
//  ReactUI
//
//  Created by Hui Xu on 12/27/15.
//  Copyright © 2015 Hui Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"


@interface RXUViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *viewModels;

@property (nonatomic, strong) RACCommand *loadDataCommand;

- (void) render: (id) sender;
- (void) reload: (id) sender;

- (RACSignal *) onDataReadySignal;
- (RACSignal *) onRenderSignal;
- (RACSignal *) onReloadSignal;

@end



@interface RXUCellViewModel : RXUViewModel

@property (nonatomic, strong) RACCommand *didSelectCommand;

@end