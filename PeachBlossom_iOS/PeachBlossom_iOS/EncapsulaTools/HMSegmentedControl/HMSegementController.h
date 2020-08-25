//
//  HMSegementController.h
//  YilidiBuyer
//
//  Created by mm on 16/12/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSegmentedControl;
typedef void(^HMSegementIndexChangeBlock)(NSInteger index,UIViewController *segementChildController);
typedef void(^ChildControllersCompletedAddedBlock)(NSArray *childControllers);
@interface HMSegementController : NSObject
#warning 这里不能用strong,控制器强引用了该类，所以该类只能弱引用控制器
@property (nonatomic,weak) UIViewController *segementParentController;

-(instancetype)initWithSegementControl:(HMSegmentedControl *)segementControl
               segementControllerFrame:(CGRect)segementControllerFrame
            childSegementControllClass:(Class)childSegementControllClass
   childControllersCompletedAddedBlock:(ChildControllersCompletedAddedBlock)childControllersCompletedAddedBlock;

-(instancetype)initWithSegementControl:(HMSegmentedControl *)segementControl
               segementControllerFrame:(CGRect)segementControllerFrame
          childSegementControllClasses:(NSArray *)childSegementControllClasses
   childControllersCompletedAddedBlock:(ChildControllersCompletedAddedBlock)childControllersCompletedAddedBlock;

@property (nonatomic,copy)HMSegementIndexChangeBlock indexChangeBlock;

-(void)setSegementIndex:(NSInteger)index animated:(BOOL)animated;

/**
 滑动下面的scrollView的时候，上面的index是否会改变,default=yes
 */
@property (nonatomic,assign)BOOL topControllWillChangeIndexWhenScrollSegementControllerScrollView;


@end
