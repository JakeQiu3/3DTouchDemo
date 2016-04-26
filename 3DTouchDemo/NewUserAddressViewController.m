//
//  NewUserAddressViewController.m
//  VinuxPost
//
//  Created by 邱少依 on 16/4/26.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "NewUserAddressViewController.h"
#import "SeaOverSaleCountyViewController.h"

//保存用户地址
#define saveUserList @"receive/address.vhtml"
#define KMargin 10
#define KNameAndPhoneH 45
#define KLeftLabelWidth 80
#define KLableFont 15

@interface NewUserAddressViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{

    UIView *telephoneBackView;
    
    UIPickerView *addressPickerView;
    NSArray *provinceArray;
    NSArray *cityArray;
    NSArray *countyArray;
    
    
    UIView *pickViewBackView;
    
}
@end

@implementation NewUserAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserAddressKeyBoardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserAddressKeyBoardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

//显示键盘的方法
- (void)UserAddressKeyBoardShowNotification:(NSNotification *)notification {
    
}

//隐藏键盘的方法
- (void)UserAddressKeyBoardHideNotification:(NSNotification *)notification {
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultColor;
    [self setNavgationBar];
    [self addData];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)addData {
    
   
}

- (void)setNavgationBar {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = 1;
    titleLabel.text = @"添加收货地址";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.backBarButtonItem = nil;
    
    // 设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigation_back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigation_back.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 30, 30);
    backButton.showsTouchWhenHighlighted = 1;
    [backButton addTarget:self action:@selector(backview) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backview {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUI {
    [self setNameItemView];
    [self setAddressItemView];
    [self setTelephoneItemView];
    [self addFooterView];

}

- (void)setNameItemView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, KMargin, SCREENWIDTH, KNameAndPhoneH)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KMargin, 0, KLeftLabelWidth, KNameAndPhoneH)];
    nameLabel.text = @"收货人 :";
    nameLabel.font = [UIFont systemFontOfSize:KLableFont];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:nameLabel];
    
    UITextField *nameField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.right,0,SCREENWIDTH-KNameAndPhoneH-KMargin,KNameAndPhoneH)];
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.tag = 100;
    nameField.delegate = self;
    nameField.placeholder = @"请输入收货人姓名";
    nameField.keyboardType = UIKeyboardTypeDefault;
    nameField.returnKeyType = UIReturnKeyNext;
//    : UIReturnKeyDone;
    [backView addSubview:nameField];

}

- (void)setAddressItemView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 2*KMargin+KNameAndPhoneH, SCREENWIDTH, KNameAndPhoneH*2)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel  *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KMargin,0, KLeftLabelWidth+20, KNameAndPhoneH)];
    addressLabel.text = @"选择所在地区";
    addressLabel.font = [UIFont systemFontOfSize:KLableFont];
    addressLabel.numberOfLines = 0;
    addressLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:addressLabel];
//    选择省市区的View
    UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(addressLabel.right+KMargin, 0, SCREENWIDTH-addressLabel.right-KMargin, KNameAndPhoneH)];
//    chooseView.backgroundColor = [UIColor redColor];
    [backView addSubview:chooseView];
    

    UIButton *indertorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    indertorBtn.frame = CGRectMake(0, 0, chooseView.width, chooseView.height);
//    indertorBtn.backgroundColor = [UIColor redColor];
    [indertorBtn addTarget:self action:@selector(pushNewPageView:) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:indertorBtn];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(indertorBtn.right-32-10, 5, 32, 32)];
    imageV.image = [UIImage imageNamed:@"箭头图片"];
    [indertorBtn addSubview:imageV];
    
//   手写详细地址
    UILabel  *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(KMargin,addressLabel.bottom, KLeftLabelWidth, KNameAndPhoneH)];
    detailLabel.text = @"详细地址 :";
    detailLabel.font = [UIFont systemFontOfSize:KLableFont];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:detailLabel];
    
    UITextField *nameField = [[UITextField alloc]initWithFrame:CGRectMake(addressLabel.right,addressLabel.bottom,SCREENWIDTH-KNameAndPhoneH-KMargin,KNameAndPhoneH)];
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.tag = 101;
    nameField.delegate = self;
    nameField.placeholder = @"请输入街道小区楼层等详细地址";
    nameField.keyboardType = UIKeyboardTypeDefault;
    nameField.returnKeyType = UIReturnKeyNext;
    //    : UIReturnKeyDone;
    [backView addSubview:nameField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [pickViewBackView removeFromSuperview];
}

//跳转到新的界面
- (void)pushNewPageView:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    if (btn.selected) {
        pickViewBackView = [[UIView alloc]init];
        pickViewBackView.frame = CGRectMake(0, SCREENHEIGHT-64-150, SCREENWIDTH, 150);
        pickViewBackView.backgroundColor = [UIColor redColor];
        [self.view addSubview:pickViewBackView];
        
        
        addressPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,30, SCREENWIDTH, 90)];
        addressPickerView.backgroundColor = [UIColor greenColor];
        addressPickerView.delegate = self;
        addressPickerView.dataSource = self;
        [pickViewBackView addSubview:addressPickerView];

    } else {
        [pickViewBackView removeFromSuperview];
    }
    
}
#pragma  mark pickView 的代理方法
#pragma mark dataSouce
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0){
      return
        3;//provinceArray.count;
    }
    else if (component ==1 ) {
        return 3;//[[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] count];
    } else return 3;
//       [[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] count];
//    
}
#pragma mark delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {return @"wole";
//        [[self.citys objectAtIndex:row] objectForKey:@"State"];
    }
    else  return @"wole";
//        [[[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:row] objectForKey:@"city"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0){
//        self.rowInProvince = row;
//        [self.pickerView reloadComponent:1];
    }
}


- (void)setTelephoneItemView {
    
    telephoneBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 3*KMargin+3*KNameAndPhoneH, SCREENWIDTH, KNameAndPhoneH)];
    telephoneBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:telephoneBackView];
    
    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KMargin,0, KLeftLabelWidth, KNameAndPhoneH)];
    nameLabel.text = @"联系电话 :";
    nameLabel.font = [UIFont systemFontOfSize:KLableFont];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [telephoneBackView addSubview:nameLabel];
    
    UITextField *nameField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.right,0,SCREENWIDTH-KNameAndPhoneH-KMargin,KNameAndPhoneH)];
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.tag = 102;
    nameField.delegate = self;
    nameField.placeholder = @"请输入收货人手机号";
    nameField.keyboardType = UIKeyboardTypeDefault;
    nameField.returnKeyType = UIReturnKeyDone;
    [telephoneBackView addSubview:nameField];
}
/*
 * 设置脚部视图
 */
- (void)addFooterView {
   
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(20,telephoneBackView.bottom+30, SCREENWIDTH - 40, 45);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor redColor];;
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


//保存收货地址
- (void)saveBtn {
//        _historyArray = @[].mutableCopy;
//        _statusCellsArray = @[].mutableCopy;
//        
//        if (_historyArray.count>0) {
//            [_historyArray removeAllObjects];
//        }
//    
//        // 过滤参数
//        NSString *userInfoStr = (NSString *)[[ZHDiskCache sharedCache] objectForKey:kUserInfoKey];
//        NSDictionary *userInfo = [userInfoStr objectFromJSONString];
//        NSMutableDictionary *params = @{}.mutableCopy;
//        
//        if (![userInfo objectForKey:@"userId"]) {
//            return;
//        }
//    // 姓名
//    if (userInfoView.userName.length == 0) {
//        [self showAlertView:@"请输入姓名" title:@"提示" otherBtnTitle:nil alertDelegate:nil];
//        return;
//    } else {
//        [params setObject:[userInfoView.userName URLEncodedString] forKey:@"userName"];
//    }
//
//      [self showHUD:@"正在保存收货地址" isDim:YES];
//
//
//   
//    
//    
//        [params setObject:[userInfo objectForKey:@"userId"] forKey:@"userId"];
//        [params setObject:@"insert" forKey:@"method"];
//        [params setObject:@"cart" forKey:@"source"];
//    [params setObject:@" " forKey:@"receName"];
//    [params setObject:@" " forKey:@"province"];
//    [params setObject:@" " forKey:@"city"];
//    [params setObject:@" " forKey:@"county"];
//    [params setObject:@" " forKey:@"address"];
//    [params setObject:@" " forKey:@"telephone"];
//    
//       [params setObject:@"true" forKey:@"isDefault"];//是否是默认 true  false
//
    
//        __weak __typeof(self)weakSelf = self;
//        //    NSLog(@"params用户和社区的id：%@",params);
//        [[SVHTTPClient sharedClient]POST:[NSString stringWithFormat:@"%@%@",KSeaUserAddressUrl,userGetList] parameters:params completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
//            __strong __typeof(weakSelf)strongSelf = weakSelf;
//            [strongSelf hideHUD];
//            if (!response) {
//                [SVProgressHUD showErrorWithStatus:@"获取收货地址出错"];
//            } else {
//                NSDictionary *result = [UIUtils getResultFromResponseData:response];
//                //NSLog(@"邮局信息：%@",result);
//                if (!ResultCode(result, @"status",@"200")) {
//                    [SVProgressHUD showErrorWithStatus:ResultMsg(result, @"message")];
//                } else {
//                    if ([[result objectForKey:@"result"]isKindOfClass:[NSNull class]]) {//结果数据为空
//                        [SVProgressHUD showErrorWithStatus:ResultMsg(result, @"message")];
//                        return;
//                    } else {
//                        NSArray *resultArray  = [result objectForKey:@"result"];
//                        
//                        [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                            
//                            SeaOverSaleAddressModel *model = [[SeaOverSaleAddressModel alloc] initWithDataDic:obj];
//                            [_historyArray addObject:model];
//                            
//                            //       把cell放进数组中。
//                            SeaOverAddressCell *statusCell = [[SeaOverAddressCell alloc] init];
//                            [_statusCellsArray addObject:statusCell];
//                            
//                        }];
//                        
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [_tableView reloadData];
//                        });
//                        
//                    }
//                }
//            }
//        }];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
