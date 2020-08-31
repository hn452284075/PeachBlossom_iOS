//
//  GoodsShelvesVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "GoodsShelvesVC.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "ShelvesDetailsVC.h"
@interface GoodsShelvesVC ()
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@property (nonatomic,strong)  NSArray *classNames;
@end

@implementation GoodsShelvesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle=@"我的商品";
     [self _initSegementControll];
     self.view.backgroundColor  = [UIColor whiteColor];
    
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
    self.classNames =  @[@"已上架",@"已下架"];
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.classNames];
    self.topBarControl.frame = CGRectMake(0, 6, 220, 26);
    self.topBarControl.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    self.topBarControl.center=bgView.center;
    [bgView addSubview:self.topBarControl];
    
    self.topBarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    self.topBarControl.font = [UIFont fontWithName:@"PingFang SC" size:14.0f];
    self.topBarControl.textColor = KCOLOR_MAIN_TEXT;
    self.topBarControl.selectedTextColor = KCOLOR_Main;
    self.topBarControl.selectionIndicatorColor = KCOLOR_Main;
    self.topBarControl.selectionIndicatorHeight=2;
    self.topBarControl.segmentEdgeInset=UIEdgeInsetsMake(0, 5, 0, 5);
    [self _creatHMSegementController];
    
  
    
}

#pragma mark ------------------------Private------------------------------
- (void)_creatHMSegementController {
    WEAK_SELF
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, 38, kScreenWidth,kScreenHeight-38) childSegementControllClass:[ShelvesDetailsVC class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
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
