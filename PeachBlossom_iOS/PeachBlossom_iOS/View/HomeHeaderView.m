//
//  HomeHeaderView.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UIImage+extern.h"
@implementation HomeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setArray:(NSArray *)array{
    
        _headCycleView.currentPageDotImage= IMAGE(@"圆角");
        _headCycleView.pageDotImage=[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(6, 6)];
        _headCycleView.imageURLStringsGroup = @[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3154735394,3121028424&fm=26&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1346142700,2282998096&fm=26&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597493597049&di=2fb9c91b233399c2e7549c8553f18432&imgtype=0&src=http%3A%2F%2Fimage.tupian114.com%2F20160901%2F1903030731.jpg"];

}

@end
