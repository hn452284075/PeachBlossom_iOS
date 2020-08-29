//
//  GoodsCommentController.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/29.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "GoodsCommentController.h"
#import "MycommonTableView.h"
#import "CommentOneView.h"

@interface GoodsCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MycommonTableView *comentTableView;
@property (nonatomic, strong) UIView *tablviewHeaderView;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation GoodsCommentController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    int iphonex_height = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        iphonex_height = 20;
        
    UIView *topImg = [[UIView alloc] init];
    [self.view addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(66+iphonex_height);
    }];
    topImg.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    UILabel *titleLab = [[UILabel alloc] init];
    [topImg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topImg.mas_bottom).offset(-14);
        make.centerX.equalTo(topImg.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"交易评价";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = kGetColor(0x22, 0x22, 0x22);
    
    //返回箭头
    UIButton *backBtn = [[UIButton alloc] init];
    [topImg addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab.mas_centerY);
        make.left.equalTo(topImg.mas_left).offset(14);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    [backBtn setBackgroundImage:IMAGE(@"返回") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backFrontController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.comentTableView = [[MycommonTableView alloc] init];
    self.comentTableView.delegate = self;
    self.comentTableView.dataSource = self;
    self.comentTableView.tableFooterView = [[UIView alloc] init];
    self.comentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.comentTableView];
    [self.comentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImg.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    self.comentTableView.tableHeaderView = [self tableHeaderView];
    
    
    WEAK_SELF
    [self.comentTableView headerRreshRequestBlock:^{
        weak_self.comentTableView.dataLogicModule.currentDataModelArr = @[].mutableCopy;
        weak_self.comentTableView.dataLogicModule.requestFromPage=1;
        [weak_self _requestOrderData];
    }];
    
    
    [self.comentTableView footerRreshRequestBlock:^{
        [weak_self _requestOrderData];
        
    }];
    
    
    //测试数据
    NSArray *imageArr = [[NSArray alloc] initWithObjects:IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"), nil];
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:IMAGE(@"supply_goodsimg"),@"headImg",
                               @"Rover",@"name",
                               @"这是评论内容",@"comment",
                               imageArr,@"commentimg",
                               @"2020-02-20",@"date",
                               @"大果",@"spec",
                               @"10000斤",@"weight",
                               @"广州发往湖南",@"express",
    nil];
    
    NSArray *imageArr2 = [[NSArray alloc] initWithObjects:IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"home-icon_3"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"home-icon_3"),IMAGE(@"home-icon_3"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"), nil];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:IMAGE(@"supply_goodsimg"),@"headImg",
                               @"Rover",@"name",
                               @"这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容",@"comment",
                               imageArr2,@"commentimg",
                               @"2020-02-20",@"date",
                               @"大果",@"spec",
                               @"10000斤",@"weight",
                               @"广州发往湖南",@"express",
    nil];
    
    NSArray *imageArr3 = [[NSArray alloc] init];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:IMAGE(@"supply_goodsimg"),@"headImg",
                               @"Rover",@"name",
                               @"这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容这是评论内容",@"comment",
                               imageArr3,@"commentimg",
                               @"2020-02-20",@"date",
                               @"大果",@"spec",
                               @"10000斤",@"weight",
                               @"广州发往湖南",@"express",
    nil];
    
    self.dic = [[NSMutableDictionary alloc] init];
    [self.dic setObject:dic1 forKey:@"1"];
    [self.dic setObject:dic2 forKey:@"2"];
    [self.dic setObject:dic3 forKey:@"3"];
}


#pragma mark ------------------------Api----------------------------------
-(void)_requestOrderData{
 
    
}



#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------ 返回上级页面
- (void)backFrontController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------Delegate-----------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *c_dic = [self.dic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row+1]];
    
    NSDictionary * dict = @{
        NSFontAttributeName : [UIFont systemFontOfSize:14]
    };
    CGSize size = [[c_dic objectForKey:@"comment"] boundingRectWithSize:CGSizeMake(kScreenWidth-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    NSArray *c_arr = [c_dic objectForKey:@"commentimg"];
    
    int count = (int)c_arr.count%4==0?(int)c_arr.count/4:((int)c_arr.count/4)+1;
    int cvheight = size.height+50+(kScreenWidth-24)/4*count+60;
    
    
    return cvheight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dic.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodsCommentCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        CommentOneView *cv = [[CommentOneView alloc] init];
        cv.tag = 1;
        [cell.contentView addSubview:cv];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *c_dic = [self.dic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row+1]];
    
    CommentOneView *cv = [cell viewWithTag:1];
    
        [cv configViewData:c_dic[@"headImg"]
                 name:c_dic[@"name"]
              comment:c_dic[@"comment"]
               images:c_dic[@"commentimg"]
                 time:c_dic[@"date"]
                 spec:c_dic[@"spec"]
               weight:c_dic[@"weight"]
                place:c_dic[@"express"]];
    
    
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top);
        make.bottom.equalTo(cell.mas_bottom);
        make.left.equalTo(cell.mas_left);
        make.right.equalTo(cell.mas_right);
    }];
    
    
    return cell;
}

#pragma mark ------------------------Init---------------------------------
- (UIView *)tableHeaderView
{
    self.tablviewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    int x = 14;
    int y = 20;
    int w = (kScreenWidth-14*3)/3;
    NSArray *testarr = [[NSArray alloc] initWithObjects:@"全部(12345)",@"有图(233)",@"好评(12344)",@"中评(234)",@"差评(0)", nil];
    
    for(int i=0;i<testarr.count;i++)
    {
        UIButton *tagbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagbtn.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        [tagbtn setTitle:[testarr objectAtIndex:i]  forState:UIControlStateNormal];
        [self.tablviewHeaderView addSubview:tagbtn];
        
        [tagbtn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
        tagbtn.layer.cornerRadius = 13.0;
        tagbtn.tag = 10+i;
        
        if(x + w + 14 > kScreenWidth)  //超过屏幕宽度，另起i一行
        {
            x = 14;
            y = y + 27 + 11;
        }
        
        tagbtn.frame = CGRectMake(x, y, w, 27);
        tagbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        x +=7;
        x +=w;
        
        [tagbtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            [tagbtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIView *bv = [[UIView alloc] initWithFrame:CGRectMake(0, y+27+17, kScreenWidth, 10)];
    [self.tablviewHeaderView addSubview:bv];
    bv.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    return self.tablviewHeaderView;
}


#pragma mark ------------------------View Event---------------------------
- (void)tagBtnClicked:(id)sender
{
    for(UIView *v in self.tablviewHeaderView.subviews)
    {
        if([v isKindOfClass:[UIButton class]] && v.tag!= 100 && v.tag != 101)
        {
            UIButton *btn = (UIButton *)v;
            btn.layer.borderWidth = 0;
            [btn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
            btn.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        }
    }
    
    UIButton *btn = (UIButton *)sender;
    btn.layer.borderColor = kGetColor(0x47, 0xc6, 0x7c).CGColor;
    [btn setTitleColor:kGetColor(0x47, 0xc6, 0x7c) forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.;
    btn.backgroundColor = [UIColor clearColor];
}




@end
