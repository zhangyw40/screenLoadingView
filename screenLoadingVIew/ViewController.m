//
//  ViewController.m
//  screenLoadingVIew
//
//  Created by Chris on 2020/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#define ZRScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ZRScreenHeight  [UIScreen mainScreen].bounds.size.height



@interface ViewController ()


@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, strong) UIView *contanierView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *configArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"configArray : %@",configArray);
    
    [self.view addSubview:self.scorllView];
    [self.scorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.scorllView addSubview:self.contanierView];
    [self.contanierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scorllView);
        make.width.equalTo(@(ZRScreenWidth));
    }];
    
    [self praseArray:configArray];
}

- (void)praseArray:(NSArray *)array{
    
    for (NSDictionary *dic in array) {
        UIView *releatedV = nil;
        NSArray *item_array = [dic valueForKey:@"childItem"];
        if (item_array) {
            releatedV = [self praseDic:dic releatedView:nil];
            for (NSDictionary *dic_l in item_array) {
                [self praseDic:dic_l releatedView:releatedV];
            }
        }else{
            [self praseDic:dic releatedView:nil];
        }
    }
}

- (UIView *)praseDic:(NSDictionary *)dicConfig
        releatedView:(UIView *)relV{
    
    //prase masonry data
    CGFloat ts = [[dicConfig valueForKey:@"ts"] floatValue];
    CGFloat ls = [[dicConfig valueForKey:@"ls"] floatValue];
    CGFloat w = [[dicConfig valueForKey:@"w"] floatValue];
    CGFloat h = [[dicConfig valueForKey:@"h"] floatValue];
    BOOL is_b = [[dicConfig valueForKey:@"is_b"] boolValue];
    
    
    
    UIView *v = [self contentV];
    if (relV) {
        [self.contanierView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(relV.mas_top).offset(ts);
            make.left.equalTo(relV.mas_right).offset(ls);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
    }else{
        [self.contanierView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ts));
            make.left.equalTo(@(ls));
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
    }
    
    if (is_b) {
        [self.contanierView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(v.mas_bottom);
        }];
    }
    
    return v;
}

- (UIView *)contentV{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    return v;
}

-(UIScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [[UIScrollView alloc] init];
        _scorllView.backgroundColor = UIColor.clearColor;
    }
    return _scorllView;
}

-(UIView *)contanierView{
    if (!_contanierView) {
        _contanierView = [[UIView alloc] init];
        _contanierView.backgroundColor = UIColor.clearColor;
    }
    return _contanierView;
}

@end
