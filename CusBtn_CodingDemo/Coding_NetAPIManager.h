//
//  Coding_NetAPIManager.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-30.
//  Copyright (c) 2014年 Coding. All rights reserved.
//


#import "CodingNetAPIClient.h"

@class Project;

typedef NS_ENUM(NSUInteger, VerifyType){
    VerifyTypeUnknow = 0,
    VerifyTypePassword,
    VerifyTypeTotp,
};

typedef NS_ENUM(NSInteger, PurposeType) {
    PurposeToRegister = 0,
    PurposeToPasswordActivate,
    PurposeToPasswordReset
};

@interface Coding_NetAPIManager : NSObject
+ (instancetype)sharedManager;



- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError *error))block;

- (void)request_StarProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block;

- (void)request_WatchProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block;

- (void)request_ForkProject:(Project *)project andBlock:(void (^)(id data, NSError *error))block;


@end
