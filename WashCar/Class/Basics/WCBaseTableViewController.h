//
//  WCBaseTableViewController.h
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseViewController.h"

typedef enum{
    
    eRefreshHeader = 0,
    eRefreshFooter =1
    
} EnumRefreshPos;

@class EGORefreshTableHeaderView;
@class EGORefreshTableFooterView;

@interface WCBaseTableViewController : WCBaseViewController
{
    UITableView* _tableView;
    NSArray*  _tableViewDataArray;
    
    EGORefreshTableHeaderView* _refreshHeaderView;
    EGORefreshTableFooterView* _refreshFooterView;
    
    BOOL _refreshHeaderViewIsLoading;
    BOOL _refreshFooterViewIsLoading;
    
}

@property (nonatomic, assign)EnumRefreshPos refreshType;

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)NSArray*  tableViewDataArray;
@property (nonatomic, assign)UITableViewStyle  style;

//注意：tableView 追加 refreshHeaderView 时，要调整tableView 的frame
@property(nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;

//注意：tableView 追加 refreshFooterView 时，
//要调整tableView 的frame为：
/*
CGRect tableViewframe = _tableView.frame;
tableViewframe.size.height -= 65;
_tableView.frame = tableViewframe;
*/
@property(nonatomic, retain) EGORefreshTableFooterView *refreshFooterView;

#pragma mark - 上面加入条（扩展）
@property(nonatomic,assign) CGFloat topOffset;

//使用下拉刷新，默认为NO
@property(nonatomic,assign) BOOL useHeaderRefreshView;
//使用上提刷新，默认为NO
@property(nonatomic,assign) BOOL useFooterRefreshView;


@end
