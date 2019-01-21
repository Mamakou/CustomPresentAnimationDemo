//
//  BDPushAnimation.h
//  QiXiuBaoDian
//
//  Created by goviewtech on 2019/1/15.
//  Copyright © 2019 mayouming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BDTransformType){
    /*push动画*/
    BDTransformPush,
    /**pop动画*/
    BDTransformPop,
    /**present model动画*/
    BDTransformPresent,
    /**present dismiss动画*/
    BDTransformDismiss,
};


NS_ASSUME_NONNULL_BEGIN

/**
 针对模块化设计方案
 这个暂时只针对present类型的，因为将这些操作可以只在被present内部处理，而无需在每次都在外部处理，这样方面
 代码设计本应如此
 */
@interface BDPresentAnimatorAction : NSObject<UIViewControllerAnimatedTransitioning>

/**
 动画样式
 */
@property (nonatomic,assign)BDTransformType transformType;

@end

NS_ASSUME_NONNULL_END
