//
//  EaseGitButtonsView.m
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "EaseGitButtonsView.h"
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#import "EaseGitButton.h"
#import "UIColor+expanded.h"

@interface EaseGitButtonsView ()


@property(strong,nonatomic)NSMutableArray * gitButtons;



@end


@implementation EaseGitButtonsView




-(instancetype)init{
    if (self == [super init]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"0xf8f8f8"];
    }
    return self;
}

-(void)setCurProject:(Project *)curProject{

    
    
    _curProject = curProject;
    if (_curProject.is_public.boolValue) {
        
        if (!_gitButtons) {
            NSInteger gitBtnNum = 3;
            CGFloat whiteSpace = 7.0;
            CGFloat btnWidth =  (kScreen_Width - 2*15.0 -whiteSpace*2) /3;
            _gitButtons = [NSMutableArray array];
            
            for (int i=0; i < gitBtnNum; i++) {
                EaseGitButton * gitBtn = [EaseGitButton gitButtonWithFrame:CGRectMake(15+i*(btnWidth+whiteSpace), (49-30)/2, btnWidth, 30) type:i];
                __weak typeof(gitBtn) weakGitBtn = gitBtn;
                gitBtn.buttonClickedBlock = ^(EaseGitButton* button,EaseGitButtonPosition position){
                    
                    if (position == EaseGitButtonPositionLeft) {
                        if (button.type == EaseGitButtonPositionLeft || button.type == EaseGitButtonTypeWatch) {
                            
                            weakGitBtn.checked = !weakGitBtn.checked;
                            weakGitBtn.userNum += weakGitBtn.checked ? 1: -1;
                            
                            
                        }
                    }
                    
                    if (self.gitButtonClickedBlock) {
                        self.gitButtonClickedBlock(i,position);
                    }
                    
                };
                
                [self addSubview:gitBtn];
                [_gitButtons addObject:gitBtn];
            }
            
        }
        
        
        
        
        [_gitButtons enumerateObjectsUsingBlock:^(EaseGitButton* obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            switch (idx) {
                case EaseGitButtonTypeStar:
                {
                    obj.userNum = _curProject.star_count.integerValue;
                    obj.checked = _curProject.stared.boolValue;
                }
                    break;
                case EaseGitButtonTypeWatch:
                {
                    obj.userNum = _curProject.watch_count.integerValue;
                    obj.checked = _curProject.watched.boolValue;
                }
                    break;
                case EaseGitButtonTypeFork:
                {
                    obj.userNum = _curProject.fork_count.integerValue;
                    obj.checked = NO;
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }];
        
        self.hidden = NO;
        
    }else{
        self.hidden = YES;
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
