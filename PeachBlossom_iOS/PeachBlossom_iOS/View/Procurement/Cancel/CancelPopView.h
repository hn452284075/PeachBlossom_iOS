//
//  CancelPopView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SeletecdTypeBlock)(NSString *type);

@interface CancelPopView : NSObject<UITableViewDelegate,UITableViewDataSource>
+ (instancetype)sharedInstance;
@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic, copy)SeletecdTypeBlock seletecdTypeBlock;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,assign) NSInteger currentIndex;
-(void)show:(SeletecdTypeBlock)block;
@end


