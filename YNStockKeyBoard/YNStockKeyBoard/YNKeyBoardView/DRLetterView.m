//
//  DRLetterView.m
//  textsad
//
//  Created by 王咻咻 on 16/4/12.
//  Copyright © 2016年 PolyStor. All rights reserved.
//

#import "DRLetterView.h"

@interface DRLetterView ()
enum {
    PKNumberPadViewImageLeft = 0,
    PKNumberPadViewImageInner,
    PKNumberPadViewImageRight,
    PKNumberPadViewImageMax
};

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *funckey;
@property (weak, nonatomic) IBOutlet UIView *viewThirdRow;
@property (weak, nonatomic) IBOutlet UIView *viewSecondRow;
@property (weak, nonatomic) IBOutlet UIView *viewOneRow;

@end

@implementation DRLetterView

- (instancetype)init {
  
    return [[NSBundle mainBundle] loadNibNamed:@"DRLetterView" owner:self options:nil].lastObject;
}

- (IBAction)clickLetterBtn:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(letterViewDidClickKey:Key:)]) {
        [self.delegate letterViewDidClickKey:self Key:sender.titleLabel.text];
    }
}

- (IBAction)clickFunctionKey:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(letterViewFunctionDidClicked:type:)]) {
        int functionType;
        if ([sender.titleLabel.text isEqualToString:@"清空"]) {
            functionType = functionClean;
        }else if ([sender.titleLabel.text isEqualToString:@"退格"] ){
            functionType = functionBack;
        }else if ([sender.titleLabel.text isEqualToString:@"123"]) {
            functionType = functionChange;
        }else if ([sender.titleLabel.text isEqualToString:@"空格"]){
            functionType = functionSpace;
        }else if ([sender.titleLabel.text isEqualToString:@"确定"]){
            functionType = functionCommit;
        }else if ([sender.titleLabel.text isEqualToString:@"拼"]){
            functionType = functionPinYin;
        }
        [self.delegate letterViewFunctionDidClicked:self type:functionType];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    for (UIButton *b in self.characterKeys) {
        if ([b subviews].count > 1) {
            [[[b subviews] objectAtIndex:1] removeFromSuperview];
        }
        if(CGRectContainsPoint([b.superview convertRect:b.frame toView:self], location)){
            [self addPopupToButton:b];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    for (UIButton *b in self.characterKeys) {
        if ([b subviews].count > 1) {
            [[[b subviews] objectAtIndex:1] removeFromSuperview];
        }
        if(CGRectContainsPoint([b.superview convertRect:b.frame toView:self], location)){
            [self addPopupToButton:b];
        }
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    for (UIButton *b in self.characterKeys) {
        if ([b subviews].count > 1) {
            [[[b subviews] objectAtIndex:1] removeFromSuperview];
        }
        if(CGRectContainsPoint([b.superview convertRect:b.frame toView:self], location)){
            [self clickLetterBtn:b];
        }
    }

    for (UIButton *funkeyB in self.funckey) {
        if(CGRectContainsPoint([funkeyB.superview convertRect:funkeyB.frame toView:self], location)){
            [self clickFunctionKey:funkeyB];
        }
    }
}



- (UIView *)lookUpFitSubviewWithPoint:(CGPoint)point fromView:(UIView *)view {
     __block UIView *subView = view;
    [[view subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(CGRectContainsPoint(obj.frame, point) ) {
                subView = obj;
                *stop = YES;
        }
    }];
    if (subView != view && ![subView isKindOfClass:[UIButton class]] ) {
        subView = [self lookUpFitSubviewWithPoint:[subView convertPoint:point fromView:view] fromView:subView];
    }
    return subView;
}

- (void)addPopupToButton:(UIButton *)b {

    UIImageView *keyPop = [[UIImageView alloc] init];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(9,0, 52, 60)];
    keyPop.image = [UIImage imageNamed:@"图层-1"];
    keyPop.frame = CGRectMake(-b.frame.size.width/2 ,-b.frame.size.height*1.2,b.frame.size.width * 2, b.frame.size.height*2.2);
    [b setClipsToBounds:NO];
    [text setFont:[UIFont systemFontOfSize:44]];
    
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setText:b.titleLabel.text];
    [text sizeToFit];

    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 2.0);
    keyPop.layer.shadowOpacity = 0.30;
    keyPop.layer.shadowRadius = 3.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
