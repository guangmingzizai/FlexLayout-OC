//
//  GMFlex.m
//  FlexLayout
//
//  Created by ypf on 2018/9/1.
//

#import "GMFlex.h"
#import <YogaKit_GM/YGLayout.h>
#import <YogaKit_GM/UIView+Yoga.h>
#import "UIView+FlexLayout.h"

@interface GMFlex()

@property (nonatomic, strong) YGLayout *yoga;

@end

@implementation GMFlex

#pragma mark - Properties

- (CGSize)intrinsicSize
{
    return _yoga.intrinsicSize;
}

#pragma mark - Lifecycle

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
        self.yoga = view.yoga;
        
        // Enable flexbox and overwrite Yoga default values.
        _yoga.isEnabled = YES;
        _isIncludedInLayout = YES;
    }
    return self;
}

#pragma mark - Flex item addition and definition

- (GMFlex * (^)(void))addItem
{
    return ^id(void) {
        UIView *view = [UIView new];
        return self.addItemView(view);
    };
}

- (GMFlex * (^)(UIView *))addItemView
{
    return ^id(UIView *view) {
        NSAssert(self.view != nil, @"Trying to modify deallocated host view");
        
        [self.view addSubview:view];
        return view.flex;
    };
}

- (GMFlex * (^)(GMFlexDefine))define
{
    return ^id(GMFlexDefine closure){
        closure(self);
        return self;
    };
}

#pragma mark - Layout / intrinsicSize / sizeThatFits

- (void)layout
{
    [self layoutWithMode:GMFlexLayoutModeFitContainer];
}

/**
 The method layout the flex container's children
 
 - Parameter mode: specify the layout mod (LayoutMode).
 */
- (void)layoutWithMode:(GMFlexLayoutMode)mode
{
    if (mode == GMFlexLayoutModeFitContainer) {
        [_yoga applyLayoutPreservingOrigin:YES];
    } else {
        [_yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:mode == GMFlexLayoutModeAdjustWidth ? YGDimensionFlexibilityFlexibleWidth : YGDimensionFlexibilityFlexibleHeight];
    }
}

- (void)setIsIncludedInLayout:(BOOL)isIncludedInLayout
{
    _isIncludedInLayout = isIncludedInLayout;
    _yoga.isIncludedInLayout = isIncludedInLayout;
}

- (GMFlex * (^)(BOOL))flex_isIncludedInLayout
{
    return ^id(BOOL included) {
        self.isIncludedInLayout = included;
        return self;
    };
}

- (GMFlex * (^)(void))markDirty
{
    return ^id {
        [self.yoga markDirty];
        return self;
    };
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [_yoga calculateLayoutWithSize:size];
}

#pragma mark - Direction, wrap, flow

- (GMFlex * (^)(GMFlexDirection))direction
{
    return ^id(GMFlexDirection value) {
        self.yoga.flexDirection = (YGFlexDirection)value;
        return self;
    };
}

- (GMFlex * (^)(GMFlexWrapMode))wrap
{
    return ^id(GMFlexWrapMode value) {
        self.yoga.flexWrap = (YGWrap)value;
        return self;
    };
}

- (GMFlex * (^)(GMFlexLayoutDirection))layoutDirection
{
    return ^id(GMFlexLayoutDirection value) {
        self.yoga.direction = (YGDirection)value;
        return self;
    };
}

#pragma mark - justity, alignment, position

- (GMFlex * (^)(GMFlexJustifyContent))justifyContent
{
    return ^id(GMFlexJustifyContent value) {
        self.yoga.justifyContent = (YGJustify)value;
        return self;
    };
}

- (GMFlex * (^)(GMFlexAlignItems))alignItems
{
    return ^id(GMFlexAlignItems value) {
        self.yoga.alignItems = (YGAlign)value;
        return self;
    };
}

- (GMFlex * (^)(GMFlexAlignSelf))alignSelf
{
    return ^id(GMFlexAlignSelf value) {
        self.yoga.alignSelf = (YGAlign)value;
        return self;
    };
}

- (GMFlex * (^)(GMFlexAlignContent))alignContent
{
    return ^id(GMFlexAlignContent value) {
        self.yoga.alignContent = (YGAlign)value;
        return self;
    };
}

#pragma mark - grow / shrink / basis

- (GMFlex * (^)(CGFloat))grow
{
    return ^id(CGFloat value) {
        self.yoga.flexGrow = value;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))shrink
{
    return ^id(CGFloat value) {
        self.yoga.flexShrink = value;
        return self;
    };
}

- (GMFlex * (^)(void))autoBasis
{
    return ^id(void) {
        self.yoga.flexBasis = YGValueAuto;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))basis
{
    return ^id(CGFloat value) {
        self.yoga.flexBasis = YGValueMake(value);
        return self;
    };
}

#pragma mark - Width / height / height

- (GMFlex * (^)(void))autoWidth
{
    return ^id(void) {
        self.yoga.width = YGValueAuto;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))width
{
    return ^id(CGFloat value) {
        self.yoga.width = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))widthWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.width = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))autoHeight
{
    return ^id(void) {
        self.yoga.height = YGValueAuto;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))height
{
    return ^id(CGFloat value) {
        self.yoga.height = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))heightWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.height = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))autoSize
{
    return ^id(void) {
        self.yoga.width = YGValueAuto;
        self.yoga.height = YGValueAuto;
        return self;
    };
}

- (GMFlex * (^)(CGSize))size
{
    return ^id(CGSize value) {
        self.yoga.width = YGValueMake(value.width);
        self.yoga.height = YGValueMake(value.height);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))sideLength
{
    return ^id(CGFloat value) {
        self.yoga.width = YGValueMake(value);
        self.yoga.height = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(void))undefinedMinWidth
{
    return ^id(void) {
        self.yoga.minWidth = YGValueUndefined;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))minWidth
{
    return ^id(CGFloat value) {
        self.yoga.minWidth = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))minWidthWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.minWidth = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))undefinedMaxWidth
{
    return ^id(void) {
        self.yoga.maxWidth = YGValueUndefined;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))maxWidth
{
    return ^id(CGFloat value) {
        self.yoga.maxWidth = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))maxWidthWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.maxWidth = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))undefinedMinHeight
{
    return ^id(void) {
        self.yoga.minHeight = YGValueUndefined;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))minHeight
{
    return ^id(CGFloat value) {
        self.yoga.minHeight = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))minHeightWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.minHeight = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))undefinedMaxHeight
{
    return ^id(void) {
        self.yoga.maxHeight = YGValueUndefined;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))maxHeight
{
    return ^id(CGFloat value) {
        self.yoga.maxHeight = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))maxHeightWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.maxHeight = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(void))undefinedAspectRatio
{
    return ^id(void) {
        self.yoga.aspectRatio = YGValueUndefined.value;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))aspectRatio
{
    return ^id(CGFloat value) {
        self.yoga.aspectRatio = value;
        return self;
    };
}

- (GMFlex * (^)(UIImageView *))aspectRatioOfImageView
{
    return ^id(UIImageView *imageView) {
        if (imageView.image != nil) {
            CGSize imageSize = imageView.image.size;
            self.yoga.aspectRatio = imageSize.width / imageSize.height;
        }
        return self;
    };
}

#pragma mark - Absolute positionning

- (GMFlex * (^)(GMFlexPosition))position
{
    return ^id(GMFlexPosition position) {
        self.yoga.position = (YGPositionType)position;
        return self;
    };
}

- (GMFlex * (^)(CGFloat))left
{
    return ^id(CGFloat value) {
        self.yoga.left = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))leftWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.left = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))top
{
    return ^id(CGFloat value) {
        self.yoga.top = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))topWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.top = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))right
{
    return ^id(CGFloat value) {
        self.yoga.right = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))rightWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.right = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))bottom
{
    return ^id(CGFloat value) {
        self.yoga.bottom = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))bottomWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.bottom = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))start
{
    return ^id(CGFloat value) {
        self.yoga.start = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))startWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.start = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))end
{
    return ^id(CGFloat value) {
        self.yoga.end = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))endWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.end = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

#pragma mark - Margin

- (GMFlex * (^)(CGFloat))marginTop
{
    return ^id(CGFloat value) {
        self.yoga.marginTop = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginTopWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginTop = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginLeft
{
    return ^id(CGFloat value) {
        self.yoga.marginLeft = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginLeftWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginLeft = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginBottom
{
    return ^id(CGFloat value) {
        self.yoga.marginBottom = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginBottomWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginBottom = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginRight
{
    return ^id(CGFloat value) {
        self.yoga.marginRight = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginRightWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginRight = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginStart
{
    return ^id(CGFloat value) {
        self.yoga.marginStart = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginStartWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginStart = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginEnd
{
    return ^id(CGFloat value) {
        self.yoga.marginEnd = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginEndWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginEnd = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginHorizontal
{
    return ^id(CGFloat value) {
        self.yoga.marginHorizontal = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginHorizontalWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginHorizontal = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginVertical
{
    return ^id(CGFloat value) {
        self.yoga.marginVertical = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginVerticalWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.marginVertical = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(UIEdgeInsets))marginWithInsets
{
    return ^id(UIEdgeInsets insets) {
        self.yoga.marginTop = YGValueMake(insets.top);
        self.yoga.marginLeft = YGValueMake(insets.left);
        self.yoga.marginBottom = YGValueMake(insets.bottom);
        self.yoga.marginRight = YGValueMake(insets.right);
        return self;
    };
}

- (GMFlex * (^)(NSDirectionalEdgeInsets))marginWithDirectionalInsets NS_AVAILABLE_IOS(11_0)
{
    return ^id(NSDirectionalEdgeInsets directionalInsets) {
        self.yoga.marginTop = YGValueMake(directionalInsets.top);
        self.yoga.marginStart = YGValueMake(directionalInsets.leading);
        self.yoga.marginBottom = YGValueMake(directionalInsets.bottom);
        self.yoga.marginEnd = YGValueMake(directionalInsets.trailing);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))margin
{
    return ^id(CGFloat value) {
        self.yoga.margin = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))marginWithPercent
{
    return ^id(CGFloat value) {
        self.yoga.margin = YGValueMakeWithUnit(value, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat))marginVH
{
    return ^id(CGFloat vertical, CGFloat horizontal) {
        self.yoga.marginVertical = YGValueMake(vertical);
        self.yoga.marginHorizontal = YGValueMake(horizontal);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat))marginVHWithPercent
{
    return ^id(CGFloat vertical, CGFloat horizontal) {
        self.yoga.marginVertical = YGValueMakeWithUnit(vertical, YGUnitPercent);
        self.yoga.marginHorizontal = YGValueMakeWithUnit(vertical, YGUnitPercent);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))marginAll
{
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.yoga.marginTop = YGValueMake(top);
        self.yoga.marginLeft = YGValueMake(left);
        self.yoga.marginBottom = YGValueMake(bottom);
        self.yoga.marginRight = YGValueMake(right);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))marginAllWithPercent
{
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.yoga.marginTop = YGValueMakeWithUnit(top, YGUnitPercent);
        self.yoga.marginLeft = YGValueMakeWithUnit(left, YGUnitPercent);
        self.yoga.marginBottom = YGValueMakeWithUnit(bottom, YGUnitPercent);
        self.yoga.marginRight = YGValueMakeWithUnit(right, YGUnitPercent);
        return self;
    };
}

#pragma mark - Padding

- (GMFlex * (^)(CGFloat))paddingTop
{
    return ^id(CGFloat value) {
        self.yoga.paddingTop = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingLeft
{
    return ^id(CGFloat value) {
        self.yoga.paddingLeft = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingBottom
{
    return ^id(CGFloat value) {
        self.yoga.paddingBottom = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingRight
{
    return ^id(CGFloat value) {
        self.yoga.paddingRight = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingStart
{
    return ^id(CGFloat value) {
        self.yoga.paddingStart = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingEnd
{
    return ^id(CGFloat value) {
        self.yoga.paddingEnd = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingHorizontal
{
    return ^id(CGFloat value) {
        self.yoga.paddingHorizontal = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))paddingVertical
{
    return ^id(CGFloat value) {
        self.yoga.paddingVertical = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(UIEdgeInsets))paddingWithInsets
{
    return ^id(UIEdgeInsets value) {
        self.yoga.paddingTop = YGValueMake(value.top);
        self.yoga.paddingLeft = YGValueMake(value.left);
        self.yoga.paddingBottom = YGValueMake(value.bottom);
        self.yoga.paddingRight = YGValueMake(value.right);
        return self;
    };
}

- (GMFlex * (^)(NSDirectionalEdgeInsets))paddingWithDirectionalInsets NS_AVAILABLE_IOS(11_0)
{
    return ^id(NSDirectionalEdgeInsets value) {
        self.yoga.paddingTop = YGValueMake(value.top);
        self.yoga.paddingStart = YGValueMake(value.leading);
        self.yoga.paddingBottom = YGValueMake(value.bottom);
        self.yoga.paddingEnd = YGValueMake(value.trailing);
        return self;
    };
}

- (GMFlex * (^)(CGFloat))padding
{
    return ^id(CGFloat value) {
        self.yoga.padding = YGValueMake(value);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat))paddingVH
{
    return ^id(CGFloat vertical, CGFloat horizontal) {
        self.yoga.paddingVertical = YGValueMake(vertical);
        self.yoga.paddingHorizontal = YGValueMake(horizontal);
        return self;
    };
}

- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))paddingAll
{
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.yoga.paddingTop = YGValueMake(top);
        self.yoga.paddingLeft = YGValueMake(left);
        self.yoga.paddingBottom = YGValueMake(bottom);
        self.yoga.paddingRight = YGValueMake(right);
        return self;
    };
}

#pragma mark - UIView Visual properties

- (GMFlex * (^)(UIColor *))backgroundColor
{
    return ^id(UIColor *color) {
        NSAssert(self.view != nil, @"Trying to modify deallocated host view");
        self.view.backgroundColor = color;
        return self;
    };
}

#pragma mark - Display

- (GMFlex * (^)(GMFlexDisplay))display
{
    return ^id(GMFlexDisplay display) {
        self.yoga.display = (YGDisplay)display;
        return self;
    };
}

#pragma mark - Utility

YGValue YGValueMake(CGFloat value)
{
    YGValue ygValue; ygValue.value = value; ygValue.unit = YGUnitPoint; return ygValue;
}

YGValue YGValueMakeWithUnit(CGFloat value, YGUnit unit)
{
    YGValue ygValue; ygValue.value = value; ygValue.unit = unit; return ygValue;
}

@end
