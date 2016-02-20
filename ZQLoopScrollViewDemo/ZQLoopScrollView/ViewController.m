//
//  ViewController.m
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/18.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "ZQLoopScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = @"http://img0.imgtn.bdimg.com/it/u=1070902365,2619384777&fm=206&gp=0.jpg";
    NSArray *images = @[@"h1.jpg",
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        url
                        ];
    NSArray *titles = @[@"Thank you for your support!",
                        @"Contact me if any quetion.",
                        @"Thank you again.",
                        @"Have fun"
                        ];
    
    ZQLoopScrollView *loop = [ZQLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 40, 375, 150) imageUrls:images];

    loop.timeInterval = 2;
    loop.placeholder = [UIImage imageNamed:@"h1.jpg"];
    __weak __typeof(loop) weakLoop = loop;
    loop.didSelectItemBlock = ^(NSInteger atIndex, ZQLoadImageView *sender){
        NSLog(@"clicked item at index: %ld", atIndex);
        [weakLoop pauseTimer];
    };
    loop.didScrollBlock= ^(NSInteger atIndex, ZQLoadImageView *sender) {
        NSLog(@"scroll to index: %ld", atIndex);
    };
    loop.alignment = kPageControlAlignRight;
    loop.adTitles = titles;
    
    [self.view addSubview:loop];
    
    ZQLoopScrollView *loop1 = [ZQLoopScrollView loopScrollViewWithFrame:CGRectMake(0, loop.zq_bottomY + 100, 375, 120) imageUrls:images timeInterval:10.0 didSelect:^(NSInteger atIndex, ZQLoadImageView *sender) {
        //    NSLog(@"clicked item at index: %ld", (long)atIndex);
        
        [loop startTimer];
    } didScroll:^(NSInteger toIndex, ZQLoadImageView *sender) {
        //    NSLog(@"scroll to index: %ld", (long)toIndex);
    }];
    [loop1 setCurrentPageIndicatorTintColor:[UIColor colorWithRed:51.0/255 green:204.0/255 blue:204.0/255 alpha:1]];
    [loop1 setPageControlTintColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:loop1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
