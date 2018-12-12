//
//  UILabel+FlexLayout.h
//  AFNetworking
//
//  Created by ypf on 2018/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FlexLayout)

@property (nullable, nonatomic, copy) NSString *flex_text; // default is nil
@property (nullable, nonatomic, copy) NSAttributedString *flex_attributedText NS_AVAILABLE_IOS(6_0);  // default is nil

@end

NS_ASSUME_NONNULL_END
