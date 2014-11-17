//
//  SSACircleView.m
//
//  Created by Sebastian Andersen on 11 / 8 - 2014
//  Copyright (C) 2014 Sebastian Andersen. All rights reserved.
//

#import "SSACircleView.h"


@implementation SSACircleView

- (void)setOffsetY:(CGFloat)offsetY {
    _offsetY = offsetY;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _heightBeginToRefresh = kSSARefreshCircleViewHeight;
        _offsetY = 0;
 
        CALayer *maskLayer = [CALayer layer];
        maskLayer.contents = (id)[[UIImage imageNamed:@"Ressources.bundle/angle-mask@2x.png"] CGImage];
        maskLayer.frame = self.bounds;
        self.layer.mask = maskLayer;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 2.f);
    
    CGFloat radius = 12;

    static CGFloat startAngle = 3 * M_PI / 2.0;
    CGFloat endAngle = (ABS(_offsetY) / _heightBeginToRefresh) * (M_PI * 19 / 10) + startAngle;
    CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);

    CGContextDrawPath(context, kCGPathStroke);
}

@end
