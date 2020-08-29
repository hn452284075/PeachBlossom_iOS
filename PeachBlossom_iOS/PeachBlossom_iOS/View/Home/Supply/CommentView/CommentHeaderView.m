//
//  CommentHeaderView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CommentHeaderView.h"

@implementation CommentHeaderView
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)showAllComment:(id)sender
{
    [self.delegate showAllCommentAction];
}
@end
