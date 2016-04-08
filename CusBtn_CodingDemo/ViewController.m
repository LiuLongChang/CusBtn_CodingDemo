//
//  ViewController.m
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ViewController.h"

#import "EaseGitButtonsView.h"

#import "Masonry.h"

#import "Coding_NetAPIManager.h"
#import "User.h"

@interface ViewController ()
{
    EaseGitButtonsView * gitBtnView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.myLogin = [[Login alloc] init];
    self.myLogin.email = @"18511372814";
    self.myLogin.password = @"Lbk123456";
    self.myLogin.remember_me = @1;
    
    
    [[Coding_NetAPIManager sharedManager] request_Login_WithPath:[self.myLogin toPath] Params:[self.myLogin toParams] andBlock:^(User* loginedUser, NSError *error) {
        
        
        if (loginedUser) {
            
            NSLog(@"TTTTTTTT %@",loginedUser.name);
            
        }else{
          
        }
        
    }]; 
    
    
    
    
    Project * pro = [[Project alloc] init];
    pro.backend_project_path = @"/user/GoldWater/project/classify";
    
        pro.created_at = @"1458982491000";
        pro.current_user_role = @"owner";
        pro.current_user_role_id = @100;
        pro.fork_count = @"1";
        pro.forked = @1;

        pro.icon = @"/static/project_icon/scenery-9.png";
        pro.id = @315704;
        pro.is_public = @"1";
        pro.name = @"classify";
        pro.owner = ({
        User * user = [User new];
        user.avatar = @"/static/fruit_avatar/Fruit-1.png";
        user.birthday = @"";
        user.company = @"";
        user.created_at = @"1458981025000";
        user.fans_count = @0;
        user.follow = @"0";
        user.followed = @0;
        user.follows_count = @"0";
        user.global_key = @"GoldWater";
        user.id = @195131;
        user.introduction = @"";
        user.job = @"0";
        user.last_activity_at = @"1460100871106";
        user.last_logined_at = @"1460014643000";
        user.location = @"";
        user.name = @"GoldWater";
        user.path = @"/u/GoldWater";
        user.points_left = @0;
        user.sex = @"2";
        user.slogan = @"";
        user.status = @1;
        user.tags_str = @"";
        user.tweets_count = @0;
        user.updated_at = @"1458981025000";
        user;
    });
    
            
            
        pro.owner_id = @195131;
        pro.owner_user_name = @"<a href=\"https://coding.net/u/GoldWater\">GoldWater</a>";
        pro.owner_user_name = @"GoldWater";
        pro.parent_depot_path = @"cleaner/classify";
        pro.pin = @0;
        pro.project_path = @"/u/GoldWater/p/classify";
        pro.recommended = @0;
        pro.star_count = @1;
        pro.stared = @1;
        pro.type = @1;
        pro.un_read_activities_count = @0;
        pro.updated_at = @"1458982491000";
        pro.watch_count = @0;
        pro.watched = @0;
    
    
    
    
    __weak typeof(self) weakSelf = self;
    gitBtnView = [EaseGitButtonsView new];
    gitBtnView.gitButtonClickedBlock = ^(NSInteger index,EaseGitButtonPosition position){
        
        [weakSelf actionWithGitbtnIndex:index];
        
    };
    
    [self.view addSubview:gitBtnView];
    
    
    [gitBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    
    gitBtnView.curProject = pro;
    self.myProject = pro;
    
    
}


-(void)actionWithGitbtnIndex:(NSInteger)index{
    
    
    
    __weak typeof(self) weakSelf = self;
    switch (index) {
        case 0:
        {
            if (_myProject.isStaring == NO) {
                
                [[Coding_NetAPIManager sharedManager] request_StarProject:_myProject andBlock:^(id data, NSError *error) {
                    
                    NSLog(@"%@",data);
                    
                    [weakSelf refreshGitButtonsView];
                }];
                
            }
        }
            break;

        case 1:
        {
            
            if (_myProject.isWatching == NO) {
                [[Coding_NetAPIManager sharedManager] request_WatchProject:_myProject andBlock:^(id data, NSError *error) {
                
                    NSLog(@"%@",data);
                    [weakSelf refreshGitButtonsView];
                    
                }];
            }
            
            
        }
            break;

            
        default:
        {
            
            [[Coding_NetAPIManager sharedManager] request_ForkProject:_myProject andBlock:^(id data, NSError *error) {
               
                [weakSelf refreshGitButtonsView];
                
                
                
                if (data) {
                    
                    
                    NSLog(@"%@",data);
                    
                }
                
            }];
            
        }
            break;
    }
    
    
    
    
}


- (void)refreshGitButtonsView{
    gitBtnView.curProject = self.myProject;
    CGFloat gitButtonsViewHeight = 0;
    if (self.myProject.is_public.boolValue) {
        gitButtonsViewHeight = CGRectGetHeight(gitBtnView.frame) - 1;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
