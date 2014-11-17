//
//  ViewController.m
//  PULLTOREFRESH
//
//  Created by Sebastian Andersen on 16/11/14.
//  Copyright (c) 2014 SebastianA. All rights reserved.
//

#import "ViewController.h"

#import "SSARefreshControl.h"

@interface ViewController () <SSARefreshControlDelegate>

@property (nonatomic, strong) SSARefreshControl *refreshControl;

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.refreshControl beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[SSARefreshControl alloc] initWithScrollView:self.tableView andRefreshViewLayerType:SSARefreshViewLayerTypeOnScrollView];
    self.refreshControl.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}



#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %li", (long)indexPath.row];
    return cell;
}

- (void)beganRefreshing {
   
    [self loadDataSource];
  
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
  
        sleep(1.5);
        dispatch_async(dispatch_get_main_queue(), ^{
  
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
        });
    
    });
}

#pragma mark - Properties

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect tableViewFrame = self.navigationController.view.bounds;
        tableViewFrame.origin.y = tableViewFrame.origin.y + 70;
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)dealloc {
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
}


@end
