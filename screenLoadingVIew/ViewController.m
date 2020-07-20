//
//  ViewController.m
//  screenLoadingVIew
//
//  Created by Chris on 2020/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ScreenLoadingView.h"

#define ZRScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ZRScreenHeight  [UIScreen mainScreen].bounds.size.height



@interface ViewController ()


@property (nonatomic, strong) ScreenLoadingView *scorllView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scorllView];
    [_scorllView praseUIConfig];
    [self.scorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(ScreenLoadingView *)scorllView{
    if (!_scorllView) {
        _scorllView = [[ScreenLoadingView alloc] init];
        _scorllView.backgroundColor = UIColor.clearColor;
    }
    return _scorllView;
}

@end
