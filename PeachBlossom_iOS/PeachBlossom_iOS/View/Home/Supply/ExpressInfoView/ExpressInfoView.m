//
//  ExpressInfoView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ExpressInfoView.h"

@implementation ExpressInfoView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)dismissInfoView:(id)sender
{
    [self.delegate expressInfoViewDismiss];
    
}
@end
