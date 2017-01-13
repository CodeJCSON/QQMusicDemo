//
//  ViewController.m
//  QQMusicDemo
//
//  Created by @Hy on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import <FXBlurView.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) HeaderView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UIImage *blurImage;
@property (nonatomic, assign) BOOL isShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(H-navigationH, 0, 0, 0);

    HeaderView *headerView = [HeaderView loadView];
    _headerView = headerView;
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), H);
    [self.view addSubview:headerView];
    [self.view insertSubview:headerView atIndex:0];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    
    _titleLabel.frame = CGRectMake(8, 35, CGRectGetWidth(self.view.frame)-16, 30);
    _titleLabel.alpha = 0.0f;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([object isKindOfClass:[UITableView class]]) {
            [_headerView updateLayoutAtOffset:((UITableView*)object).contentOffset];
//             [self updateUIWithContentOffsetY:((UITableView*)object).contentOffset.y];
            CGFloat y = ((UITableView*)object).contentOffset.y;
            CGFloat pro = MAX(-y/(H-navigationH), 0);
            CGFloat d = MAX(1-pro, 0);
            //图片逐步模糊（CPU占用率高,效率低）
            UIImage *image = [_headerView.imageView.image mutableCopy];
            UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.0f];
            //模糊系数
            if (y <= 0.f) {
                _blurImage = [image blurredImageWithRadius:d*70 iterations:2.5f tintColor:tintColor];
            }
            _headerView.imageView.image = _blurImage;
            if (-y > H-navigationH) {
                _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), (-y)+navigationH);
            }
            
            if (d >= 0.5f) {
                if (!_isShow) {
                    [self AppearsTitleLabel];
                }
            } else {
                if (_isShow) {
                    [self DisappearTitleLabel];
                }
            }
            
        }
    }
}

- (void)DisappearTitleLabel
{
    _isShow = false;
    _titleLabel.alpha = 1.0f;
    CGRect rect = CGRectMake(8, 35, CGRectGetWidth(self.view.frame)-16, 30);
    [UIView animateWithDuration:0.2 animations:^{
        _titleLabel.alpha = 0.0f;
        _titleLabel.frame = rect;
    }];
}

- (void)AppearsTitleLabel
{
    _isShow = true;
    _titleLabel.alpha = 0.0f;
    CGRect rect = CGRectMake(8, 25, CGRectGetWidth(self.view.frame)-16, 30);
    [UIView animateWithDuration:0.2 animations:^{
        _titleLabel.alpha = 1.0f;
        _titleLabel.frame = rect;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
