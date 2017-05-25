//
//  StackViewAnimator.m
//  Pods
//
//  Created by Sandeep Aggarwal on 24/05/17.
//
//

#import "StackViewAnimator.h"

@implementation StackViewAnimator

#pragma mark - <ZLSwipeableViewAnimator>

- (void)animateView:(UIView *)view index:(NSUInteger)index views:(NSArray<UIView *> *)views swipeableView:(ZLSwipeableView *)swipeableView
{
    [self adjustOpacityOfView:view forIndex:index];
    if (index == 0)
    {
        [self animateCardToFront:view swipeableView:swipeableView];
    }
    else
    {
        [self animateCardToBack:view atIndex:index swipeableView:swipeableView];
    }
}

#pragma mark - Private Methods

- (void)adjustOpacityOfView:(UIView*)view forIndex:(NSUInteger)index
{
    CGFloat alpha = 1.0;
    switch (index)
    {
        case 0:
            alpha = 1.0;
            break;
            
        case 1:
            alpha = 0.9;
            break;
            
        case 2:
            alpha = 0.7;
            break;
            
        default:
            alpha = 1.0;
            break;
    }
    [view setAlpha:alpha];
}

- (void)animateCardToFront:(UIView*)cardView swipeableView:(ZLSwipeableView *)swipeableView
{
    //the card to be animated to front must had been at index = 1 before
    CGAffineTransform index1Transform = [self transformForViewAtIndex:1 swipeableView:swipeableView];
    if (!CGAffineTransformEqualToTransform(cardView.transform, index1Transform))
    {
        // no need to set transform (Could be a case when card view is set to another tranform from somewhere in the application)
        return;
    }
    
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionTransitionNone) animations:^
     {
         cardView.transform = CGAffineTransformIdentity;
     } completion:nil];
}

- (void)animateCardToBack:(UIView*)cardView atIndex:(NSInteger)index swipeableView:(ZLSwipeableView *)swipeableView
{
    CGAffineTransform transform = [self transformForViewAtIndex:index swipeableView:swipeableView];
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionTransitionNone) animations:^
     {
         cardView.transform = transform;
     } completion:nil];
}

- (CGAffineTransform)transformForViewAtIndex:(NSInteger)index swipeableView:(ZLSwipeableView *)swipeableView
{
    CGFloat xScaleFactor = [self xScaleFactorForIndex:index];
    CGFloat yScaleFactor = [self yScaleFactorForIndex:index];
    
    CGFloat yTranslation = [self verticalTranslationWithYScale:yScaleFactor swipeableView:swipeableView];
    
    return [self transformWithXScale:xScaleFactor yScale:yScaleFactor yTranslation:yTranslation];
}

- (CGAffineTransform)transformWithXScale:(CGFloat)xScaleFactor yScale:(CGFloat)yScaleFactor yTranslation:(CGFloat)verticalTranslation
{
    CGAffineTransform transform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    transform = CGAffineTransformTranslate(transform, 0, verticalTranslation);
    return transform;
}

- (CGFloat)yScaleFactorForIndex:(NSUInteger)index
{
    CGFloat scale = 0.0;
    switch (index)
    {
        case 0:
            scale = 1.0;
            break;
            
        case 1:
            scale = 0.98;
            break;
            
        case 2:
            scale = 0.96;
            break;
            
        default:
            scale = 1.0f;
            break;
    }
    
    return scale;
}

- (CGFloat)xScaleFactorForIndex:(NSUInteger)index
{
    CGFloat scale = 0.0;
    switch (index)
    {
        case 0:
            scale = 1.0;
            break;
            
        case 1:
            scale = 0.94;
            break;
            
        case 2:
            scale = 0.88;
            break;
            
        default:
            scale = 1.0f;
            break;
    }
    
    return scale;
}

- (CGFloat)verticalTranslationWithYScale:(CGFloat)yScale swipeableView:(ZLSwipeableView *)swipeableView
{
    CGFloat height = CGRectGetHeight(swipeableView.bounds);
    CGFloat translation = (height - height*yScale);
    return translation;
}

@end
