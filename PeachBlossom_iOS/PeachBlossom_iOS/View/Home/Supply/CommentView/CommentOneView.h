//
//  CommentOneView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentOneView : UIView

//头像 评论用户名 评论内容 评论图片数组  时间 类别  重量  目的地

- (instancetype)initWithFrame:(CGRect)frame
                    headImage:(UIImage *)headImage
                         name:(NSString *)name
                      comment:(NSString *)comment
                       images:(NSArray *)imgArr
                         time:(NSString *)time
                         spec:(NSString *)spec
                       weight:(NSString *)weight
                        place:(NSString *)place;

//- (void)configViewData:(UIImage *)headImage
//                  name:(NSString *)name
//               comment:(NSString *)comment
//                images:(NSArray *)imgArr
//                  time:(NSString *)time
//                  spec:(NSString *)spec
//                weight:(NSString *)weight
//                 place:(NSString *)place;

@end

NS_ASSUME_NONNULL_END
