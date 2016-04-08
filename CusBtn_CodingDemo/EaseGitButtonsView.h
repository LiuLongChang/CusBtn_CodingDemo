//
//  EaseGitButtonsView.h
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "EaseGitButton.h"

@interface EaseGitButtonsView : UIView



@property(nonatomic,strong)Project *curProject;
@property(copy,nonatomic)void(^gitButtonClickedBlock)(NSInteger index,EaseGitButtonPosition position);





@end
