//
//  DRLetterView.h
//  textsad
//
//  Created by 王咻咻 on 16/4/12.
//  Copyright © 2016年 PolyStor. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum functionType {
    functionBack,
    functionHiden,
    functionClean,
    functionCommit,
    functionChange,
    functionSpace,
    functionPinYin,
}functionType;
@class DRLetterView;

@protocol DRLetterViewDelegate <NSObject>

- (void)letterViewDidClickKey:(DRLetterView *)letterView Key:(NSString *)key;
- (void)letterViewFunctionDidClicked:(DRLetterView *)letterView type:(functionType )keyType;
@end

@interface DRLetterView : UIView
@property (nonatomic, weak) id<DRLetterViewDelegate> delegate;
@end
