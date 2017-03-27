//
//  MainViewController.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewController+Manager.h"
#import "UICellEntity.h"
#import "TestViewController.h"


#define kContentOffset @"contentOffset"

@interface MainViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
{
}
@end

@implementation MainViewController

-(void) dealloc {
    
    [_tableView removeObserver:self forKeyPath:kContentOffset context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype) init{
    
    self = [super init];
    if (self) {
        
        _oldY = 0;
        _tableDataArr = [[NSMutableArray alloc] init];
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}



-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];

     #ifdef kIousChannelsTest
     //停止加速仪更新（很重要！）
     [self.motionManager stopAccelerometerUpdates];// heweihua test
     #endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
    
    [self addNavigationBar:@"First page"];
    [self removeNavigationItemLeft];
    
    // init table
    [self initTableView];

    // 购物车|订单
    CGFloat pointX = kMainScreenW - kIousFloatinglayerW - 5.5f;
    CGFloat pointY = kMainScreenH - kIousFloatinglayerH - 75.f;
    CGRect rect = CGRectMake(pointX, pointY, kIousFloatinglayerW, kIousFloatinglayerH);
    _floatlayer = [[IousFloatinglayer alloc] initWithFrame:rect];
    [_floatlayer setDelegate:self];
    [self.view addSubview:_floatlayer];
    _floatlayer.hidden = YES;// default hidden
    _floatlayer.alpha = 1;// 初始化显示
    
    [self requestData];
    
     #ifdef kIousChannelsTest
     self.motionManager = [[CMMotionManager alloc] init];//一般在viewDidLoad中进行
     self.motionManager.accelerometerUpdateInterval = .1;//加速仪更新频率，以秒为单位
     
     //viewDidAppear中加入
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(receiveNotification:)
     name:UIApplicationDidEnterBackgroundNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(receiveNotification:)
     name:UIApplicationWillEnterForegroundNotification object:nil];
     //viewDidDisappear中取消监听
     [[NSNotificationCenter defaultCenter] removeObserver:self
     name:UIApplicationDidEnterBackgroundNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self
     name:UIApplicationWillEnterForegroundNotification object:nil];
     #endif
}



-(void)tableToTop{
    
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 进入前台
-(void) appWillEnterForeground{
    
    // 后台进前台，有数据的时候不需要请求
    if([_tableDataArr count]>0)
        return;
    [self requestData];
}




// init UITableView
-(void) initTableView{
    
    // table _naviBarView
    CGRect rect = CGRectMake(0, 0, kMainScreenW, kMainScreenH);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
    
    [self.view addSubview:_tableView];
    [_tableView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionInitial context:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

// header
/*
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    UISectionEntity* sectionEntity = _tableDataArr[section];
    if (sectionEntity.hEntity) {
        return sectionEntity.hEntity.height;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UISectionEntity* sectionEntity = _tableDataArr[section];
    if (sectionEntity.hEntity.show == NO) {
        return nil;
    }
    static NSString *headerId = @"UITableHeaderView";
    UITableHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headView) {
        headView = [[UITableHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    [headView reloadData:sectionEntity.hEntity];
    
    return headView;
}
*/


// footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    static NSString *footerId = @"UITableViewHeaderFooterView";
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerId];
    if (!footer) {
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerId];
        footer.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
    }
    return footer;
}



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_tableDataArr count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    UISectionEntity * headerEntity = _tableDataArr[section];
    return [headerEntity.list count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UISectionEntity* section = _tableDataArr[indexPath.section];
    UICellEntity* entity = section.list[indexPath.row];
    return entity.height;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self jr_TableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark - Table view delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}






- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (![keyPath isEqualToString:kContentOffset] || ![object isKindOfClass:[UITableView class]]) return;
    CGFloat newY = _tableView.contentOffset.y;
    
    if (newY < _oldY || newY == 0) {
        // 看上边内容， 显示
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            if(_floatlayer){
                
                _floatlayer.alpha = 1;
            }
        }completion:^(BOOL finished){
        }];
    } else if (newY > _oldY) {
        
        // 看下边内容， 隐藏
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            if(_floatlayer){
                // 往下移动120px隐藏
                if (newY >= 120) {
                    _floatlayer.alpha = 0;
                }
            }
        }
        completion:^(BOOL finished){
        }];
    }
    _oldY = newY;
    
}


// --------------------------- heweihua test ---------------------------

#ifdef kIousChannelsTest
//ViewController 加入以下两方法
-(BOOL)canBecomeFirstResponder{

     //让当前controller可以成为firstResponder，这很重要
     return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
     if (event.subtype==UIEventSubtypeMotionShake) {
     
         //做你想做的事
         [self pushController];
     }
}


-(void) pushController {

     TestViewController *vc = [[TestViewController alloc] init];
     [self.navigationController pushViewController:vc animated:YES];
}



-(void)startAccelerometer{
    
     //以push的方式更新并在block中接收加速度
     [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
     withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
         [self outputAccelertionData:accelerometerData.acceleration];
         if (error) {
             NSLog(@"motion error:%@",error);
         }
     }];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration{
    
     //综合3个方向的加速度
     double accelerameter = sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 )
         + pow( acceleration.z , 2) );
         //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
     if (accelerameter>2.3f) {
         //立即停止更新加速仪（很重要！）
         [self.motionManager stopAccelerometerUpdates];
         dispatch_async(dispatch_get_main_queue(), ^{
         //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
         });
     }
}
 
//对应上面的通知中心回调的消息接收
-(void)receiveNotification:(NSNotification *)notification{
    
    if ([notification.name
    isEqualToString:UIApplicationDidEnterBackgroundNotification]){

        [self.motionManager stopAccelerometerUpdates];
    }else{
        [self startAccelerometer];
    }
}
#endif
 
// --------------------------- heweihua test ---------------------------



#pragma mark - IousFloatinglayerDelegate

// index: 1:订单 2：购物车
-(void) didClickIousFloatinglayer:(NSInteger)index {
    
    if (1 == index) {
        
        // 开普勒订单列表
    }
    else if (2 == index){
        
        // 开普勒购物车
    }
}



@end
