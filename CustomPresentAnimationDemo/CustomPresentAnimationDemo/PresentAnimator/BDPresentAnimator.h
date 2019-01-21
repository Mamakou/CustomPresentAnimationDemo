//
//  BDPresentAnimator.h
//  QiXiuBaoDian
//
//  Created by goviewtech on 2019/1/16.
//  Copyright © 2019 mayouming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 每个present的操作对应的代理都是一对一的，所以只能针对单个对象
 */
@interface BDPresentAnimator : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic,weak)UIViewController *controller;

@end

NS_ASSUME_NONNULL_END

/**
 专门管理复杂保存与删除代理，动画保持的效果必须在BDPresentAnimator生命周期内
 */
@interface BDPresentAnimatorManager : NSObject

+ (instancetype)manager;

- (void)addAnimaor:(BDPresentAnimator*)animator withKey:(NSString*)key;

- (void)removeAnimatorWithKey:(NSString*)key;

- (void)removeAnimatorWithController:(UIViewController*)controller;

@end





