//
//  WDCheckBoxGeometryUtility.h
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#ifndef WDCHECKBOXGEOMETRYUTILITY_H_
#define WDCHECKBOXGEOMETRYUTILITY_H_

#include <CoreGraphics/CoreGraphics.h>

/**
 Calculate CGRect center
 
 @param rect A CGRect
 */
CGPoint CGPointCenterOfRect(CGRect rect);

/**
 Get a new CGRect which is a scaled copy of the given one
 
 @param rect A CGRect
 @param scale Choosen scale 1.0f = 100%
 */
CGRect CGRectInsetForScale(CGRect rect, CGFloat scale);

/**
 Get a new CGRect which is the biggest square that can be inscribed inside 
 given rect
 
 @param rect A CGRect
 */
CGRect CGRectGetBiggestInscribedSquareInRect(CGRect rect);

/**
 Estimate the side's scale of rectB using rectA as reference (1.0f)
  
 @param rectA Reference CGRect
 @param rectB A CGRect
 */
CGFloat CGRectGetSideScaleRatioBetweenRects(CGRect rectA, CGRect rectB);

#endif /* WDCHECKBOXGEOMETRYUTILITY_H_ */
