//
//  Animator.m
//
//
//  Created by Sebastian Andersen on 1/31/14.
//  Copyright (c) 2014 Sebastian Andersen All rights reserved.
//

#import "SSAPullToRefreshAnimator.h"

static const NSUInteger KeyframeCount = 60;

@implementation SSAPullToRefreshAnimator

+ (CABasicAnimation*)repeatRotateAnimation {
    
    
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = 0;
    animation.toValue = [NSNumber numberWithFloat:M_PI*2];
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    
    return animation;
    
}

+ (CAKeyframeAnimation *)popAnimation {
    
    CATransform3D fromMatrix = CATransform3DMakeScale(0.0, 0.0, 0.0);
    CATransform3D toMatrix = CATransform3DMakeScale(1.0f, 1.0f, 1.0f);
    CAKeyframeAnimation *animation = [SSAPullToRefreshAnimator animationWithCATransform3DForKeyPath:@"transform"
                                                                                     easingFunction:SSAElasticEaseOut
                                                                                         fromMatrix:fromMatrix
                                                                                           toMatrix:toMatrix];
    animation.duration = 1.0f;
    animation.removedOnCompletion = NO;
    
    return animation;
    
}

+(CAKeyframeAnimation *)animationWithCATransform3DForKeyPath:(NSString *)keyPath
                                                easingFunction:(ViewEasingFunctionPointerType)function
                                                    fromMatrix:(CATransform3D)fromMatrix
                                                      toMatrix:(CATransform3D)toMatrix {
  
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:KeyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (KeyframeCount - 1);
  
	for(size_t frame = 0; frame < KeyframeCount; ++frame, t += dt) {
    
    CATransform3D value;
    
    value.m11 = fromMatrix.m11 + function(t) * (toMatrix.m11 - fromMatrix.m11);
    value.m12 = fromMatrix.m12 + function(t) * (toMatrix.m12 - fromMatrix.m12);
    value.m13 = fromMatrix.m13 + function(t) * (toMatrix.m13 - fromMatrix.m13);
    value.m14 = fromMatrix.m14 + function(t) * (toMatrix.m14 - fromMatrix.m14);
    
    value.m21 = fromMatrix.m21 + function(t) * (toMatrix.m21 - fromMatrix.m21);
    value.m22 = fromMatrix.m22 + function(t) * (toMatrix.m22 - fromMatrix.m22);
    value.m23 = fromMatrix.m23 + function(t) * (toMatrix.m23 - fromMatrix.m23);
    value.m24 = fromMatrix.m24 + function(t) * (toMatrix.m24 - fromMatrix.m24);
    
    value.m31 = fromMatrix.m31 + function(t) * (toMatrix.m31 - fromMatrix.m31);
    value.m32 = fromMatrix.m32 + function(t) * (toMatrix.m32 - fromMatrix.m32);
    value.m33 = fromMatrix.m33 + function(t) * (toMatrix.m33 - fromMatrix.m33);
    value.m34 = fromMatrix.m34 + function(t) * (toMatrix.m34 - fromMatrix.m34);
    
    value.m41 = fromMatrix.m41 + function(t) * (toMatrix.m41 - fromMatrix.m41);
    value.m42 = fromMatrix.m42 + function(t) * (toMatrix.m42 - fromMatrix.m42);
    value.m43 = fromMatrix.m43 + function(t) * (toMatrix.m43 - fromMatrix.m43);
    value.m44 = fromMatrix.m44 + function(t) * (toMatrix.m44 - fromMatrix.m44);
    
		[values addObject:[NSValue valueWithCATransform3D:value]];
    
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
	[animation setValues:values];
  
	return animation;
  
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
CGFloat SSAElasticEaseOut(CGFloat p)
{
	return sin(-13 * M_PI_2 * (p + 1)) * pow(2, -10 * p) + 1;
}



@end
