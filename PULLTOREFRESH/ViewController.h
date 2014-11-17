//
//  ViewController.h
//  PULLTOREFRESH
//
//  Created by Sebastian Andersen on 16/11/14.
//  Copyright (c) 2014 SebastianA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

