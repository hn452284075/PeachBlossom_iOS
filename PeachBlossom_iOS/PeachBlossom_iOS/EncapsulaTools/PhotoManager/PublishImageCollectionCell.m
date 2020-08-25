//
//  PublishImageCollectionCell.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/28.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "PublishImageCollectionCell.h"
#import "UIImageView+sd_SetImg.h"
#import "PublishEvaluationModel.h"
@implementation PublishImageCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        [self initUI];
        
    }
    return self;
}
- (void)initUI{

    self.commentImgView = [[UIImageView alloc]init];
    [self addSubview:self.commentImgView];
    [self.commentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        
    }];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setImage:[UIImage imageNamed:@"主图删减按钮"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    
 
    [self addSubview:self.deleteBtn];
 
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.commentImgView.mas_right).mas_offset(0);
        make.top.mas_equalTo(self.commentImgView).mas_offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];

    
    
}

 
- (void)delete{
    
    emptyBlock(self.deleteImageBlock);
    
}
- (void)setModel:(PublishEvaluationModel *)model {
    

    if (model.isAddPhoto ) {
        self.commentImgView.image = [UIImage imageNamed:@"上传图标按钮"];
       
            self.deleteBtn.hidden=YES;
     
        
  
        
    }else{
                self.commentImgView.image = model.commentPhotoImg;
//        [self.commentImgView sd_SetImgWithUrlStr:model.commentPhotoImageUrl placeHolderImgName:nil];
        
            self.deleteBtn.hidden=NO;
       
        
       
    }
    
}

@end
