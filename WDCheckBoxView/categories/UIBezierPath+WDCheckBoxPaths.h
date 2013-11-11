//
//  UIBezierPath+WDCheckBoxPaths.h
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#import <UIKit/UIKit.h>

/**
 Category of UIBezierPath which provides some other basic path:
 - Border: like Oval
 - Checkmark: a centered checkmark symbol
 - Cross: a centered x symbol
 */
@interface UIBezierPath (WDCheckBoxPaths)
/**
 Estimate border path lineWidth property
 
 @param size Drawing area size
 */
+ (CGFloat)lineWidthForBorderFromSize:(CGSize)size;

/**
 Create the bezier path for checkbox external border
 
 @param rect Drawing area
 */
+ (UIBezierPath *)bezierPathWithBorderInRect:(CGRect)rect;

/**
 Create the bezier path for checkmark symbol
 
 @param rect Drawing area
 */
+ (UIBezierPath *)bezierPathWithCheckmarkInRect:(CGRect)rect;

/**
 Create the bezier path for cross symbol
 
 @param rect Drawing area
 */
+ (UIBezierPath *)bezierPathWithCrossInRect:(CGRect)rect;
@end
