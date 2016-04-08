//
//  Project.m
//  CusBtn_CodingDemo
//
//  Created by langyue on 16/4/8.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "Project.h"
#import "User.h"


@implementation Project

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isStaring = _isWatching = _isLoadingMember = _isLoadingDetail = NO;
        _recommended = [NSNumber numberWithInteger:0];
    }
    return self;
}

-(id)copyWithZone:(NSZone*)zone {
    Project *person = [[[self class] allocWithZone:zone] init];
    person.icon = [_icon copy];
    person.name = [_name copy];
    person.owner_user_name = [_owner_user_name copy];
    person.backend_project_path = [_backend_project_path copy];
    person.full_name = [_full_name copy];
    person.description_mine = [_description_mine copy];
    person.path = [_path copy];
    person.current_user_role = [_current_user_role copy];
    person.id = [_id copy];
    person.owner_id = [_owner_id copy];
    person.is_public = [_is_public copy];
    person.un_read_activities_count = [_un_read_activities_count copy];
    person.done = [_done copy];
    person.processing = [_processing copy];
    person.star_count = [_star_count copy];
    person.stared = [_stared copy];
    person.watch_count = [_watch_count copy];
    person.watched = [_watched copy];
    person.fork_count = [_fork_count copy];
    person.recommended = [_recommended copy];
    person.current_user_role_id = [_current_user_role_id copy];
    person.isStaring = _isStaring;
    person.isWatching = _isWatching;
    person.isLoadingMember = _isLoadingMember;
    person.isLoadingMember = _isLoadingMember;
    person.created_at = [_created_at copy];
    person.updated_at = [_updated_at copy];
    person.project_path=[_project_path copy];
    person.owner=[_owner copy];
    return person;
}

-(void)setFull_name:(NSString *)full_name{
    
    
    _full_name = full_name;
    NSArray * components = [_full_name componentsSeparatedByString:@"/"];
    if (components.count == 2) {
        if (!_owner_user_name) {
            _owner_user_name = components[0];
        }
        if (_name) {
            _name = components[1];
        }
    }
    
}




+(Project*)project_All{
    Project * pro = [[Project alloc] init];
    pro.id = [NSNumber numberWithInteger:-1];
    return pro;
}

+(Project*)project_FeedBack{
    Project * pro = [[Project alloc] init];
    pro.id = [NSNumber numberWithInteger:38894];
    pro.is_public = [NSNumber numberWithBool:YES];
    return pro;
}


-(NSString*)toProjectPath{
    return @"api/Project";
}



-(NSDictionary*)toCreateParams{
    
    NSString * type;
    if ([self.is_public isEqual:@YES]) {
        type = @"1";
    }else{
        type = @"2";
    }
    return @{@"name":self.name,@"description":self.description_mine,@"type":type,@"gitEnabled":@"true",@"gitReadmeEnabled": _gitReadmeEnabled.boolValue? @"true": @"false",
             @"gitIgnore":@"no",
             @"gitLicense":@"no",
             //             @"importFrom":@"no",
             @"vcsType":@"git"};
}



-(NSString*)toUpdatePath{
    return [self toProjectPath];
}


-(NSDictionary *)toUpdateParams{
    return @{@"name":self.name,
             @"description":self.description_mine,
             @"id":self.id
             //             @"default_branch":[NSNull null]
             };
}


- (NSString *)toDetailPath{
    return [NSString stringWithFormat:@"api/user/%@/project/%@", self.owner_user_name, self.name];
}



//{
//    code = 0;
//    data =     {
//        "backend_project_path" = "/user/GoldWater/project/classify";
//        "created_at" = 1458982491000;
//        "current_user_role" = owner;
//        "current_user_role_id" = 100;
//        "depot_path" = "/u/GoldWater/p/classify/git";
//        description = "libsvm  classify";
//        "fork_count" = 1;
//        forked = 1;
//        "git_url" = "git://git.coding.net/GoldWater/classify.git";
//        groupId = 0;
//        "https_url" = "https://git.coding.net/GoldWater/classify.git";
//        icon = "/static/project_icon/scenery-9.png";
//        id = 315704;
//        "is_public" = 1;
//        "last_updated" = 1460079989000;
//        "max_member" = 10;
//        name = classify;
//        owner =         {
//            avatar = "/static/fruit_avatar/Fruit-1.png";
//            birthday = "";
//            company = "";
//            "created_at" = 1458981025000;
//            "fans_count" = 0;
//            follow = 0;
//            followed = 0;
//            "follows_count" = 0;
//            "global_key" = GoldWater;
//            gravatar = "https://dn-coding-net-avatar.qbox.me/1528d7ea-1f6b-4432-b2e7-dca367dbb6e4.jpg";
//            id = 195131;
//            introduction = "";
//            "is_member" = 0;
//            job = 0;
//            "last_activity_at" = 1460100871106;
//            "last_logined_at" = 1460014643000;
//            lavatar = "/static/fruit_avatar/Fruit-1.png";
//            location = "";
//            name = GoldWater;
//            "name_pinyin" = "";
//            path = "/u/GoldWater";
//            "points_left" = 0;
//            sex = 2;
//            slogan = "";
//            status = 1;
//            tags = "";
//            "tags_str" = "";
//            "tweets_count" = 0;
//            "updated_at" = 1458981025000;
//        };
//        "owner_id" = 195131;
//        "owner_user_home" = "<a href=\"https://coding.net/u/GoldWater\">GoldWater</a>";
//        "owner_user_name" = GoldWater;
//        "owner_user_picture" = "/static/fruit_avatar/Fruit-1.png";
//        "parent_depot_path" = "cleaner/classify";
//        pin = 0;
//        plan = 1;
//        "project_path" = "/u/GoldWater/p/classify";
//        recommended = 0;
//        "ssh_url" = "git@git.coding.net:GoldWater/classify.git";
//        "star_count" = 1;
//        stared = 1;
//        status = 1;
//        "svn_url" = "svn+ssh://svn.coding.net/GoldWater/classify";
//        type = 1;
//        "un_read_activities_count" = 0;
//        "updated_at" = 1458982491000;
//        "watch_count" = 0;
//        watched = 0;
//    };
//}

@end
