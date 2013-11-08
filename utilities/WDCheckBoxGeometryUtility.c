//
//  WDCheckBoxGeometryUtility.c
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#include "WDCheckBoxGeometryUtility.h"
#include <math.h>

CGPoint CGPointCenterOfRect(CGRect rect){
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect CGRectInsetForScale(CGRect rect, CGFloat scale){
    CGFloat dx = rect.size.width * (1.0f - scale) * 0.5f;
    CGFloat dy = rect.size.height * (1.0f - scale) * 0.5f;
    return CGRectInset(rect, dx, dy);
}

CGRect CGRectGetBiggestInscribedSquareInRect(CGRect rect){
    CGFloat squareSide = fminf(rect.size.height,rect.size.width);
    CGFloat dx = (rect.size.width - squareSide) / 2.0f;
    CGFloat dy = (rect.size.height - squareSide) / 2.0f;
    return CGRectInset(rect, dx, dy);
}

CGFloat CGRectSurface(CGRect rect){
    return rect.size.width * rect.size.height;
}

CGFloat CGRectGetSideScaleRatioBetweenRects(CGRect rectA, CGRect rectB){
    return sqrtf(CGRectSurface(rectB)) / sqrtf(CGRectSurface(rectA));
}
