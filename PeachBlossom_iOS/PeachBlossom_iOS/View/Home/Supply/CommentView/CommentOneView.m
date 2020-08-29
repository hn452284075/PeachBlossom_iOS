//
//  CommentOneView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CommentOneView.h"
#import "Masonry.h"

@implementation CommentOneView

//- (instancetype)initWithFrame:(CGRect)frame headImage:(UIImage *)headImage name:(NSString *)name comment:(NSString *)comment images:(NSArray *)imgArr time:(NSString *)time spec:(NSString *)spec weight:(NSString *)weight place:(NSString *)place


- (instancetype)initWithFrame:(CGRect)frame headImage:(UIImage *)headImage name:(NSString *)name comment:(NSString *)comment images:(NSArray *)imgArr time:(NSString *)time spec:(NSString *)spec weight:(NSString *)weight place:(NSString *)place
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //头像
        UIImageView *headimg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 41, 41)];
        [self addSubview:headimg];
        headimg.image = headImage;
        headimg.layer.masksToBounds = YES;
        headimg.layer.cornerRadius = 41/2;
        headimg.tag = 1;
        
        //名称
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(headimg.frame.origin.x+headimg.frame.size.width+7, 0, 200, 14)];
        namelabel.center = CGPointMake(namelabel.center.x, headimg.center.y);
        [self addSubview:namelabel];
        namelabel.text = name;
        namelabel.font = [UIFont systemFontOfSize:14];
        namelabel.textColor = kGetColor(0x11, 0x11, 0x11);
        namelabel.tag = 2;
        
        UILabel *commentLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 12+41+12, kScreenWidth-24, 100)];
        commentLab.lineBreakMode = NSLineBreakByWordWrapping;
        commentLab.numberOfLines = 0;
        commentLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:commentLab];
        commentLab.tag = 3;
        
        
        NSDictionary * dict = @{
            NSFontAttributeName : [UIFont systemFontOfSize:14]
        };
        CGSize size = [comment boundingRectWithSize:CGSizeMake(kScreenWidth-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
        
        commentLab.text = comment;
        commentLab.textColor = kGetColor(0x11, 0x11, 0x11);
        commentLab.frame = CGRectMake(12, headimg.frame.origin.x+headimg.frame.size.height+10, size.width, size.height);
        
        
        int row = (int)imgArr.count / 4;
        if(imgArr.count % 4 != 0)
            row +=1;
        int x = 12;
        int y = commentLab.frame.origin.x+size.height+12+50;
        int w = (kScreenWidth-24)/4-1;
        int h = w;
        int endY = y;
        for(int i=0;i<row;i++)
        {
            int temp = 0;
            for(int j=4*i;j<imgArr.count;j++)
            {
                UIImageView *imgv = [[UIImageView alloc] init];
                imgv.frame = CGRectMake(x+(w+2)*temp++, y+h*i, w, h);
                imgv.image = [imgArr objectAtIndex:i];
                imgv.tag = 4+j;
                [self addSubview:imgv];
                endY = y+h*i + h;
                if(temp > 3)
                    break;
            }
        }
                
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(12, endY+12, kScreenWidth-24, 13)];
        [self addSubview:timeLab];
        timeLab.font = [UIFont systemFontOfSize:12];
        timeLab.textColor = kGetColor(0x99, 0x99, 0x99);
        timeLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@",time,spec,weight,place];
        timeLab.tag = 100;
        
    }
    return self;
}





@end
