//
//  DRStcockNumView.m
//  textsad
//
//  Created by 王咻咻 on 16/4/12.
//  Copyright © 2016年 PolyStor. All rights reserved.
//

#import "DRStcockNumView.h"

@implementation DRStcockNumView
- (instancetype)init {
    DRStcockNumView *view = [[NSBundle mainBundle]loadNibNamed:@"StcockNum" owner:nil options:nil].lastObject;
    return view;
}

/** 输入股票编码 */
- (IBAction)clickToInput:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(DRStcockNumViewClickKey:Key:)]) {
        [self.delegate DRStcockNumViewClickKey:self Key:sender.titleLabel.text];
    }
}



/** 功能键*/

- (IBAction)clickFunctionKey:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(stockNumViewFunctionKeyDidClicked:KeyType:)]) {
        int functionType;
        if ([sender.titleLabel.text isEqualToString:@"退格"]) {
            functionType = functionKeyBack;
        }else if ([sender.titleLabel.text isEqualToString:@"隐藏"] ) {
            functionType = functionKeyHiden;
        }else if ([sender.titleLabel.text isEqualToString:@"清空"]) {
            functionType = functionKeyClear;
        }else if ([sender.titleLabel.text isEqualToString:@"确定"] ) {
            functionType = functionKeyCommit;
        }else {
            functionType = functionKeyChange;
        }
        [self.delegate stockNumViewFunctionKeyDidClicked:self KeyType:functionType];
    }
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
