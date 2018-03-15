//
//  CHRootViewController.m
//  CHTableView
//
//  Created by PFZC on 2018/3/8.
//  Copyright © 2018年 PFZC. All rights reserved.
//

#import "CHRootViewController.h"
#import "UIImage+CH.h"
@interface CHRootViewController ()<UITableViewDelegate ,UITableViewDataSource>{
    UIImageView *imageView;
    UIView *bgView;
    UIImageView *headImage;
}
@property (nonatomic ,strong) UITableView *tableView;
@end
@implementation CHRootViewController
//头视图高度
#define tableHeadViewHeight 320.f
//视图将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //导航栏隐藏下划线
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
    //导航栏图片透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    //tableview不自动调整
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    #define EMiOS_11_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setHeadView];
    [self.view addSubview:self.tableView];
    
    //调整图层,把bgView放到最表面
    [self.view bringSubviewToFront:bgView];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //改变头像的位置
    headImage.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 80)*0.5,-scrollView.contentOffset.y, 80, 80);
//    NSLog(@"%f",scrollView.contentOffset.y);
    
    //320是头视图高度，在头视图只有64的时候把头视图图片换成图片最底部,如果是iphoneX，那么64改为88,xiaxiaxia也得换成一个高度88的图片，与底部重合，这里我没写
    if (scrollView.contentOffset.y>=tableHeadViewHeight-64) {
         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"xiaxiaxia.jpg"] forBarMetrics:UIBarMetricsDefault];
    }else{
         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    }
    //往下拉图片变大
    if (scrollView.contentOffset.y <= 0) {
    CGRect f1 = self.tableView.tableHeaderView.frame;
    f1.origin.y += scrollView.contentOffset.y;
    f1.size.height -= scrollView.contentOffset.y + self.tableView.contentOffset.y;
    imageView.frame = f1;
    }
}
-(void)setHeadView{
    //tableview头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, tableHeadViewHeight)];
    
    //背景图片
    imageView = [[UIImageView alloc] init];
    imageView.frame = headView.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"xiubi.jpg"];
    [headView addSubview:imageView];
    
    //承载头像的，注意这个bgView是添加到self.view上，透明的，目的是为了切割头像超出的部分不显示
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, headView.frame.size.width, tableHeadViewHeight -64)];
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    //圆形头像
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80)*0.5, 0, 80, 80)];
    headImage.image = [UIImage imageNamed:@"xiubi.jpg"];
    headImage.layer.cornerRadius = 40;
    headImage.clipsToBounds = YES;
    [bgView addSubview:headImage];
    
    self.tableView.tableHeaderView = headView;
}

@end
