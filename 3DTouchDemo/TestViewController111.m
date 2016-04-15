//
//  ViewController.m
//  动画大全
//
//  Created by 邱少依 on 16/1/5.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "TestViewController111.h"
#import "Test3DTouchViewController.h"
@interface TestViewController111 ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;//文件夹数组
    NSArray *_classArray;//类名数组
    
}

@end

@implementation TestViewController111

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    [self check3DTouch];
    // Do any additional setup after loading the view.
}
-(void)check3DTouch
{
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        //ok
    }
    else{
        //notok
    }
}

- (void)initData {
    _dataArray = [[NSArray alloc] initWithObjects:@"first",@"second",@"third", nil];
    _classArray = [[NSArray alloc] initWithObjects:@"Test111_FirstViewController",@"Test111_SecondViewController",@"Test111_ThirdViewController", nil];
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    NSLog(@"少：self.view —> %@ \n tableview —> %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(_tableView.frame));
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0 || indexPath.row == 1) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li : %@",(long)indexPath.row,_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls;
    cls = NSClassFromString(_classArray[indexPath.row]);
    UIViewController *viewC = [[cls alloc] init];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtnItem;
    viewC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    NSArray *arr = @[@"1",@"2",@"3"];
    NSArray *colorArr = @[[UIColor redColor],[UIColor greenColor],[UIColor blackColor]];
    
    Test3DTouchViewController *childVC = [[Test3DTouchViewController alloc] initWithTitle:arr[indexPath.row] bgColor:colorArr[indexPath.row]];
    childVC.preferredContentSize = CGSizeMake(0.0f,600.f);
    return childVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
//    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    [self.navigationController showViewController:viewControllerToCommit sender:self];
}

@end
