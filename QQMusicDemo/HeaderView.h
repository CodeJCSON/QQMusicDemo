//
//  HeaderView.h
//  QQMusicDemo
//
//  Created by @Hy on 16/11/23.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXBlurView.h>
@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
+ (instancetype) loadView;

- (void)updateLayoutAtOffset:(CGPoint)offset;

@end
