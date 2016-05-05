//
//  YNKeyBoardView.h
//  YNStockKeyBoard
//
//  Created by 王咻咻 on 16/4/13.
//  Copyright © 2016年 @raydun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNKeyBoardView;

@protocol YNKeyBoardViewDelegate <NSObject>
- (void)keyBoardViewDidClickCommitButton:(YNKeyBoardView *)View;
@end

@interface YNKeyBoardView : UIView
@property (nonatomic, strong) id textView;
@property (nonatomic, weak) id<YNKeyBoardViewDelegate> keyBoardDelegate;
@end
