//
//  GMFlex.h
//  FlexLayout
//
//  Created by ypf on 2018/9/1.
//

#import <Foundation/Foundation.h>
#import "GMFlexDefinitions.h"

@class GMFlex;
typedef void(^GMFlexDefine)(GMFlex *flex);

/**
 FlexLayout interface.
 
 The interface is accessible from any UIView class instance:
 ```
 label.flex.margin(10)
 ```
 */
@interface GMFlex : NSObject

@property (nonatomic, weak) UIView *view; // Flex items's UIView.
/**
 Item natural size, considering only properties of the view itself. Independent of the item frame.
 */
@property (nonatomic, readonly) CGSize intrinsicSize;

/**
 This property controls dynamically if a flexbox's UIView is included or not in the flexbox layouting. When a
 flexbox's UIView is excluded, FlexLayout won't layout the view and its children views.
 */
@property (nonatomic, assign) BOOL isIncludedInLayout;

- (instancetype)initWithView:(UIView *)view;

#pragma mark - Flex item addition and definition

/**
 This method adds a flex item (UIView) to a flex container. Internally the methods adds the UIView has subviews and enables flexbox.
 
 - Returns: The added view flex interface
 */
- (GMFlex * (^)(void))addItem;

/**
 This method is similar to `addItem(: UIView)` except that it also creates the flex item's UIView. Internally the method creates an
 UIView, adds it has subviews and enables flexbox. This is useful to add a flex item/container easily when you don't need to refer to it later.
 
 - Parameter view: view to add to the flex container
 - Returns: The added view flex interface
 */
- (GMFlex * (^)(UIView *))addItemView;

/**
 This method is used to structure your code so that it matches the flexbox structure. The method has a closure parameter with a
 single parameter called `flex`. This parameter is in fact, the view's flex interface, it can be used to adds other flex items
 and containers.
 
 - Parameter closure:
 - Returns: Flex interface
 */
- (GMFlex * (^)(GMFlexDefine))define;

#pragma mark - Layout / intrinsicSize / sizeThatFits

/**
 The method layout the flex container's children
 
 - Parameter mode: specify the layout mod (LayoutMode).
 */
- (void)layoutWithMode:(GMFlexLayoutMode)mode;
/**
 Layout with .FitContainer mode
 */
- (void)layout;

/**
 This method controls dynamically if a flexbox's UIView is included or not in the flexbox layouting. When a
 flexbox's UIView is excluded, FlexLayout won't layout the view and its children views.
 
 - Parameter included: true to layout the view
 - Returns:
 */
- (GMFlex * (^)(BOOL))flex_isIncludedInLayout;

/**
 The framework is so highly optimized, that flex item are layouted only when a flex property is changed and when flex container
 size change. In the event that you want to force FlexLayout to do a layout of a flex item, you can mark it as dirty
 using `markDirty()`.
 
 Dirty flag propagates to the root of the flexbox tree ensuring that when any item is invalidated its whole subtree will be re-calculated
 
 - Returns: Flex interface
 */
- (GMFlex * (^)(void))markDirty;

/**
 Returns the item size when layouted in the specified frame size
 
 - Parameter size: frame size
 - Returns: item size
 */
- (CGSize)sizeThatFits:(CGSize)size;

#pragma mark - Direction, wrap, flow

/**
 The `direction` property establishes the main-axis, thus defining the direction flex items are placed in the flex container.
 
 The `direction` property specifies how flex items are laid out in the flex container, by setting the direction of the flex
 container’s main axis. They can be laid out in two main directions,  like columns vertically or like rows horizontally.
 
 Note that row and row-reverse are affected by the layout direction (see `layoutDirection` property) of the flex container.
 If its text direction is LTR (left to right), row represents the horizontal axis oriented from left to right, and row-reverse
 from right to left; if the direction is rtl, it's the opposite.
 
 - Parameter value: Default value is .column
 */
- (GMFlex * (^)(GMFlexDirection))direction;

/**
 The `wrap` property controls whether the flex container is single-lined or multi-lined, and the direction of the cross-axis, which determines the direction in which the new lines are stacked in.
 
 - Parameter value: Default value is .noWrap
 */
- (GMFlex * (^)(GMFlexWrapMode))wrap;

/**
 Direction defaults to Inherit on all nodes except the root which defaults to LTR. It is up to you to detect the
 user’s preferred direction (most platforms have a standard way of doing this) and setting this direction on the
 root of your layout tree.
 
 - Parameter value: new LayoutDirection
 - Returns:
 */
- (GMFlex * (^)(GMFlexLayoutDirection))layoutDirection;

#pragma mark - justity, alignment, position

/**
 The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container.
 It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum
 size. For example, if children are flowing vertically, `justifyContent` controls how they align vertically.
 
 - Parameter value: Default value is .start
 */
- (GMFlex * (^)(GMFlexJustifyContent))justifyContent;

/**
 The `alignItems` property defines how flex items are laid out along the cross axis on the current line.
 Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, if
 children are flowing vertically, `alignItems` controls how they align horizontally.
 
 - Parameter value: Default value is .stretch
 */
- (GMFlex * (^)(GMFlexAlignItems))alignItems;

/**
 The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems`
 of the parent. For example, if children are flowing vertically, `alignSelf` will control how the flex item
 will align horizontally.
 
 - Parameter value: Default value is .auto
 */
- (GMFlex * (^)(GMFlexAlignSelf))alignSelf;

/**
 The align-content property aligns a flex container’s lines within the flex container when there is extra space
 in the cross-axis, similar to how justifyContent aligns individual items within the main-axis.
 
 - Parameter value: Default value is .start
 */
- (GMFlex * (^)(GMFlexAlignContent))alignContent;

#pragma mark - grow / shrink / basis

/**
 The `grow` property defines the ability for a flex item to grow if necessary. It accepts a unitless value
 that serves as a proportion. It dictates what amount of the available space inside the flex container the
 item should take up.
 
 - Parameter value: Default value is 0
 */
- (GMFlex * (^)(CGFloat))grow;

/**
 It specifies the "flex shrink factor", which determines how much the flex item will shrink relative to the
 rest of the flex items in the flex container when there isn't enough space on the main-axis.
 
 When omitted, it is set to 0 and the flex shrink factor is multiplied by the flex `basis` when distributing
 negative space.
 
 A shrink value of 0 keeps the view's size in the main-axis direction. Note that this may cause the view to
 overflow its flex container.
 
 - Parameter value: Default value is 1
 */
- (GMFlex * (^)(CGFloat))shrink;

/**
 This property takes the same values as the width and height properties, and specifies the initial size of the
 flex item, before free space is distributed according to the grow and shrink factors.
 
 Specifying `nil` set the basis as `auto`, which means the length is equal to the length of the item. If the
 item has no length specified, the length will be according to its content.
 
 - Parameter value: Default value is 0
 */
- (GMFlex * (^)(void))autoBasis;

/**
 This property takes the same values as the width and height properties, and specifies the initial size of the
 flex item, before free space is distributed according to the grow and shrink factors.
 
 Specifying `nil` set the basis as `auto`, which means the length is equal to the length of the item. If the
 item has no length specified, the length will be according to its content.
 
 - Parameter value: Default value is 0
 */
- (GMFlex * (^)(CGFloat))basis;

#pragma mark - Width / height / height

/**
 The value specifies the view's width in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(void))autoWidth;

/**
 The value specifies the view's width in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))width;

/**
 The value specifies the view's width in percentage of its container width. The value must be non-negative.
 Example: view.flex.width(20%)
 */
- (GMFlex * (^)(CGFloat))widthWithPercent;

/**
 The value specifies the view's height in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(void))autoHeight;

/**
 The value specifies the view's height in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))height;

/**
 The value specifies the view's height in percentage of its container height. The value must be non-negative.
 Example: view.flex.height(40%)
 */
- (GMFlex * (^)(CGFloat))heightWithPercent;

/**
 The value specifies view's width and the height in pixels. Values must be non-negative.
 */
- (GMFlex * (^)(void))autoSize;

/**
 The value specifies view's width and the height in pixels. Values must be non-negative.
 */
- (GMFlex * (^)(CGSize))size;

/**
 The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative.
 */
- (GMFlex * (^)(CGFloat))sideLength;

/**
 Set minWidth to undefined
 */
- (GMFlex * (^)(void))undefinedMinWidth;

/**
 The value specifies the view's minimum width in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))minWidth;

/**
 The value specifies the view's minimum width in percentage of its container width. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))minWidthWithPercent;

/**
 Set maxWidth to undefined
 */
- (GMFlex * (^)(void))undefinedMaxWidth;

/**
 The value specifies the view's maximum width in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))maxWidth;

/**
 The value specifies the view's maximum width in percentage of its container width. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))maxWidthWithPercent;

/**
Set minHeight to undefined
 */
- (GMFlex * (^)(void))undefinedMinHeight;

/**
 The value specifies the view's minimum height in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))minHeight;

/**
 The value specifies the view's minimum height in percentage of its container height. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))minHeightWithPercent;

/**
 Set maxHeight to undefined
 */
- (GMFlex * (^)(void))undefinedMaxHeight;

/**
 The value specifies the view's maximum height in pixels. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))maxHeight;

/**
 The value specifies the view's maximum height in percentage of its container height. The value must be non-negative.
 */
- (GMFlex * (^)(CGFloat))maxHeightWithPercent;

/**
 Set aspectRatio to undefined
 */
- (GMFlex * (^)(void))undefinedAspectRatio;

/**
 AspectRatio is a property introduced by Yoga that don't exist in CSS. AspectRatio solves the problem of knowing
 one dimension of an element and an aspect ratio, this is very common when it comes to images, videos, and other
 media types. AspectRatio accepts any floating point value > 0, the default is undefined.
 
 - Parameter value:
 - Returns:
 */
- (GMFlex * (^)(CGFloat))aspectRatio;

/**
 AspectRatio is a property introduced by Yoga that don't exist in CSS. AspectRatio solves the problem of knowing
 one dimension of an element and an aspect ratio, this is very common when it comes to images, videos, and other
 media types. AspectRatio accepts any floating point value > 0, the default is undefined.
 
 - Parameter value:
 - Returns:
 */
- (GMFlex * (^)(UIImageView *))aspectRatioOfImageView;

#pragma mark - Absolute positionning

/**
 The position property tells Flexbox how you want your item to be positioned within its parent.
 
 - Parameter value: Default value is .relative
 */
- (GMFlex * (^)(GMFlexPosition))position;

/**
 Set the left edge distance from the container left edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))left;

/**
 Set the left edge distance from the container left edge in percentage of its container width.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))leftWithPercent;

/**
 Set the top edge distance from the container top edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))top;

/**
 Set the top edge distance from the container top edge in percentage of its container height.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))topWithPercent;

/**
 Set the right edge distance from the container right edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))right;

/**
 Set the right edge distance from the container right edge in percentage of its container width.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))rightWithPercent;

/**
 Set the bottom edge distance from the container bottom edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))bottom;

/**
 Set the bottom edge distance from the container bottom edge in percentage of its container height.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))bottomWithPercent;

/**
 Set the start edge (LTR=left, RTL=right) distance from the container start edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))start;

/**
 Set the start edge (LTR=left, RTL=right) distance from the container start edge in
 percentage of its container width.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))startWithPercent;

/**
 Set the end edge (LTR=right, RTL=left) distance from the container end edge in pixels.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))end;

/**
 Set the end edge (LTR=right, RTL=left) distance from the container end edge in
 percentage of its container width.
 This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
 */
- (GMFlex * (^)(CGFloat))endWithPercent;

#pragma mark - Margin

/**
 Set the top margin. Top margin specify the offset the top edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginTop;

/**
 Set margin top with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginTopWithPercent;

/**
 Set the left margin. Left margin specify the offset the left edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginLeft;

/**
 Set margin left with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginLeftWithPercent;

/**
 Set the bottom margin. Bottom margin specify the offset the bottom edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginBottom;

/**
 Set margin bottom with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginBottomWithPercent;

/**
 Set the right margin. Right margin specify the offset the right edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginRight;

/**
 Set margin right with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginRightWithPercent;

/**
 Set the start margin.
 
 Depends on the item `LayoutDirection`:
 * In LTR direction, start margin specify the offset the **left** edge of the item should have from it’s closest sibling (item) or parent (container).
 * IN RTL direction, start margin specify the offset the **right** edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginStart;

/**
 Set margin start with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginStartWithPercent;

/**
 Set the end margin.
 
 Depends on the item `LayoutDirection`:
 * In LTR direction, end margin specify the offset the **right** edge of the item should have from it’s closest sibling (item) or parent (container).
 * IN RTL direction, end margin specify the offset the **left** edge of the item should have from it’s closest sibling (item) or parent (container).
 */
- (GMFlex * (^)(CGFloat))marginEnd;

/**
 Set margin end with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginEndWithPercent;

/**
 Set the left, right, start, end to the specified value.
 */
- (GMFlex * (^)(CGFloat))marginHorizontal;

/**
 Set margin horizontal with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginHorizontalWithPercent;

/**
 Set the top and bottom margins to the specified value.
 */
- (GMFlex * (^)(CGFloat))marginVertical;

/**
 Set margin vertical with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginVerticalWithPercent;

/**
 Set all margins using UIEdgeInsets.
 This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
 */
- (GMFlex * (^)(UIEdgeInsets))marginWithInsets;

/**
 Set margins using NSDirectionalEdgeInsets.
 This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
 
 Available only on iOS 11 and higher.
 */
- (GMFlex * (^)(NSDirectionalEdgeInsets))marginWithDirectionalInsets NS_AVAILABLE_IOS(11_0);

/**
 Set all margins to the specified value.
 */
- (GMFlex * (^)(CGFloat))margin;

/**
 Set margin with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat))marginWithPercent;

/**
 Set the individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
 */
- (GMFlex * (^)(CGFloat, CGFloat))marginVH;

/**
 Set margin horizontal and vertical with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat, CGFloat))marginVHWithPercent;

/**
 Set all margins (top, left, bottom, right)
 */
- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))marginAll;

/**
 Set all margins with percent value, for example, width is 90%, the value should be 90.
 */
- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))marginAllWithPercent;

#pragma mark - Padding

/**
 Set the top padding. Top padding specify the **offset children should have** from the container's top edge.
 */
- (GMFlex * (^)(CGFloat))paddingTop;

/**
 Set the left padding. Left padding specify the **offset children should have** from the container's left edge.
 */
- (GMFlex * (^)(CGFloat))paddingLeft;

/**
 Set the bottom padding. Bottom padding specify the **offset children should have** from the container's bottom edge.
 */
- (GMFlex * (^)(CGFloat))paddingBottom;

/**
 Set the right padding. Right padding specify the **offset children should have** from the container's right edge.
 */
- (GMFlex * (^)(CGFloat))paddingRight;

/**
 Set the start padding.
 
 Depends on the item `LayoutDirection`:
 * In LTR direction, start padding specify the **offset children should have** from the container's left edge.
 * IN RTL direction, start padding specify the **offset children should have** from the container's right edge.
 */
- (GMFlex * (^)(CGFloat))paddingStart;

/**
 Set the end padding.
 
 Depends on the item `LayoutDirection`:
 * In LTR direction, end padding specify the **offset children should have** from the container's right edge.
 * IN RTL direction, end padding specify the **offset children should have** from the container's left edge.
 */
- (GMFlex * (^)(CGFloat))paddingEnd;

/**
 Set the left, right, start and end paddings to the specified value.
 */
- (GMFlex * (^)(CGFloat))paddingHorizontal;

/**
 Set the top and bottom paddings to the specified value.
 */
- (GMFlex * (^)(CGFloat))paddingVertical;

/**
 Set paddings using UIEdgeInsets.
 This method is particularly useful to set all paddings using iOS 11 `UIView.safeAreaInsets`.
 */
- (GMFlex * (^)(UIEdgeInsets))paddingWithInsets;

/**
 Set paddings using NSDirectionalEdgeInsets.
 This method is particularly to set all paddings using iOS 11 `UIView.directionalLayoutMargins`.
 
 Available only on iOS 11 and higher.
 */
- (GMFlex * (^)(NSDirectionalEdgeInsets))paddingWithDirectionalInsets NS_AVAILABLE_IOS(11_0);

/**
 Set all paddings to the specified value.
 */
- (GMFlex * (^)(CGFloat))padding;

/**
 Set the individually vertical paddings (top, bottom) and horizontal paddings (left, right, start, end).
 */
- (GMFlex * (^)(CGFloat, CGFloat))paddingVH;

/**
 Set all paddings (top, left, bottom, right)
 */
- (GMFlex * (^)(CGFloat, CGFloat, CGFloat, CGFloat))paddingAll;

#pragma mark - UIView Visual properties

/**
 Set the view background color.
 
 - Parameter color: new color
 - Returns: flex interface
 */
- (GMFlex * (^)(UIColor *))backgroundColor;

#pragma mark - Display

/**
 Set the view display or not
 */
- (GMFlex * (^)(GMFlexDisplay))display;

@end
