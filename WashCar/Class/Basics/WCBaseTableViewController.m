//
//  WCBaseTableViewController.m
//  WashCar
//
//  Created by nate on 15/8/20.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#import "WCBaseTableViewController.h"
#import "UIColorDef.h"
#import "UIDevice+floatVersion.h"

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"


@interface WCBaseTableViewController ()
<UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, EGORefreshTableFooterDelegate, UIScrollViewDelegate>

@end

@implementation WCBaseTableViewController

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tableFrame = self.view.bounds;
    //初始化
    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:_style];
    
    //设置cell 分割线(无)
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;
    //设置代理
    _tableView.delegate = self;
    
    //作用：决定了子视图的显示范围。具体的说，就是当取值为YES时，剪裁超出父视图范围的子视图部分；当取值为NO时，不剪裁子视图。默认值为NO。
    _tableView.clipsToBounds = NO;
    
    //自动调整自己的高度，保证与superView顶部和底部的距离不变。
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    //设置统一的列表背景
    _tableView.backgroundColor = UIColorWithRGB(0xf7, 0xf7, 0xf5);
    
    //子控件加到父视图---显示
    [self.view addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置为半透明后，iOS7以及7以下坐标会有偏差，故此处做处理
    if ([UIDevice deviceVersion] < 7.0f && !self.hideNavigationBarWhenPush) {
        _tableView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44-2);
    }
}


#pragma mark -
- (void)setTopOffset:(CGFloat)topOffset {
    if (topOffset!=_topOffset) {
        _topOffset = topOffset;
        
        UIEdgeInsets insets = _tableView.contentInset;
        insets.top = _topOffset;
        _tableView.contentInset = insets;
        
        _refreshHeaderView.topOffset = _topOffset;
    }
}

-(void)setUseHeaderRefreshView:(BOOL)useHeaderRefreshView{
    _useHeaderRefreshView = useHeaderRefreshView;
    if (useHeaderRefreshView && _refreshHeaderView==nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -_tableView.bounds.size.height, _tableView.bounds.size.width, _tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
                 _refreshHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_tableView addSubview:_refreshHeaderView];
  
        _refreshHeaderViewIsLoading = NO;
        [_refreshHeaderView refreshLastUpdatedDate];
    } else {
        [_refreshHeaderView removeFromSuperview];
        
        _refreshHeaderView = nil;
    }
}

-(void)setUseFooterRefreshView:(BOOL)useFooterRefreshView{
    _useFooterRefreshView = useFooterRefreshView;
    if (useFooterRefreshView && _refreshFooterView == nil) {
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectZero];
        _refreshFooterView.delegate = self;
        
        CGFloat height = MAX(_tableView.contentSize.height,_tableView.bounds.size.height);
        _refreshFooterView.frame = CGRectMake(0, height, _tableView.bounds.size.width, _tableView.bounds.size.height);
        
//        _refreshFooterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_tableView addSubview:_refreshFooterView];
        
        _refreshFooterViewIsLoading = NO;
    } else {
        [_refreshFooterView removeFromSuperview];
        _refreshFooterView = nil;
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    if (self.refreshFooterView) {
        [self.refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }

    if(scrollView == _tableView){
        if (self.refreshFooterView) {
            [self.refreshFooterView egoRefreshScrollViewDidEndDragging:_tableView];
        }
 
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    _refreshType = eRefreshHeader;
    _refreshHeaderViewIsLoading = YES;
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.0f];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    _refreshType = eRefreshHeader;
    return _refreshHeaderViewIsLoading;
    // should return if data source model is reloading
    
}

#pragma mark EGORefreshTableFooterDelegate Methods
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view{
    _refreshType = eRefreshFooter;
    _refreshFooterViewIsLoading = YES;
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.0f];
}
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view{
    _refreshType = eRefreshFooter;
    return _refreshFooterViewIsLoading;
}


- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

//子类要重写这个方法，处理自己的数据
-(void)refreshTable{
    switch (_refreshType) {
        case eRefreshFooter:
        {
            _refreshFooterViewIsLoading = YES;
            NSLog(@"触动加载更多机制，刷新数据啦~~~");
        }
            break;
        case eRefreshHeader:
        {
            _refreshHeaderViewIsLoading = YES;
            NSLog(@"触动下拉刷新机制，刷新数据啦~~~");
        }
            break;
            
        default:
            break;
    }

    [self performSelector:@selector(updateData:) withObject:self afterDelay:5.0f];
}

//测试用方法
-(void)updateData:(id)sender{
    
    switch (_refreshType) {
        case eRefreshFooter:
        {
            _refreshFooterViewIsLoading = NO;
            NSLog(@"新的数据到了，请更新(上提)~~~");
            [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
        }
            break;
        case eRefreshHeader:
        {
            _refreshHeaderViewIsLoading = NO;
            self.topOffset = 65;
            NSLog(@"新的数据到了，请更新(下拉)~~~");
            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
        }
            break;
            
        default:
            break;
    }
    

    
}

#pragma mark - UITableViewDelegate
#pragma 子类必须重写   一般情况下复制就好啦

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (UITableViewCell*) tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath cellIdentifier:(NSString*)identifier {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    return cell;
}

- (void)didSelectedAtObject:(id)obj{
    
}

- (void)updateTableViewCell:(UITableViewCell *)cell withObject:(id)object {
    
}


#pragma ------------
#pragma 子类尽量不要重写
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableViewDataArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *obj = [self objectAtIndexPath:indexPath];
    [self didSelectedAtObject:obj];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    id obj = nil;
    if (indexPath.row < [self.tableViewDataArray count]) {
        obj = [self.tableViewDataArray objectAtIndex:indexPath.row];
    }
    return obj;
}


#pragma -------------
#pragma 子类就不用重写了
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self tableViewCellForRowAtIndexPath:indexPath cellIdentifier:CellIdentifier];
    }
    return cell;
}

//统一设置Cell背景,子类可以重写
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = UIColorWithRGB(0xf7, 0xf7, 0xf5);
}

@end
