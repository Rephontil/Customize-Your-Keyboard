//
//  ZYKeyboardTool.m
//  DealWithKeyBoard
//
//  Created by ZhouYong on 16/6/19.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYKeyboardTool.h"


@implementation ZYKeyboardTool

+ (instancetype)tool{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (IBAction)PreviousClick:(id)sender {
    if ([self.toolBarDelegate respondsToSelector:@selector(keyboardToolDidClickPreviousItem:)]) {
        [self.toolBarDelegate keyboardToolDidClickPreviousItem:self];
    }
}

- (IBAction)NextClick:(id)sender {
    if ([self.toolBarDelegate respondsToSelector:@selector(keyboardToolDidClickNextItem:)]) {
        [self.toolBarDelegate keyboardToolDidClickNextItem:self];
    }
}

- (IBAction)DoneClick:(id)sender {
//    第一种做法
//    if ([self.toolBarDelegate respondsToSelector:@selector(keyboardToolDidClickDoneItem:)]) {
//        [self.toolBarDelegate keyboardToolDidClickDoneItem:self];
//    }
//    第二种做法
//    这种事枚举值的形式，两个if只要实现一个就可以了
    if ([self.toolBarDelegate respondsToSelector:@selector(keyboardToolDidClickItemType:)]) {
        [self.toolBarDelegate keyboardToolDidClickItemType:ZYKeyboardToolTypeDone];
    }
}

@end
