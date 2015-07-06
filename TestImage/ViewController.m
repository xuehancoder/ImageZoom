//
//  ViewController.m
//  TestImage
//
//  Created by xuehan on 15/7/1.
//  Copyright (c) 2015年 xuehan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}

static CGFloat scale = 1.5;
static bool isBig = NO;
static CGPoint imagePoint;
static CGSize size;
- (void)tap:(UITapGestureRecognizer *)tap{
    
    imagePoint = [tap locationInView:self.imageView];

    if(isBig == NO)
    {
        if(CGRectContainsPoint(self.imageView.bounds, imagePoint)){
            size = self.imageView.size;
            // 向上、向左偏移的距离
            CGFloat top,left;
            top = imagePoint.y * (scale - 1);
            left = imagePoint.x * (scale - 1);
            [UIView animateWithDuration:0.5 animations:^{
                self.imageView.frame = CGRectMake(-left, -top,size.width * scale , size.height * scale);
            }];
            self.scrollView.contentSize = CGSizeMake(size.width * scale , size.height * scale);
            self.scrollView.contentInset = UIEdgeInsetsMake(top, left, -top, -left);
            isBig = YES;
        }

    }else{
        
        [UIView animateWithDuration:.5f animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
            self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        }];
        self.scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
        self.scrollView.contentSize = size;

        isBig = NO;
    }

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
