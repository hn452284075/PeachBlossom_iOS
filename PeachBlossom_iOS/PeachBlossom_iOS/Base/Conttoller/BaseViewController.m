//
//  BaseViewController.m
//  Huiyun_iOS
//
//  Created by 曾勇兵 on 2020/7/2.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "BaseViewController.h"
#import "ZZBaseNavController.h"
#import "AppDelegate.h"
#import "PlaceholderView.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "CNotificationManager.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "AlertViewManager.h"
const CGFloat defaulDelayGoBackSeconds = 1.2;
@interface BaseViewController ()<PlaceholderViewDelegate>

@property (nonatomic,strong)PlaceholderView *placeholderView;
@property (nonatomic,strong)UIView*loadingBgView;
@property (nonatomic,strong)UIPanGestureRecognizer *panGesture;
@property (nonatomic,strong)AlertViewManager *alertManager;

@end

@implementation BaseViewController

- (void)dealloc
{
    
    NSLog(@"Debug Delloced VC %@",NSStringFromClass([self class]));
    NSLog(@"Debug Delloced VC %s", __func__);
}

//检查是否有网
- (void)_checkNetWork:(ReloadDataBlock)reloadBlock{
    
    self.reloadDataBlock = reloadBlock;
    
    WEAK_SELF
    [AFNHttpRequestOPManager checkNetWorkStatusBackBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status ==AFNetworkReachabilityStatusNotReachable) {
            weak_self.placeholderView = [[PlaceholderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - weak_self. placeholderViewHeight) type:PlaceholderViewTypeNoNetwork delegate:weak_self];
            weak_self.placeholderView.tag =1000;
            [weak_self.view addSubview:weak_self.placeholderView];
            reloadBlock(NO);
            return;
        }else{
            PlaceholderView* subView = [weak_self.view viewWithTag:1000];
            [subView removeFromSuperview];
            reloadBlock(YES);
            
        }
        
    }];
    
    
}

#pragma mark - Delegate - 占位图
//* 占位图的重新加载按钮点击时回调
- (void)placeholderView:(PlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
    switch (placeholderView.type) {
        case PlaceholderViewTypeNoNetwork:       //没网
        {
            
            WEAK_SELF
            //点击重新加载 在检查是否有网络
            [AFNHttpRequestOPManager checkNetWorkStatusBackBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status !=AFNetworkReachabilityStatusNotReachable) {
                    PlaceholderView* subView = [weak_self.view viewWithTag:1000];
                    [subView removeFromSuperview];
                    
                    weak_self.reloadDataBlock(YES);
                }else{
                    
                    [CNotificationManager showMessage:[NSString stringWithFormat:@"网络连接已断开，请检查您的网络！"] withOptions:@{CN_TEXT_COLOR_KEY:[UIColor whiteColor],CN_BACKGROUND_COLOR_KEY:UIColorFromRGB(0x525B63)}];
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)navigatePushViewController:(UIViewController *)viewController
                           animate:(BOOL)animate
{
    
    NSAssert(self.navigationController.viewControllers.count >= 1, @"该控制器还未被加入导航控制器中");
    
    [self.navigationController pushViewController:viewController animated:animate];
}



- (void)setIsPushPage:(BOOL)isPushPage{
    _isPushPage = isPushPage;
    if (isPushPage) {
        id target = self.navigationController.interactivePopGestureRecognizer.delegate;
        
        // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
        _panGesture  = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
        _panGesture.delegate = self; // 设置手势代理，拦截手势触发
        [self.view addGestureRecognizer:_panGesture];
        
        // 一定要禁止系统自带的滑动手势
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    //    if(self.navigationController.childViewControllers.count == 1)
    //    {
    //        return NO;
    //    }
    
    CGPoint translatedPoint = [_panGesture translationInView:self.view];
    
    if(translatedPoint.x<0||self.navigationController.childViewControllers.count == 1){
        
        return NO;
    }
    
    
    
    return YES;
}



- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.showNavbarBottomLine = YES;
    if (self.placeholderViewHeight ==0) {
        self.placeholderViewHeight = 108;
    }
    
    [self setUIAppearance];
    
    [self _configureNavbar];
    //    View controller-based status bar appearance 为NO 设置白色状态栏
    //手势滑动返回的边距
    [self setFd_interactivePopMaxAllowedInitialDistanceToLeftEdge:120];
    
    
    
    //    //是否打开app的网络权限
    //    CTCellularData *cellularData = [[CTCellularData alloc]init];
    //    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
    //        //获取联网状态
    //        switch (state) {
    //            case kCTCellularDataRestricted:
    //
    //                [self showSimplyAlertWithTitle:@"提示" message:@"允许“优鲜共享”使用WLAN与蜂窝移动网" sureAction:^(UIAlertAction *action) {
    //                        NSString * urlString = @"App-Prefs:root=WIFI";
    //                        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
    //                            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
    //                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
    //                            } else {
    //                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    //                            }
    //                        }
    //                }];
    //                break;
    //            case kCTCellularDataNotRestricted:
    //                JLog(@"Not Restricted");
    //                break;
    //            case kCTCellularDataRestrictedStateUnknown:
    //                JLog(@"Unknown");
    //                break;
    //            default:
    //                break;
    //        };
    //    };
    
    
}





-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (self.navigationController) {
        [self.tabBarController.tabBar setHidden:YES];
        NSInteger count = self.navigationController.viewControllers.count;
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (count == 1) {
            [delegate.mainVC showOrHideTabBar:YES];
       
        } else if (count > 1) {
          
            [delegate.mainVC showOrHideTabBar:NO];
        }
    }
    
    //   [UManager enterPage:NSStringFromClass([self class])];
#ifdef DEBUG
    NSLog(@"VC %@ ViewWillAppear",NSStringFromClass([self class]));
#else
    
#endif
    
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    if (!_isPushPage) {
//        for (UISwipeGestureRecognizer *recognizer in [[self view] gestureRecognizers]) {
//            [[self view] removeGestureRecognizer:recognizer];
//        }
//    }
  
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     
}


- (void)_configureNavbar {
    UIImage *navBarBgImg = nil;
    UIImage *navBarImg = nil;
    
    //    if (!self.showNavbarBottomLine) {
    navBarImg = navBarBgImg = [UIImage new];
    //    }else {
    //        navBarImg = navBarBgImg = nil;
    //    }
    [self.navigationController.navigationBar setBackgroundImage:navBarBgImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:navBarImg];
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];//导航栏颜色
     
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-0.5, kScreenWidth, 0.5)];
    lineView.tag=1001;
   lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
   [self.navigationController.navigationBar addSubview:lineView];
     
   
}

//有的界面导航栏不需要线
- (void)removeLine{
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (view.tag==1001) {
            [view removeFromSuperview];
        }
    }
}

 

-(void)setPageTitle:(NSString *)pageTitle {
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    titleLable.font = [UIFont fontWithName:@"PingFang SC Bold" size:16.0f];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = KCOLOR_MAIN_TEXT;
    titleLable.text = pageTitle;
    self.navigationItem.titleView = titleLable;
}

- (void)setBarButtonItem {
    if (self.navigationController.viewControllers.count == 1) return;
    if (self.doNotNeedBaseBackItem){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        return;
    }
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initDLSalerBackItemWihtAction:@selector(goBack) target:self];
    
    
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
 
    
}

 

- (void)setUIAppearance {
    [self setBarButtonItem];
    self.navigationController.navigationBar.translucent = NO;
    //    [self setNavigationBar];
    //    self.view.backgroundColor = VCBackgroundColor;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)goBackAfter:(NSInteger)seconds {
    
    [self performSelector:@selector(goBack) withObject:nil afterDelay:seconds];
}

- (void)delayGoBack {
    
    [self goBackAfter:defaulDelayGoBackSeconds];
    
}


- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (AlertViewManager *)alertManager {
    
    if (!_alertManager) {
        _alertManager = [[AlertViewManager alloc] init];
    }
    return _alertManager;
}

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction

{
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    }];
}

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                       sureTitle:(NSString *)sureTitle
                      sureAction:(AlertViewAction)sureAction

{
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:sureTitle actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    }];
}


- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction
                    cancelAction:(AlertViewOtherAction)cancelAction
{
    
    //两个action
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        if (cancelAction) {
            cancelAction(action);
        }
    }];
}


@end
