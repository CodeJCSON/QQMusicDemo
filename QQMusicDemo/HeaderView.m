//
//  HeaderView.m
//  QQMusicDemo
//
//  Created by @Hy on 16/11/23.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HeaderView.h"
#import "ViewController.h"
@implementation HeaderView

+ (instancetype) loadView
{
   NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
   return [ar lastObject];
}

- (void)updateLayoutAtOffset:(CGPoint)offset
{
    //使用第三方FXBlurView进行模糊，CPU占用率可观。如丝般顺滑tableview (Ps.我猜QQ音乐也是同样的做法)；
    CGFloat y = offset.y;
    CGFloat D = MAX(-y/(H-navigationH), 0);
    CGFloat progress = MAX(1-D, 0);
    _blurView.hidden = (progress <= 0.0f);
    if (y <= 0.f)
    {
        _blurView.blurRadius = progress*60;
    }
    if (offset.y <= 0.0f)
    {
        
        float height = (H-navigationH)+offset.y;
        if (height <= 0.0f) {
            _bottomLayout.constant = 0.0f;
        } else {
            _bottomLayout.constant = height;
        }
        
    } else {
        _bottomLayout.constant = CGRectGetHeight(self.frame)-navigationH;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
