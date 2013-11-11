//
//  UIBezierPath+WDCheckBoxPaths.h
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#import "UIBezierPath+WDCheckBoxPaths.h"
#import "WDCheckBoxGeometryUtility.h"

@implementation UIBezierPath (WDCheckBoxPaths)

/**
 Paths has been created using an svg as a base. The svg bounding box was 
 130px * 130px and the smallest measure between two points in my draw was 5px 
 and the other measures were multiplier of 10px. Using a constant like this I 
 can rescale everything.
 */
+ (CGFloat)checkBoxBaseUnitFraction{
    static CGFloat value;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = 1.0f/26.0f;
    });
    return value;
}

/**
 Estimate smallest measure starting from a given size
 
 @param size Drawing area size
 */
+ (CGFloat)checkBoxBaseUnitFromSize:(CGSize)size{
    CGFloat checkBoxSideLenght = MIN(size.width, size.height);
    return (checkBoxSideLenght * [UIBezierPath checkBoxBaseUnitFraction]);
}

/**
 Estimate border path lineWidth property
 
 @param size Drawing area size
 */
+ (CGFloat)lineWidthForBorderFromSize:(CGSize)size{
    return 2.0f * [UIBezierPath checkBoxBaseUnitFromSize:size];
}

+ (UIBezierPath *)bezierPathWithBorderInRect:(CGRect)rect{
    return [UIBezierPath bezierPathWithOvalInRect:CGRectGetBiggestInscribedSquareInRect(rect)];
}

+ (UIBezierPath *)bezierPathWithCheckmarkInRect:(CGRect)rect{
    // Drawing area and base units
    CGRect box = CGRectGetBiggestInscribedSquareInRect(rect);
    CGFloat boxBaseUnit = [UIBezierPath checkBoxBaseUnitFromSize:box.size];
    CGFloat boxSQRT2BaseUnit = boxBaseUnit * M_SQRT2;
    
    // Path origin
    CGPoint pathBoxOrigin = CGPointMake(box.origin.x + (03.0f * boxBaseUnit),box.origin.y + (01.0f * boxBaseUnit));
    
    // Inside this path there are more points. This are necessary to match Cross
    // path creating a better animation.
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(pathBoxOrigin.x  + (00.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (08.0f * boxSQRT2BaseUnit))]; // 0
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (02.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (06.0f * boxSQRT2BaseUnit))]; // 1
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (06.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (10.0f * boxSQRT2BaseUnit))]; // 2
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (12.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (04.0f * boxSQRT2BaseUnit))]; // 3
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (14.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (06.0f * boxSQRT2BaseUnit))]; // 4
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (08.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (12.0f * boxSQRT2BaseUnit))]; // 5 *
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (08.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (12.0f * boxSQRT2BaseUnit))]; // 6 *
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (06.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (14.0f * boxSQRT2BaseUnit))]; // 7 *
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (06.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (14.0f * boxSQRT2BaseUnit))]; // 8
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (06.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (14.0f * boxSQRT2BaseUnit))]; // 9 *
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (04.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (12.0f * boxSQRT2BaseUnit))]; // 10 *
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (04.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (12.0f * boxSQRT2BaseUnit))]; // 11 *
    
    [path closePath];
    return path;
}

+ (UIBezierPath *)bezierPathWithCrossInRect:(CGRect)rect{
    // Drawing area and base units
    CGRect box = CGRectGetBiggestInscribedSquareInRect(rect);
    CGFloat boxBaseUnit = [UIBezierPath checkBoxBaseUnitFromSize:box.size];
    CGFloat boxSQRT2BaseUnit = boxBaseUnit * M_SQRT2;
    
    // Path origin (calculated from center)
    CGPoint pathBoxOrigin = CGPointMake(box.origin.x + (13.0f * boxBaseUnit - 05.0f * boxSQRT2BaseUnit),
                                        box.origin.y + (13.0f * boxBaseUnit - 05.0f * boxSQRT2BaseUnit));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(pathBoxOrigin.x + (00.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (02.0f * boxSQRT2BaseUnit))]; // 0
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (02.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (00.0f * boxSQRT2BaseUnit))]; // 1
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (05.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (03.0f * boxSQRT2BaseUnit))]; // 2
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (08.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (00.0f * boxSQRT2BaseUnit))]; // 3
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (10.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (02.0f * boxSQRT2BaseUnit))]; // 4
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (07.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (05.0f * boxSQRT2BaseUnit))]; // 5
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (10.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (08.0f * boxSQRT2BaseUnit))]; // 6
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (08.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (10.0f * boxSQRT2BaseUnit))]; // 7
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (05.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (07.0f * boxSQRT2BaseUnit))]; // 8
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (02.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (10.0f * boxSQRT2BaseUnit))]; // 9
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (00.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (08.0f * boxSQRT2BaseUnit))]; // 10
    [path addLineToPoint:CGPointMake(pathBoxOrigin.x + (03.0f * boxSQRT2BaseUnit), pathBoxOrigin.y + (05.0f * boxSQRT2BaseUnit))]; // 11
    
    [path closePath];
    return path;
}
@end
