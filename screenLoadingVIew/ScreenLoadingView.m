//
//  ScreenLoadingView.m
//  screenLoadingVIew
//
//  Created by Chris on 2020/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

#import "ScreenLoadingView.h"
#import <Masonry.h>

#define ZRScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ZRScreenHeight  [UIScreen mainScreen].bounds.size.height


@interface ScreenLoadingView()

@property (nonatomic, strong) UIView *contanierView;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation ScreenLoadingView

- (void)praseUIConfig{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *configArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"configArray : %@",configArray);

    [self addSubview:self.contanierView];
    [self.contanierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(@(ZRScreenWidth));
    }];
    
    [self praseArray:configArray];
}

- (void)praseArray:(NSArray *)array{
    
    for (NSDictionary *dic in array) {
        [self praseDic:dic releatedView:nil];
    }
    
    [self.contanierView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.maxHeight));
    }];
}

- (UIView *)praseDic:(NSDictionary *)dicConfig
        releatedView:(UIView *)relV{
    
    //prase masonry data
    CGFloat ts = [[dicConfig valueForKey:@"ts"] floatValue];
    CGFloat ls = [[dicConfig valueForKey:@"ls"] floatValue];
    CGFloat w = [[dicConfig valueForKey:@"w"] floatValue];
    CGFloat h = [[dicConfig valueForKey:@"h"] floatValue];
    
    CGFloat viewOriginHeight = ts + h;
    if (viewOriginHeight > self.maxHeight) {
        self.maxHeight = viewOriginHeight;
    }
    
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
    return v;
}

- (UIView *)contentV{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    return v;
}

-(UIView *)contanierView{
    if (!_contanierView) {
        _contanierView = [[UIView alloc] init];
        _contanierView.backgroundColor = UIColor.clearColor;
    }
    return _contanierView;
}



@end
