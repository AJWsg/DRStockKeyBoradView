//
//  YNKeyBoardView.m
//  YNStockKeyBoard
//
//  Created by 王咻咻 on 16/4/13.
//  Copyright © 2016年 @raydun. All rights reserved.
//

#import "YNKeyBoardView.h"
#import "DRStcockNumView.h"
#import "DRLetterView.h"

@interface YNKeyBoardView () <DRLetterViewDelegate, DRStcockNumViewDelegate>
/** 股票键盘 */
@property (nonatomic, strong) DRStcockNumView *stockView;
/** 字母键盘 */
@property (nonatomic, strong) DRLetterView *letterView;

@end

@implementation YNKeyBoardView
- (instancetype)init {
    if (self = [super init]) {
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    /** 创建股票键盘  */
    _stockView = [[DRStcockNumView alloc] init];
    _stockView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225);
    _stockView.delegate = self;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height -225, 225);
    [self addSubview:_stockView];
}

- (void)letterViewFunctionDidClicked:(DRLetterView *)letterView type:(functionType)keyType {
    switch (keyType) {
        case functionBack:
            [self.textView deleteBackward];
            if ([self.textView isKindOfClass:[UITextView class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
            else if ([self.textView isKindOfClass:[UITextField class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
            break;
        case functionClean:
            //            self.textView.text = nil;
            [self.textView setValue:nil forKey:@"text"];
            if ([self.textView isKindOfClass:[UITextView class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
            else if ([self.textView isKindOfClass:[UITextField class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
            break;
        case functionCommit:
            [self.textView endEditing:YES];
            if([self.keyBoardDelegate respondsToSelector:@selector(keyBoardViewDidClickCommitButton:)]) {
                [self.keyBoardDelegate keyBoardViewDidClickCommitButton:self];
            }
            break;
        case functionSpace:
            [self.textView insertText:@" "];
            if ([self.textView isKindOfClass:[UITextView class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
            else if ([self.textView isKindOfClass:[UITextField class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
            break;
        case functionKeyChange:{
            [_letterView removeFromSuperview];
            [self addSubview:_stockView];
        }
            break;
        case functionPinYin:{
            [self.textView setValue:nil forKey:@"inputView"];
            [self.textView endEditing:YES];
            [self.textView becomeFirstResponder];
        }
        default:
            break;
    }
    
}

- (void)letterViewDidClickKey:(DRLetterView *)letterView Key:(NSString *)key {
    [self.textView insertText:key];
    if ([self.textView isKindOfClass:[UITextView class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    else if ([self.textView isKindOfClass:[UITextField class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

- (void)DRStcockNumViewClickKey:(DRStcockNumView *)DRStcockNumView Key:(NSString *)key {
    [self.textView insertText:key];
    if ([self.textView isKindOfClass:[UITextView class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    else if ([self.textView isKindOfClass:[UITextField class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

- (void)stockNumViewFunctionKeyDidClicked:(DRStcockNumView *)DRStcockNumView KeyType:(functionKeyType)keyType {
    
    switch (keyType) {
        case functionKeyBack:
            [self.textView deleteBackward];
            if ([self.textView isKindOfClass:[UITextView class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
            else if ([self.textView isKindOfClass:[UITextField class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
            break;
        case functionKeyHiden:
            [self.textView endEditing:YES];
            break;
        case functionKeyClear:
            [self.textView setValue:nil forKey:@"text"];
            if ([self.textView isKindOfClass:[UITextView class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
            else if ([self.textView isKindOfClass:[UITextField class]])
                [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
            break;
        case functionKeyCommit:
            [self.textView endEditing:YES];
            if([self.keyBoardDelegate respondsToSelector:@selector(keyBoardViewDidClickCommitButton:)]) {
                [self.keyBoardDelegate keyBoardViewDidClickCommitButton:self];
            }
            break;
        case functionKeyChange:{
            _letterView = [[DRLetterView alloc] init];
            _letterView.delegate = self;
            _letterView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225);
            [self addSubview:_letterView];
            [_stockView removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

- (void)setTextView:(id)textView {
    _textView = textView;
    [_textView setValue:self forKey:@"inputView"];
}



@end
