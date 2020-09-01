//
//  SupplyOrderVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SupplyOrderVC.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "SupplyOrderDetailsVC.h"

@interface SupplyOrderVC ()
@property (strong, nonatomic)HMSegmentedControl *topBarControl;
@property (strong, nonatomic)HMSegementController *topBarController;
@property (nonatomic,strong)NSArray *classNames;
@end

@implementation SupplyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle=@"供应订单";
    [self _initSegementControll];
    [self removeLine];
     if (self.topBarControl) {
        [self.topBarController setSegementIndex:0 animated:YES];
        
     }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark ------------------------Init---------------------------------
- (void)_initSegementControll {
    self.classNames =  @[@"全部",@"待发货",@"已发货",@"已收货"];
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.classNames];
    self.topBarControl.frame = CGRectMake(0, 6, kScreenWidth, 26);
    self.topBarControl.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 39)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView addSubview:self.topBarControl];
    
    self.topBarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    self.topBarControl.font = [UIFont fontWithName:@"PingFang SC" size:14.0f];
    self.topBarControl.textColor = KCOLOR_MAIN_TEXT;
    self.topBarControl.selectedTextColor = KCOLOR_Main;
    self.topBarControl.selectionIndicatorColor = KCOLOR_Main;
    self.topBarControl.selectionIndicatorHeight=2;
    [self _creatHMSegementController];
    
  
    
}

#pragma mark ------------------------Private------------------------------
- (void)_creatHMSegementController {
    WEAK_SELF
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, 39, kScreenWidth,kScreenHeight-39) childSegementControllClass:[SupplyOrderDetailsVC class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
        [weak_self _assignClassCodeForChildVcs:childControllers];
        
    }];
    self.topBarController.indexChangeBlock = ^(NSInteger index, UIViewController *childVc){
     
        
        
        
    };
    
}

- (void)_assignClassCodeForChildVcs:(NSArray *)chilVcs {
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
    
//    for (NSInteger i=0; i<chilVcs.count; i++) {
//
//        ProcurementDetailsVC  *orderVC  = (ProcurementDetailsVC *)chilVcs[i];
//        orderVC.orderType = array[i];
//    }
}

@end
