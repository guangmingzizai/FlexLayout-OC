//
//  GMViewController.m
//  FlexLayout-OC
//
//  Created by guangmingzizai@qq.com on 09/01/2018.
//  Copyright (c) 2018 guangmingzizai@qq.com. All rights reserved.
//

#import "GMViewController.h"
#import "GMFlexView.h"

@interface GMViewController ()

@property (nonatomic, readonly) GMFlexView *mainView;

@end

@implementation GMViewController

- (GMFlexView *)mainView
{
    return (GMFlexView *)self.view;
}

- (void)loadView
{
    GMFlexView *theView = [[GMFlexView alloc] init];
    self.view = theView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

@end
