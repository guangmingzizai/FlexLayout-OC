//
//  GMFlexDefinitions.h
//  Pods
//
//  Created by ypf on 2018/9/1.
//

#ifndef GMFlexDefinitions_h
#define GMFlexDefinitions_h

#import <YogaKit/YGLayout.h>

typedef NS_ENUM(int, GMFlexDirection) {
    /// Default value. The flexible items are displayed vertically, as a column.
    GMFlexDirectionColumn = YGFlexDirectionColumn,
    /// Same as column, but in reverse order
    GMFlexDirectionColumnReverse = YGFlexDirectionColumnReverse,
    /// The flexible items are displayed horizontally, as a row.
    GMFlexDirectionRow = YGFlexDirectionRow,
    /// Same as row, but in reverse order
    GMFlexDirectionRowReverse = YGFlexDirectionRowReverse
};

typedef NS_ENUM(int, GMFlexJustifyContent) {
    /// Default value. Items are positioned at the beginning of the container.
    GMFlexJustifyContentStart = YGJustifyFlexStart,
    /// Items are positioned at the center of the container
    GMFlexJustifyContentCenter = YGJustifyCenter,
    /// Items are positioned at the end of the container
    GMFlexJustifyContentEnd = YGJustifyFlexEnd,
    /// Items are positioned with space between the lines
    GMFlexJustifyContentSpaceBetween = YGJustifySpaceBetween,
    /// Items are positioned with space before, between, and after the lines
    GMFlexJustifyContentSpaceAround = YGJustifySpaceAround,
    /// Items are positioned with space distributed evenly, items have equal space around them.
    GMFlexJustifyContentSpaceEvenly = YGJustifySpaceEvenly,
};

typedef NS_ENUM(int, GMFlexAlignContent) {
    /// Default value. Lines stretch to take up the remaining space
    GMFlexAlignContentStretch = YGAlignStretch,
    /// Lines are packed toward the start of the flex container
    GMFlexAlignContentStart = YGAlignFlexStart,
    /// Lines are packed toward the center of the flex container
    GMFlexAlignContentCenter = YGAlignCenter,
    /// Lines are packed toward the end of the flex container
    GMFlexAlignContentEnd = YGAlignFlexEnd,
    /// Lines are evenly distributed in the flex container
    GMFlexAlignContentSpaceBetween = YGAlignSpaceBetween,
    /// Lines are evenly distributed in the flex container, with half-size spaces on either end
    GMFlexAlignContentSpaceAround = YGAlignSpaceAround,
};

typedef NS_ENUM(int, GMFlexAlignItems) {
    /// Default. Items are stretched to fit the container
    GMFlexAlignItemsStretch = YGAlignStretch,
    /// Items are positioned at the beginning of the container
    GMFlexAlignItemsStart = YGAlignFlexStart,
    /// Items are positioned at the center of the container
    GMFlexAlignItemsCenter = YGAlignCenter,
    /// Items are positioned at the end of the container
    GMFlexAlignItemsEnd = YGAlignFlexEnd,
    /// Items are positioned at the baseline of the container
    // Not currently supported by Yoga.
    //GMFlexAlignItemsBaseline
};

typedef NS_ENUM(int, GMFlexAlignSelf) {
    /// Default. The element inherits its parent container's align-items property, or "stretch" if it has no parent container
    GMFlexAlignSelfAuto = YGAlignAuto,
    /// The element is positioned to fit the container
    GMFlexAlignSelfStretch = YGAlignStretch,
    /// The element is positioned at the beginning of the container
    GMFlexAlignSelfStart = YGAlignFlexStart,
    /// The element is positioned at the center of the container
    GMFlexAlignSelfCenter = YGAlignCenter,
    /// The element is positioned at the end of the container
    GMFlexAlignSelfEnd = YGAlignFlexEnd,
    /// The element is positioned at the baseline of the container
    GMFlexAlignSelfBaseline = YGAlignBaseline,
};

typedef NS_ENUM(int, GMFlexWrapMode) {
    /// Default value. Specifies that the flexible items will not wrap
    GMFlexNoWrap = YGWrapNoWrap,
    /// Specifies that the flexible items will wrap if necessary
    GMFlexWrap = YGWrapWrap,
    /// Specifies that the flexible items will wrap, if necessary, in reverse order
    GMFlexWrapReverse = YGWrapWrapReverse,
};

typedef NS_ENUM(int, GMFlexPosition) {
    /// Default value.
    GMFlexPositionRelative = YGPositionTypeRelative,
    /// Positioned absolutely in regards to its container. The item is positionned using properties top, bottom, left, right, start, end.
    GMFlexPositionAbsolute = YGPositionTypeAbsolute,
};

typedef NS_ENUM(int, GMFlexLayoutDirection) {
    /// Default value.
    GMFlexLayoutDirectionInherit = YGDirectionInherit,
    /// Left to right layout direction
    GMFlexLayoutDirectionLTR = YGDirectionLTR,
    /// Right to right layout direction
    GMFlexLayoutDirectionRTL = YGDirectionRTL,
    /// Detected automatically
//    GMFlexLayoutDirectionAuto,
};

/**
 Defines how the `layout(mode:)` method layout its flex items.
 */
typedef NS_ENUM(NSUInteger, GMFlexLayoutMode) {
    /// This is the default mode when no parameter is specified. Children are layouted **inside** the container's size (width and height).
    GMFlexLayoutModeFitContainer,
    /// In this mode, children are layouted **using only the container's width**. The container's height will be adjusted to fit the flexbox's children
    GMFlexLayoutModeAdjustHeight,
    /// In this mode, children are layouted **using only the container's height**. The container's width will be adjusted to fit the flexbox's children
    GMFlexLayoutModeAdjustWidth,
};

typedef NS_ENUM(int, GMFlexDisplay) {
    /// Default value
    GMFlexDisplayFlex = YGDisplayFlex,
    /// With this value, the item will be hidden and not be calculated
    GMFlexDisplayNone = YGDisplayNone,
};

#endif /* GMFlexDefinitions_h */
