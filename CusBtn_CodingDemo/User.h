//
//  User.h
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Common.h"


@interface User : NSObject



@property(readwrite,nonatomic,strong)NSString *avatar,*name,*global_key,*path,*slogan,*company,*tags_str,*tags,*location,*job_str,*job,*email,*birthday,*pinyinName;
@property(readwrite,nonatomic,strong)NSString *curPassword, *resetPassword, *resetPasswordConfirm,  *phone, *introduction;
@property(readwrite,nonatomic,strong)NSNumber   *id,    *sex,   *follow,    *followed,  *fans_count,    *follows_count, *tweets_count,  *status,    *points_left,   *email_validation,  *is_phone_validated;
@property(readwrite,nonatomic,strong)NSDate *created_at, *last_logined_at, *last_activity_at, *updated_at;










@end
