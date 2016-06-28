//
//  ViewController.m
//  DealWithKeyBoard
//
//  Created by ZhouYong on 16/6/18.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ViewController.h"
#import "ZYKeyboardTool.h"

@interface ViewController () <UITextFieldDelegate,ZYKeyboardToolDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;

/**工具类**/
@property(nonatomic, strong)ZYKeyboardTool* tool;

/**存放输入文本的控件数量**/
@property(nonatomic, copy)NSArray* fieldArray;


@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ZYKeyboardTool* tool = [ZYKeyboardTool tool];
    tool.toolBarDelegate = self;
    self.userName.inputAccessoryView = tool;
    self.password.inputAccessoryView = tool;
    self.emailAddress.inputAccessoryView = tool;
    self.tool = tool;
    self.fieldArray = @[self.userName,self.password,self.emailAddress];
}


- (void)testAccessoryViewAndInputViewForTextfield{
    UIView* keyBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    self.userName.inputView = keyBoard;
    
    keyBoard.backgroundColor = [UIColor blueColor];
    UIView* accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    accessoryView.backgroundColor = [UIColor magentaColor];
    self.password.inputAccessoryView = accessoryView;
    [self.password.inputAccessoryView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
}


#pragma mark*****让所有的UITextField控件遵循UITextFieldDelegate代理********
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userName) {
        [self.password becomeFirstResponder];
    }else if (textField == self.password)
    {
        [self.emailAddress becomeFirstResponder];
    }else if (textField == self.emailAddress){
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark**********ZYKeyboardToolDelegate协议里面的方法************
- (void)keyboardToolDidClickPreviousItem:(ZYKeyboardTool *)tool
{
//    [self.view endEditing:YES];
    NSInteger currentIndex = 0;
//    在当前视图的子视图中遍历寻找 第一响应者
    for (UIView* view in self.view.subviews) {
        if ([view isFirstResponder]) {
            currentIndex = [self.fieldArray indexOfObject:view];
        }
    }
//   当前的下标减1
    currentIndex--;
//   让上一个输入框成为第一响应者
    [self.fieldArray[currentIndex] becomeFirstResponder];
    self.tool.previousItem.enabled = (currentIndex != 0);
    self.tool.nextItem.enabled = YES;

}

- (void)keyboardToolDidClickNextItem:(ZYKeyboardTool *)tool
{
    NSInteger currentIndex = 0;
    for (UIView* view in self.view.subviews) {
        if ([view isFirstResponder]) {
            currentIndex = [self.fieldArray indexOfObject:view];
        }
    }
    currentIndex++;
    [self.fieldArray[currentIndex] becomeFirstResponder];
    self.tool.previousItem.enabled = YES;

    self.tool.nextItem.enabled = (currentIndex < (self.fieldArray.count - 1));
}

- (void)keyboardToolDidClickDoneItem:(ZYKeyboardTool *)tool
{
    [self.view endEditing:YES];
}


#pragma mark**********下面这种是通过枚举的做法来实现的************
- (void)keyboardToolDidClickItemType:(ZYKeyboardToolType)itemType
{
    #pragma mark**********这里面还可以进行多种判断，通过枚举值判断辅助视图上面的哪一个控件被点击了，进行相应的事件************
    if (itemType == ZYKeyboardToolTypeDone) {
        [self.view endEditing:YES];
    }
}

#pragma mark**********键盘弹出就会调用这个方法************
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger currentIndex =  [self.fieldArray indexOfObject:textField];
    self.tool.previousItem.enabled = (currentIndex != 0 );
    self.tool.nextItem.enabled = (currentIndex != (self.fieldArray.count - 1));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
