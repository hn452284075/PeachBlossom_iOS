//
//  CommentHeaderView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommentHeaderViewDelegate <NSObject>

- (void)showAllCommentAction;

@end

@interface CommentHeaderView : UIView<CommentHeaderViewDelegate>

@property (nonatomic, weak) id<CommentHeaderViewDelegate>delegate;


- (IBAction)showAllComment:(id)sender;

@end

NS_ASSUME_NONNULL_END
