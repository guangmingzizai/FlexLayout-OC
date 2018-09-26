//
//  GMFlexView.m
//  FlexLayout-OC_Example
//
//  Created by ypf on 2018/9/2.
//  Copyright © 2018年 guangmingzizai@qq.com. All rights reserved.
//

#import "GMFlexView.h"
#import <FlexLayout_OC/FlexLayout-OC.h>
#import <ZZFLEX/ZZFLEX.h>
#import "NSArray+HOF.h"

@implementation GMFlexView
{
    UIView *_rootFlexContainer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray<NSString *> *fruits = @[ @"苹果", @"梨", @"西瓜", @"草莓" ];
        NSArray<UILabel *> *fruitLabels = [fruits map:^id(NSString *fruit, NSUInteger idx) {
            return UILabel.zz_create(idx)
            .textColor([UIColor blackColor])
            .font([UIFont systemFontOfSize:16])
            .text(fruit)
            .view;
        }];
        
        _rootFlexContainer = [UIView new];
        _rootFlexContainer.flex.alignItems(GMFlexAlignItemsCenter).paddingTop(100)
        .define(^(GMFlex *flex) {
            for (UILabel *fruitLabel in fruitLabels) {
                flex.addItemView(fruitLabel).marginTop(10);
            }
        });
        [self addSubview:_rootFlexContainer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _rootFlexContainer.frame = self.bounds;
    [_rootFlexContainer.flex layout];
}

@end
