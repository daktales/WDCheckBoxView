//
//  WDCheckBoxView.m
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#import "WDCheckBoxView.h"
#import "WDCheckBoxGeometryUtility.h"
#import "UIBezierPath+WDCheckBoxPaths.h"

@interface WDCheckBoxView()
@property (nonatomic,retain) CAShapeLayer *borderLayer;
@property (nonatomic,retain) CAShapeLayer *symbolLayer;
@end

@implementation WDCheckBoxView
NSString *const kResizeAnimationKey = @"resize";
NSString *const kHighlightAnimationKey = @"highlight";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _checked = NO;
        _checkedBorderFillColor = [UIColor clearColor];
        _checkedBorderStrokeColor = [UIColor colorWithRed:41.0f/255.0f green:128.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
        _checkedSymbolFillColor = [UIColor colorWithRed:41.0f/255.0f green:128.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
        _checkedSymbolStrokeColor = [UIColor whiteColor];
        _checkedScale = 0.9f;
        _uncheckedBorderFillColor = [UIColor clearColor];
        _uncheckedBorderStrokeColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
        _uncheckedSymbolFillColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
        _uncheckedSymbolStrokeColor = [UIColor whiteColor];
        _uncheckedScale = 0.7f;
        _highlightScale = 0.02f;
        _animationDuration = 0.4;
        
        [self setOpaque:NO];

        self.borderLayer = [self layerForBorder];
        
        self.symbolLayer = [self layerForSymbol];
        
        [self.layer addSublayer:self.borderLayer];
        [self.layer addSublayer:self.symbolLayer];
        [self updateBorderLayerModel];
        [self updateSymbolLayerModel];
    }
    return self;
}

#pragma mark - Layers managment

/**
 Class for border layer
 */
- (CAShapeLayer *)layerForBorder{
    return [CAShapeLayer layer];
}

/**
 Read layer property from view property
 */
- (void)updateBorderLayerModel{
    // State values
    if (self.checked) {
        [self.borderLayer setFillColor:self.checkedBorderFillColor.CGColor];
        [self.borderLayer setStrokeColor:self.checkedBorderStrokeColor.CGColor];
    } else {
        [self.borderLayer setFillColor:self.uncheckedBorderFillColor.CGColor];
        [self.borderLayer setStrokeColor:self.uncheckedBorderStrokeColor.CGColor];
    }
}

/**
 Recalculate border layer size/position using superlayer data
 */
- (void)layoutBorderLayer{
    // Setting layer frame
    [self.borderLayer setBounds:CGRectMake(0,
                                           0,
                                           self.bounds.size.width,
                                           self.bounds.size.height)];
    [self.borderLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [self.borderLayer setPosition:CGPointMake(CGRectGetMidX(self.borderLayer.superlayer.bounds),
                                              CGRectGetMidY(self.borderLayer.superlayer.bounds))];
    
    // Shape
    CGRect drawRect = CGRectInsetForScale(self.borderLayer.bounds, self.checked ? self.checkedScale : self.uncheckedScale);
    
    // Setting layer property
    [self.borderLayer setLineWidth:[UIBezierPath  lineWidthForBorderFromSize:drawRect.size]];
    
    // Setting layer path
    [self.borderLayer setPath:[UIBezierPath bezierPathWithBorderInRect:drawRect].CGPath];
}

/**
 Class for symbol layer
 */
- (CAShapeLayer *)layerForSymbol{
    return [CAShapeLayer layer];
}

/**
 Read layer property from view property
 */
- (void)updateSymbolLayerModel{
    // State values
    if (self.checked) {
        [self.symbolLayer setFillColor:self.checkedSymbolFillColor.CGColor];
        [self.symbolLayer setStrokeColor:self.checkedSymbolStrokeColor.CGColor];
    } else {
        [self.symbolLayer setFillColor:self.uncheckedSymbolFillColor.CGColor];
        [self.symbolLayer setStrokeColor:self.uncheckedSymbolStrokeColor.CGColor];
    }
}

/**
 Recalculate symbol layer size/position using superlayer data
 */
- (void)layoutSymbolLayer{
    // Setting layer frame
    [self.symbolLayer setBounds:CGRectMake(0,
                                           0,
                                           self.bounds.size.width,
                                           self.bounds.size.height)];
    [self.symbolLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [self.symbolLayer setPosition:CGPointMake(CGRectGetMidX(self.symbolLayer.superlayer.bounds),
                                              CGRectGetMidY(self.symbolLayer.superlayer.bounds))];
    
    // Shape
    CGRect drawRect = CGRectInsetForScale(self.symbolLayer.bounds, self.checked ? self.checkedScale : self.uncheckedScale);
    
    // Setting layer property
    [self.symbolLayer setLineWidth:0.0f];
    
    // Setting layer path
    if (self.checked){
        [self.symbolLayer setPath:[UIBezierPath bezierPathWithCheckmarkInRect:drawRect].CGPath];
    } else {
        [self.symbolLayer setPath:[UIBezierPath bezierPathWithCrossInRect:drawRect].CGPath];
    }
}

/**
 Set sublayers property when view resize/move
 
 @param layer Layer which need to layout sublayer
 */

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    if (layer == self.layer){
        [self layoutBorderLayer];
        [self layoutSymbolLayer];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self updateBorderLayerModel];
    [self updateSymbolLayerModel];
}

#pragma mark - Animations

/**
 Using _animationDuration as a base for complete animation, this method
 estimates a duration for a partial animation
 
 @param rect Bounding box of current path situation (presentation layer)
 @param scale Target scale
 */
- (CFTimeInterval)estimateResizeAnimationIntervalFromPresentationLayerRect:(CGRect)rect toScale:(CGFloat)scale{
    // FIXME: This is a bit of an hack because we take a square rect out of nowhere
    // If we change the path drawing methods we must fix this thing otherwise
    // we'll end in stupid errors
    CGFloat rectScale = CGRectGetSideScaleRatioBetweenRects(CGRectGetBiggestInscribedSquareInRect(self.bounds), rect);
    CGFloat baseScaleDifference = fabsf(self.checkedScale - self.uncheckedScale);
    
    return (double)((fabsf(rectScale - scale) * self.animationDuration) / baseScaleDifference);
}

/**
 An animation to change paths
 
 @param layer Target layer
 @param path Value to be set
 */
- (CABasicAnimation *)animationForLayer:(CAShapeLayer *)layer reshapeToPath:(CGPathRef)path{
    // Animation for path
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    // From current path
    animation.fromValue = (__bridge id)([layer.presentationLayer path]);
    
    // To resized path
    animation.toValue = (__bridge id)(path);
    
    // Set layer property
    [layer setPath:path];
    
    return animation;
}

/**
 An animation to resize Border layer to checked state
 
 @param checked Value to be set
 */
- (CABasicAnimation *)animationForBorderLayerResizeToChecked:(BOOL)checked{
    CGFloat toScale = checked ? self.checkedScale : self.uncheckedScale;
    
    // Draw a resized path
    CGPathRef toPath = ([UIBezierPath bezierPathWithBorderInRect:CGRectInsetForScale(self.borderLayer.bounds, toScale)]).CGPath;
    
    return [self animationForLayer:self.borderLayer reshapeToPath:toPath];
}

/**
 An animation to resize Symbol layer to checked state
 
 @param checked Value to be set
 */
- (CABasicAnimation *)animationForSymbolResizeToChecked:(BOOL)checked{
    
    // Draw a resized path
    CGPathRef toPath;
    if (checked){
        toPath = [UIBezierPath bezierPathWithCheckmarkInRect:
                  CGRectInsetForScale(self.symbolLayer.bounds, self.checkedScale)].CGPath;
    } else {
        toPath = [UIBezierPath bezierPathWithCrossInRect:
                  CGRectInsetForScale(self.symbolLayer.bounds, self.uncheckedScale)].CGPath;
    }
    
    return [self animationForLayer:self.symbolLayer reshapeToPath:toPath];
}

/**
 An animation to change lineWidth property.
 In this component the border stroke resize along its path so when you resize
 border path (using a scale value) you can use the same scale value to get a
 correct lineWidth (correct in a 'right ratio' mean)
 
 @param layer Target layer
 @param scale Scale used for border path
 */
- (CABasicAnimation *)animationForLayer:(CAShapeLayer *)layer resizeLineWidthToBoundsScale:(CGFloat)scale{
    
    // Estimate lineWidth for new scale
    CGFloat toWidth = [UIBezierPath lineWidthForBorderFromSize:CGRectInsetForScale(layer.bounds, scale).size];
    
    // Create lineWidth animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    
    // From current value
    animation.fromValue = @([layer.presentationLayer lineWidth]);
    
    // To estimated value
    animation.toValue = @(toWidth);
    
    // Set layer property
    [layer setLineWidth:toWidth];
    
    return animation;
}

/**
 An animation to change strokeColor property
 
 @param layer Target layer
 @param color Color to be set
 */
- (CABasicAnimation *)animationForLayer:(CAShapeLayer *)layer colorizeStrokeToColor:(UIColor *)color{
    
    // Animation for strokeColor
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    
    // From current strokeColor
    animation.fromValue = (__bridge id)([layer.presentationLayer strokeColor]);
    
    // To color
    animation.toValue = (__bridge id)(color.CGColor);
    
    // Set layer property
    [layer setStrokeColor:color.CGColor];
    
    return animation;
}

/**
 An animation to change fillColor property
 
 @param layer Target layer
 @param color Color to be set
 */
- (CABasicAnimation *)animationForLayer:(CAShapeLayer *)layer colorizeFillToColor:(UIColor *)color{
    
    // Create fillColor animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    
    // From current color
    animation.fromValue = (__bridge id)([layer.presentationLayer fillColor]);
    
    // To color
    animation.toValue = (__bridge id)(color.CGColor);
    
    // Set layer property
    [layer setFillColor:color.CGColor];
    
    return animation;
}

/**
 A group of animation applyed to border layer when checked state change
 
 @param checked Value to be set
 */
- (CAAnimationGroup *)animationGroupForBorderToSwitchCheckedState:(BOOL)checked{
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    NSMutableArray *animationArray = [NSMutableArray array];
    UIColor *toFillColor;
    UIColor *toStrokeColor;
    CGFloat toScale;
    
    // Set values
    if (checked){
        toFillColor = self.checkedBorderFillColor;
        toStrokeColor = self.checkedBorderStrokeColor;
        toScale = self.checkedScale;
    } else {
        toFillColor = self.uncheckedBorderFillColor;
        toStrokeColor = self.uncheckedBorderStrokeColor;
        toScale = self.uncheckedScale;
    }
   
    // Change colors
    [animationArray addObject:[self animationForLayer:self.borderLayer colorizeFillToColor:toFillColor]];
    [animationArray addObject:[self animationForLayer:self.borderLayer colorizeStrokeToColor:toStrokeColor]];
    
    // Change path
    [animationArray addObject:[self animationForBorderLayerResizeToChecked:checked]];
    [animationArray addObject:[self animationForLayer:self.borderLayer resizeLineWidthToBoundsScale:toScale]];
    
    animationGroup.animations = [NSArray arrayWithArray:animationArray];
    
    return animationGroup;
}

/**
 A group of animation applyed to symbol layer when checked state change
 
 @param checked Value to be set
 */
- (CAAnimationGroup *)animationGroupForSymbolToSwitchCheckedState:(BOOL)checked{
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    NSMutableArray *animationArray = [NSMutableArray array];
    UIColor *toFillColor;
    UIColor *toStrokeColor;
    CGFloat toScale;
    
    // Set values
    if (checked){
        toFillColor = self.checkedSymbolFillColor;
        toStrokeColor = self.checkedSymbolStrokeColor;
        toScale = self.checkedScale;
    } else {
        toFillColor = self.uncheckedSymbolFillColor;
        toStrokeColor = self.uncheckedSymbolStrokeColor;
        toScale = self.uncheckedScale;
    }
    
    // Change colors
    [animationArray addObject:[self animationForLayer:self.symbolLayer colorizeFillToColor:toFillColor]];
    [animationArray addObject:[self animationForLayer:self.symbolLayer colorizeStrokeToColor:toStrokeColor]];
    
    // Change path
    [animationArray addObject:[self animationForSymbolResizeToChecked:checked]];
    
    animationGroup.animations = [NSArray arrayWithArray:animationArray];
    
    return animationGroup;
}

/**
 A group of animation applyed to border layer when highlight state change
 
 @param highlighted Value to be set
 */
- (CAAnimationGroup *)animationGroupForBorderToSwitchHighlightState:(BOOL)highlighted{
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    NSMutableArray *animationArray = [NSMutableArray array];
    CGFloat toScale;
    
    // To reverse animation on unlight
    CGFloat difference = highlighted ? self.highlightScale : 0.0f;
    
    // Set values
    if (self.checked){
        toScale = self.checkedScale - difference;
    } else {
        toScale = self.uncheckedScale + difference;
    }
    
    // Draw a resized path
    CGPathRef toPath = ([UIBezierPath bezierPathWithBorderInRect:CGRectInsetForScale(self.borderLayer.bounds, toScale)]).CGPath;
    
    // Change path
    [animationArray addObject:[self animationForLayer:self.borderLayer reshapeToPath:toPath]];
    [animationArray addObject:[self animationForLayer:self.borderLayer resizeLineWidthToBoundsScale:toScale]];

    animationGroup.animations = [NSArray arrayWithArray:animationArray];
   
    return animationGroup;
}

/**
 A group of animation applyed to symbol layer when highlight state change
 
 @param highlighted Value to be set
 */
- (CAAnimationGroup *)animationGroupForSymbolToSwitchHighlightState:(BOOL)highlighted{
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    NSMutableArray *animationArray = [NSMutableArray array];
    CGFloat toScale;
    CGPathRef toPath;
    
    // To reverse animation on de-highlight
    CGFloat difference = highlighted ? self.highlightScale : 0.0f;
    
    // Set values
    if (self.checked){
        toScale = self.checkedScale - difference;
        toPath = ([UIBezierPath bezierPathWithCheckmarkInRect:CGRectInsetForScale(self.borderLayer.bounds, toScale)]).CGPath;
    } else {
        toScale = self.uncheckedScale + difference;
        toPath = ([UIBezierPath bezierPathWithCrossInRect:CGRectInsetForScale(self.borderLayer.bounds, toScale)]).CGPath;
    }
    
    // Change path
    [animationArray addObject:[self animationForLayer:self.symbolLayer reshapeToPath:toPath]];
    
    animationGroup.animations = [NSArray arrayWithArray:animationArray];
    return animationGroup;

}

#pragma mark - controls

/**
 Overrided only to send value changed event
 
 @param checked Value to be set
 */
- (void)setChecked:(BOOL)checked{
    _checked = checked;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setChecked:(BOOL)checked animated:(BOOL)animated{
    
    [self setChecked:checked];
    
    // Animation
    if (animated){
        
        [CATransaction lock];
        [CATransaction setDisableActions:YES];
        [CATransaction begin]; {
            
            // Remove highlight animation because we are resizing the view
            [self.borderLayer removeAnimationForKey:kHighlightAnimationKey];
            [self.symbolLayer removeAnimationForKey:kHighlightAnimationKey];
            
            CGRect fromRect = CGPathGetBoundingBox([self.borderLayer.presentationLayer path]);
            CGFloat toScale = checked ? self.checkedScale : self.uncheckedScale;
            
            // Defining animation property
            // Duration is variable because we can reverse resize animation
            // before completion (tapping again in the middle of another
            // resize animation)
            CFTimeInterval duration = [self estimateResizeAnimationIntervalFromPresentationLayerRect:fromRect toScale:toScale];
            [CATransaction setAnimationDuration:duration];
            
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            
            [CATransaction setCompletionBlock:^{
                // Nothing
            }];
            
            // Add animation groups to queue
            [self.borderLayer addAnimation:[self animationGroupForBorderToSwitchCheckedState:checked] forKey:kResizeAnimationKey];
            [self.symbolLayer addAnimation:[self animationGroupForSymbolToSwitchCheckedState:checked] forKey:kResizeAnimationKey];
            
        }
        [CATransaction commit];
        [CATransaction setDisableActions:NO];
        [CATransaction unlock];
        
    }
}

/**
 This method is called in a loop until system receive a TouchUp event after a TouchDown inside event.
 Highlight and De-Highlight event are animated with a small shrink/expand animation.
 
 **The animation are not performed if a resize animation is in progress.**
 
 @param highlighted Control highlight status
 */
- (void) setHighlighted:(BOOL)highlighted{
    
    // Check if animation has sense
    if (self.highlightScale > 0.0f){
        
        // Check if we have a status change
        if ((!self.highlighted && highlighted)||(self.highlighted && !highlighted)){
            
            // Check if there is an animation in progress, if there is a resize in progress we don't
            // want to highlight nothing
            if (([self.borderLayer animationForKey:kResizeAnimationKey] == nil)&&
                ([self.symbolLayer animationForKey:kResizeAnimationKey] == nil)){
                
                [CATransaction lock];
                [CATransaction setDisableActions:YES];
                [CATransaction begin]; {
                    
                    // Highlight duration is related to resize duration (min value 0.25 sec to avoid graphical issues)
                    CFTimeInterval duration = MAX(
                                                  (double)((self.highlightScale / fabsf(self.checkedScale - self.uncheckedScale)) * self.animationDuration),
                                                  0.25
                                                  );
                    [CATransaction setAnimationDuration:duration];
                    
                    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    
                    // Add animation groups to queue
                    [self.borderLayer addAnimation:[self animationGroupForBorderToSwitchHighlightState:highlighted] forKey:kHighlightAnimationKey];
                    [self.symbolLayer addAnimation:[self animationGroupForSymbolToSwitchHighlightState:highlighted] forKey:kHighlightAnimationKey];
                    
                }
                [CATransaction commit];
                [CATransaction setDisableActions:NO];
                [CATransaction unlock];
            }
        }
    }
    
    // If called before animation results in wrong behaviors
    [super setHighlighted:highlighted];
}

@end
