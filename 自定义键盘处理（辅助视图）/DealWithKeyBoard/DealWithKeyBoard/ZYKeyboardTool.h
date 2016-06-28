//
//  ZYKeyboardTool.h
//  DealWithKeyBoard
//
//  Created by ZhouYong on 16/6/19.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYKeyboardTool;

typedef enum
{
    ZYKeyboardToolTypePrevious,
    ZYKeyboardToolTypeNext,
    ZYKeyboardToolTypeDone
}ZYKeyboardToolType;

//1⃣️声明协议
@protocol ZYKeyboardToolDelegate <NSObject>

@optional
//3⃣️代理对象执行协议的方法
- (void)keyboardToolDidClickPreviousItem:(ZYKeyboardTool*)tool;
- (void)keyboardToolDidClickNextItem:(ZYKeyboardTool*)tool;
- (void)keyboardToolDidClickDoneItem:(ZYKeyboardTool*)tool;


//第二种方式  只写一个方法，通过枚举值判断是哪一个控件响应了这个方法
- (void)keyboardToolDidClickItemType:(ZYKeyboardToolType)itemType;


@end

@interface ZYKeyboardTool : UIToolbar

//2⃣️声明属性weak
@property(nonatomic, weak)id<ZYKeyboardToolDelegate> toolBarDelegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;
+ (instancetype)tool;

@end
