//
//  WDCheckBoxView.h
//
//  Created by Walter Da Col as part of WDCheckBoxView component
//  Copyright (c) 2013 Walter Da Col (walter.dacol<at>gmail.com)
//

#import <UIKit/UIKit.h>
/**
 You use the WDCheckBoxView class to create and manage checkboxes.
 
 The WDCheckBoxView class declares a property and a method to control its 
 checked/unchecked state. When the user manipulates the control (“check” it) a 
 UIControlEventValueChanged event is generated, which results in the control 
 (if properly configured) sending an action message.
 
 You can use appearance to customize the view. The checkbox drawing area will be
 always the biggest inscribed square inside the view's frame.
 
 Transition between checked <-> unchecked can be animated, highlight animation
 can be removed setting highlightScale to 0.0f
 */
@interface WDCheckBoxView : UIControl <UIAppearance>

// Border property
/// The color used to tint the appearance of the border's stroke when checked
@property(nonatomic, retain) UIColor *checkedBorderStrokeColor UI_APPEARANCE_SELECTOR;
/// The color used to tint the appearance of the border's stroke when unchecked
@property(nonatomic, retain) UIColor *uncheckedBorderStrokeColor UI_APPEARANCE_SELECTOR;
/// The color used to fill the border's area when checked
@property(nonatomic, retain) UIColor *checkedBorderFillColor UI_APPEARANCE_SELECTOR;
/// The color used to fill the border's area when unchecked
@property(nonatomic, retain) UIColor *uncheckedBorderFillColor UI_APPEARANCE_SELECTOR;

// Symbol property
/// The color used to tint the appearance of the symbol's stroke when checked
@property(nonatomic, retain) UIColor *checkedSymbolStrokeColor UI_APPEARANCE_SELECTOR;
/// The color used to tint the appearance of the symbol's stroke when unchecked
@property(nonatomic, retain) UIColor *uncheckedSymbolStrokeColor UI_APPEARANCE_SELECTOR;
/// The color used to fill the symbol's area when checked
@property(nonatomic, retain) UIColor *checkedSymbolFillColor UI_APPEARANCE_SELECTOR;
/// The color used to fill the symbol's area when unchecked
@property(nonatomic, retain) UIColor *uncheckedSymbolFillColor UI_APPEARANCE_SELECTOR;

// General values
/// The value used to set the size of checkbox draw when checked (based on view bounds)
@property(nonatomic) CGFloat checkedScale UI_APPEARANCE_SELECTOR;
/// The value used to set the size of checkbox draw when unchecked (based on view bounds)
@property(nonatomic) CGFloat uncheckedScale UI_APPEARANCE_SELECTOR;
/// When highlighted this component make a small animation that shrink/expand its draw by a small amount. This value set that amount
@property(nonatomic) CGFloat highlightScale UI_APPEARANCE_SELECTOR;
/// The value used to set the transition duration
@property(nonatomic) double animationDuration UI_APPEARANCE_SELECTOR;

/// A Boolean value that determines the checked/unchecked state of the control.
@property(nonatomic, getter=isChecked) BOOL checked;

/**
 Set the state of the control to checked or unchecked, optionally animating the 
 transition.
 
 @param checked YES if the control should be turned to the checked symbol;
 NO if it should be turned to the unchecked symbol. If the control is already 
 in the designated position, nothing happens.
 @param animated YES to animate the state-change of the control; otherwise NO.
 */
- (void)setChecked:(BOOL)checked animated:(BOOL)animated;
@end
