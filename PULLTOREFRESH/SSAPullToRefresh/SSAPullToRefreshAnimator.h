//
//  Animator.h
//  
//
//  Created by Sebastian Andersen on 1/31/14.
//  Copyright (c) 2014 Sebastian  Andersen All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef CGFloat (*ViewEasingFunctionPointerType)(CGFloat);

@interface SSAPullToRefreshAnimator : NSObject

+ (CABasicAnimation *)repeatRotateAnimation;

+ (CAKeyframeAnimation *)popAnimation;

+(CAKeyframeAnimation *) animationWithCATransform3DForKeyPath:(NSString *)keyPath
                                               easingFunction:(ViewEasingFunctionPointerType)function
                                                   fromMatrix:(CATransform3D)fromMatrix
                                                     toMatrix:(CATransform3D)toMatrix;

@end

CGFloat SSAElasticEaseIn(CGFloat p);


