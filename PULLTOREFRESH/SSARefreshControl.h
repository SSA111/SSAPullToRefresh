//
//  SSARefreshControl.h
//
//  Created by Sebastian Andersen on 11 / 8 - 2014
//  Copyright (C) 2014 Sebastian Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SSACircleView.h"

typedef NS_ENUM(NSInteger, SSARefreshViewLayerType) {
    SSARefreshViewLayerTypeOnSuperView = 0,
    SSARefreshViewLayerTypeOnScrollView = 1,
};


@protocol SSARefreshControlDelegate <NSObject>

@required

- (void)beganRefreshing;

@end

@interface SSARefreshControl : NSObject

@property (nonatomic, assign) UIColor *circleViewTintColor;

@property (nonatomic, weak) id <SSARefreshControlDelegate> delegate;

- (id)initWithScrollView:(UIScrollView *)scrollView andRefreshViewLayerType:(SSARefreshViewLayerType)refreshViewLayerType;

- (void)beginRefreshing;

- (void)endRefreshing;

@end

@interface SSARefreshCircleContainerView : UIView

@property (nonatomic, strong) SSACircleView *circleView;

@end

