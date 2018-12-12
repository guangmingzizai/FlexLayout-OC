//
//  UILabel+FlexLayout.m
//  AFNetworking
//
//  Created by ypf on 2018/11/30.
//

#import "UILabel+FlexLayout.h"
#import <objc/runtime.h>
#import "UIView+FlexLayout.h"
#import "GMFlex.h"

@implementation UILabel (FlexLayout)

- (NSString *)flex_text {
    return self.text;
}

- (void)setFlex_text:(NSString *)flex_text {
    self.text = flex_text;
    self.flex.markDirty();
}

- (NSAttributedString *)flex_attributedText {
    return self.attributedText;
}

- (void)setFlex_attributedText:(NSAttributedString *)flex_attributedText {
    self.attributedText = flex_attributedText;
    self.flex.markDirty();
}

@end
