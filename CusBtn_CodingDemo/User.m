//
//  User.m
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "User.h"
#import "NSString+Common.h"

@implementation User



-(id)copyWithZone:(NSZone*)zone{
    User * user = [[[self class] allocWithZone:zone] init];
    user.avatar = [_avatar copy];
    user.name = [_name copy];
    user.global_key = [_global_key copy];
    user.path = [_path copy];
    user.slogan = [_slogan copy];
    user.company = [_company copy];
    user.tags_str = [_tags_str copy];
    user.tags = [_tags copy];
    user.location = [_location copy];
    user.job_str = [_job_str copy];
    user.job = [_job copy];
    user.email = [_email copy];
    user.birthday = [_birthday copy];
    user.pinyinName = [_pinyinName copy];
    user.curPassword = [_curPassword copy];
    user.resetPassword = [_resetPassword copy];
    user.resetPasswordConfirm = [_resetPasswordConfirm copy];
    user.phone = [_phone copy];
    user.introduction = [_introduction copy];
    user.id = [_id copy];
    user.sex = [_sex copy];
    user.followed = [_followed copy];
    user.fans_count = [_fans_count copy];
    user.follows_count = [_follows_count  copy];
    user.tweets_count = [_tweets_count copy];
    user.status = [_status copy];
    user.tweets_count = [_follows_count copy];
    user.last_logined_at = [_last_logined_at copy];
    user.created_at = [_created_at copy];
    user.updated_at = [_updated_at copy];
    user.email_validation = [_email_validation copy];
    return user;
}


+(User*)userWithGlobalKey:(NSString*)global_key{
    User * curUser = [[User alloc] init];
    curUser.global_key = global_key;
    return curUser;
}



-(BOOL)isSameToUser:(User*)user{
    if (!user) {
        return NO;
    }
    return (self.id && user.id && self.id.integerValue == user.id.integerValue) || (self.global_key && user.global_key && [self.global_key isEqualToString:user.global_key]);
}

-(NSString*)toUserInfoPath{
    return [NSString stringWithFormat:@"api/user/key/%@",_global_key];
}



-(NSString*)toResetPasswordPath{
    return @"api/user/updatePassword";
}



-(NSDictionary*)toResetPasswordParams{
    return @{@"current_password":[self.curPassword sha1Str]};
}







@end
