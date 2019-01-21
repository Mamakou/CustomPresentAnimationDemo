//
//  BDPresentAnimator.m
//  QiXiuBaoDian
//
//  Created by goviewtech on 2019/1/16.
//  Copyright © 2019 mayouming. All rights reserved.
//

#import "BDPresentAnimator.h"
#import "BDPresentAnimatorAction.h"

@interface BDPresentAnimator ()

///是否是手势左滑
@property (nonatomic,assign)BOOL isInteraction;
@property (nonatomic,strong)UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property (nonatomic,strong)BDPresentAnimatorAction *pushAniamtion;
@end

@implementation BDPresentAnimator

-(BDPresentAnimatorAction *)pushAniamtion
{
    if(!_pushAniamtion){
        _pushAniamtion = [BDPresentAnimatorAction new];
    }
    return _pushAniamtion;
}


- (void)edgePanAction:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    //CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            _isInteraction = YES;
            self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            // _isInteraction = NO;
            [self.percentDrivenTransition updateInteractiveTransition:rate];
            break;
        case UIGestureRecognizerStateEnded:
            
            if (rate >= 0.4f){
                [self.percentDrivenTransition finishInteractiveTransition];
            }else{
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            _isInteraction = NO;
            self.percentDrivenTransition = nil;
            break;
        default:
            [self.percentDrivenTransition cancelInteractiveTransition];
            _isInteraction = NO;
            self.percentDrivenTransition = nil;
            break;
    }
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if(self.isInteraction){
        self.pushAniamtion.transformType = BDTransformPush;
    }else{
        self.pushAniamtion.transformType = BDTransformPresent;
    }
    return self.pushAniamtion;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if(self.isInteraction){
        self.pushAniamtion.transformType = BDTransformPop;
    }else{
        self.pushAniamtion.transformType = BDTransformDismiss;
    }
    return self.pushAniamtion;
}

//返回手势需要实现
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if ([animator isKindOfClass:[BDPresentAnimatorAction class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    if ([animator isKindOfClass:[BDPresentAnimatorAction class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}


@end


@interface BDPresentAnimatorManager ()

@property (nonatomic,strong)NSMutableDictionary *animatorDict;

@end

@implementation BDPresentAnimatorManager

-(NSMutableDictionary *)animatorDict
{
    if(!_animatorDict){
        _animatorDict = [NSMutableDictionary dictionary];
    }
    return _animatorDict;
}



+ (instancetype)manager
{
    static BDPresentAnimatorManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BDPresentAnimatorManager alloc]init];
    });
    return manager;
}

- (void)addAnimaor:(BDPresentAnimator*)animator withKey:(NSString*)key
{
    [self.animatorDict setObject:animator forKey:key];
}

- (void)removeAnimatorWithKey:(NSString*)key
{
    if(self.animatorDict.count == 0)return;
    if(key == nil || key.length == 0)return;
    [self.animatorDict removeObjectForKey:key];
}

- (void)removeAnimatorWithController:(UIViewController*)controller
{
    if(controller == nil)return;
    NSString *className = NSStringFromClass(controller.class);
    //这样的key值才能更加严谨，保证唯一性
    NSString *sourceKey = [NSString stringWithFormat:@"%@_%p",className,controller];
    [self removeAnimatorWithKey:sourceKey];
}

@end
