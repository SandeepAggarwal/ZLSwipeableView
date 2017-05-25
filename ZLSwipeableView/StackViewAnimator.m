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
        [self animateCardToFront:view];
    }
    else
    {
        CGFloat scale = [self scaleFactorForIndex:index];
        CGFloat yTranslation = [self verticalTranslationWithScale:scale swipeableView:swipeableView];
        [self animateCardToBack:view scale:scale yTranslation:yTranslation];
    }
}

#pragma mark - Private Methods

- (void)adjustOpacityOfView:(UIView*)view forIndex:(NSUInteger)index
{
    CGFloat alpha = 1.0 - (index)*0.2;
    [view setAlpha:alpha];
}

- (CGFloat)scaleFactorForIndex:(NSUInteger)index
{
    CGFloat scale = 1 - (index)*0.04;
    return scale;
}

- (CGFloat)verticalTranslationWithScale:(CGFloat)scale swipeableView:(ZLSwipeableView *)swipeableView
{
    CGFloat height = CGRectGetHeight(swipeableView.bounds);
    CGFloat translation = (height - height*scale);
    return translation;
}

- (void)animateCardToBack:(UIView*)cardView scale:(CGFloat)scaleFactor yTranslation:(CGFloat)verticalTranslation
{
    CGAffineTransform transform = CGAffineTransformMakeScale(0.95*scaleFactor, scaleFactor);
    transform = CGAffineTransformTranslate(transform, 0, verticalTranslation);
    
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionAllowUserInteraction) animations:^
     {
         cardView.transform = transform;
     } completion:nil];
}

- (void)animateCardToFront:(UIView*)cardView
{
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionAllowUserInteraction) animations:^
     {
         cardView.transform = CGAffineTransformIdentity;
         
     } completion:nil];
}


@end
