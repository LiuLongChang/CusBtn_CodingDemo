//
//  Coding_NetAPIManager.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-30.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "Coding_NetAPIManager.h"
#import "User.h"
#import "NSObject+ObjectMap.h"
#import "Project.h"

@implementation Coding_NetAPIManager
+ (instancetype)sharedManager {
    static Coding_NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
	dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
	return shared_manager;
}








- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        
        
        
        
        if (resultData) {
            [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"api/user/unread-count" withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data_check, NSError *error_check) {//检查当前账号未设置邮箱和GK
                if (error_check.userInfo[@"msg"][@"user_need_activate"]) {
                    block(nil, error_check);
                }else{
                    
                    User *curLoginUser = [NSObject objectOfClass:@"User" fromJSON:resultData];
                    if (curLoginUser) {
                        [Login doLogin:resultData];
                    }
                    block(curLoginUser, nil);
                }
            }];
        }else{
            block(nil, error);
        }
    }];
}




#pragma mark Git Related
- (void)request_StarProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block{
    NSString *path = [NSString stringWithFormat:@"api/user/%@/project/%@/%@", project.owner_user_name, project.name, project.stared.boolValue? @"unstar": @"star"];
    
    
    
    
    project.isStaring = YES;
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        
        
        project.isStaring = NO;
        if (data) {
            
            project.stared = [NSNumber numberWithBool:!project.stared.boolValue];
            project.star_count = [NSNumber numberWithInteger:project.star_count.integerValue + (project.stared.boolValue? 1: -1)];
            block(data, nil);
        }else{
            block(nil, error);
        }
        
        
    }];
}


- (void)request_WatchProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block{
    NSString *path = [NSString stringWithFormat:@"api/user/%@/project/%@/%@", project.owner_user_name, project.name, project.watched.boolValue? @"unwatch": @"watch"];
    project.isWatching = YES;
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        project.isWatching = NO;
        if (data) {
            
            project.watched = [NSNumber numberWithBool:!project.watched.boolValue];
            project.watch_count = [NSNumber numberWithInteger:project.watch_count.integerValue + (project.watched.boolValue? 1: -1)];
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_ForkProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block{
    NSString *path = [NSString stringWithFormat:@"api/user/%@/project/%@/git/fork", project.owner_user_name, project.name];
    
    
    
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        //        此处得到的 data 是一个GitPro，需要在请求一次Pro的详细信息
        if (data) {
            
            project.forked = [NSNumber numberWithBool:!project.forked.boolValue];
            project.fork_count = [NSNumber numberWithInteger:project.fork_count.integerValue +1];
            
            Project *forkedPro = [[Project alloc] init];
            forkedPro.owner_user_name = project.owner_user_name;
            forkedPro.name = project.name;
            
            [[Coding_NetAPIManager sharedManager] request_ProjectDetail_WithObj:forkedPro andBlock:^(id data, NSError *error) {
                
                if (data) {
                    block(data, nil);
                }else{
                    block(data, error);
                }
            }];
            
        }else{
            block(nil, error);
        }
    }];
}


- (void)request_ProjectDetail_WithObj:(Project *)project andBlock:(void (^)(id data, NSError *error))block{
    project.isLoadingDetail = YES;
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:[project toDetailPath] withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        project.isLoadingDetail = NO;
        
        if (data) {
            id resultData = [data valueForKeyPath:@"data"];
            Project *resultA = [NSObject objectOfClass:@"Project" fromJSON:resultData];
            block(data, nil);
        }else{
            block(data, error);
        }
    }];
}



@end