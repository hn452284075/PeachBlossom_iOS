//
//  ProcurementOrderVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ProcurementOrderVC.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "ProcurementDetailsVC.h"
@interface ProcurementOrderVC ()
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@property (nonatomic,strong)  NSArray *classNames;
@end

@implementation ProcurementOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle=@"采购订单";
    [self _initSegementControll];
    self.view.backgroundColor  = [UIColor whiteColor];
   
    if (self.topBarControl) {
       [self.topBarController setSegementIndex:self.currentIndex animated:YES];
       
    }
}

#pragma mark ------------------------Init---------------------------------
- (void)_initSegementControll {
    self.classNames =  @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.classNames];
    self.topBarControl.frame = CGRectMake(0, 0, kScreenWidth, 40);
    self.topBarControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBarControl];
    
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
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, 40, kScreenWidth,kScreenHeight-40) childSegementControllClass:[ProcurementDetailsVC class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
        [weak_self _assignClassCodeForChildVcs:childControllers];
        
    }];
    self.topBarController.indexChangeBlock = ^(NSInteger index, UIViewController *childVc){
     
        
        
        
    };
    
}

- (void)_assignClassCodeForChildVcs:(NSArray *)chilVcs {
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
    
    for (NSInteger i=0; i<chilVcs.count; i++) {
        
        ProcurementDetailsVC  *orderVC  = (ProcurementDetailsVC *)chilVcs[i];
        orderVC.orderType = array[i];
    }
}
 
@end
