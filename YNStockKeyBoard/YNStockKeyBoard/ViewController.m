//
//  ViewController.m
//  YNStockKeyBoard
//
//  Created by 王咻咻 on 16/4/13.
//  Copyright © 2016年 @raydun. All rights reserved.
//

#import "ViewController.h"
#import "YNKeyBoardView.h"
#import "DRStcockNumView.h"

@interface ViewController ()<YNKeyBoardViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textView = [[UITextField alloc] init];
    textView.frame = CGRectMake(20, 20, 100, 40);
    [self.view addSubview:textView];
    [textView setBackgroundColor:[UIColor redColor]];
    YNKeyBoardView *keyBoard = [[YNKeyBoardView alloc] init];
    keyBoard.keyBoardDelegate = self;
    keyBoard.textView = textView;
    [textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyBoardViewDidClickCommitButton:(YNKeyBoardView *)View {
    
    NSLog(@"完成");
}

@end
