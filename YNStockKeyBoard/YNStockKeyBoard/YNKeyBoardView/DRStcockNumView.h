//
//  DRStcockNumView.h
//  textsad
//
//  Created by 王咻咻 on 16/4/12.
//  Copyright © 2016年 PolyStor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum functionKeyType {
    functionKeyBack,
    functionKeyHiden,
    functionKeyClear,
    functionKeyCommit,
    functionKeyChange,
}functionKeyType;
@class DRStcockNumView;

@protocol DRStcockNumViewDelegate <NSObject>

- (void)DRStcockNumViewClickKey:(DRStcockNumView *)DRStcockNumView Key:(NSString *)key;
- (void)stockNumViewFunctionKeyDidClicked:(DRStcockNumView *)DRStcockNumView KeyType:(functionKeyType )keyType;



@end

@interface DRStcockNumView : UIView

@property (nonatomic, weak) id<DRStcockNumViewDelegate> delegate;

@end
