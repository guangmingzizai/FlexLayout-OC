//
//  UIView+FlexLayout.m
//  FlexLayout-OC
//
//  Created by ypf on 2018/9/2.
//

#import "UIView+FlexLayout.h"
#import <objc/runtime.h>
#import "GMFlex.h"

@implementation UIView (FlexLayout)

- (GMFlex *)flex
{
    GMFlex *flex = objc_getAssociatedObject(self, @selector(flex));
    if (!flex) {
        flex = [[GMFlex alloc] initWithView:self];
        objc_setAssociatedObject(self, @selector(flex), flex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return flex;
}

@end
