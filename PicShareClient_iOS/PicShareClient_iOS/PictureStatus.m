//
//  PictureStatus.m
//  PicShareClient_iOS
//
//  Created by 和光 缪 on 12-3-4.
//  Copyright (c) 2012年 Shanghai University. All rights reserved.
//

#import "PictureStatus.h"

@implementation PictureStatus

@synthesize location,via,psId,owner,boardId,picture,timestamp,pictureUrl,description,statusType,commentsCount;

-(id)initWithJSONDict:(NSDictionary *)data
{
    if (data == nil || (NSNull *)data == [NSNull null]) {
        [self release];
        return nil;
    }
    self = [super init];
    if (self) {
        location = [[data objectForKey:@"location"]copy];
        via = [[User alloc]initWithJSONDict:[data objectForKey:@"via"]];
        psId = [[data objectForKey:@"ps_id"]intValue];
        owner = [[User alloc]initWithJSONDict:[data objectForKey:@"owner"]];
        boardId = [[data objectForKey:@"board_id"]intValue];
        pictureUrl = [[data objectForKey:@"image"]copy];
        description = [[data objectForKey:@"description"]copy];
        statusType = [[data objectForKey:@"status_type"]intValue];
        commentsCount = [[data objectForKey:@"comments_count"]intValue];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        timestamp = [df dateFromString:[data objectForKey:@"timestamp"]];
        [df release];
    }
    return self;
}

- (void)dealloc
{
    [location release];
    [via release];
    [owner release];
    [pictureUrl release];
    [picture release];
    [timestamp release];
    [description release];
    [super dealloc];
}

-(NSString *)description
{
    NSString *str = [[[NSString alloc]initWithFormat:@"picture:%@",self.pictureUrl]autorelease];
    return str;
}

@end