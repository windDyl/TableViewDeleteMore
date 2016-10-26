//
//  BottomView.h
//  TestNetWorking
//
//  Created by Ethank on 2016/10/26.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BottomView;

@protocol BottomViewDelegate <NSObject>

- (void)clickSelectedAll;
- (void)clickDeleted;

@end

@interface BottomView : UIView
@property (nonatomic, weak)id<BottomViewDelegate>delegate;
@end
