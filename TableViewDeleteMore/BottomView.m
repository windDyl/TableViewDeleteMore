//
//  BottomView.m
//  TestNetWorking
//
//  Created by Ethank on 2016/10/26.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "BottomView.h"
#import <Masonry.h>

@interface BottomView ()
@property (nonatomic, weak)UIButton *leftButton;
@property (nonatomic, weak)UIButton *rightButton;
@end

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        [left setTitle:@"Select All" forState:UIControlStateNormal];
        [left setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(clickSelectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(left.superview);
            make.width.equalTo(left.superview).multipliedBy(0.5);
        }];
        self.leftButton = left;
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        [right setTitle:@"Delete" forState:UIControlStateNormal];
        [right setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(clickDeletedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(left.superview);
            make.width.equalTo(left.superview).multipliedBy(0.5);
        }];
        
        UIImageView *lineView = [[UIImageView alloc] init];
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(lineView.superview);
            make.size.mas_equalTo(CGSizeMake(0.5, 30.0));
        }];
    }
    return self;
}

- (void)clickSelectedAllAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickSelectedAll)]) {
        [self.delegate clickSelectedAll];
    }
}
- (void)clickDeletedAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickDeleted)]) {
        [self.delegate clickDeleted];
    }
}
@end
