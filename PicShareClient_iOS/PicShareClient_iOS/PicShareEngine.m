//
//  PicShareEngine.m
//  PicShareClient_iOS
//
//  Created by 和光 缪 on 12-3-4.
//  Copyright (c) 2012年 Shanghai University. All rights reserved.
//

#import "PicShareEngine.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

NSString *picshareDomain = @"http://localhost:8000/";

@implementation PicShareEngine

@synthesize password = _password;
@synthesize username = _username;

static PicShareEngine *instance = NULL;

+(id)sharedEngine{
    @synchronized(self)
    {
        if (instance == NULL) {
            instance = [[PicShareEngine alloc]init];
        }
        return instance;
    }
}

-(NSArray *)getAllCategories
{
    [NSThread sleepForTimeInterval:1];
    NSURL *url = [NSURL URLWithString:[picshareDomain stringByAppendingFormat:@"api/category/get_all.json"]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *response = nil;
    if (!error) {
        response = [request responseString];
    }
    else {
        NSLog(@"error! %@",[error code]);
        //do something in ui
        return nil;
    }
    if (response != nil) {
        NSDictionary *dictFromJson = [response objectFromJSONString]; 
        NSArray *categoryDataArray = [dictFromJson objectForKey:@"categories"];
        NSMutableArray *resultArray = [[[NSMutableArray alloc]init]autorelease];
        for(NSDictionary *aCategoryData in categoryDataArray){
            Category *c = [[Category alloc]initWithJSONDict:aCategoryData];
            [resultArray addObject:c];
            [c release];
        }
        NSLog(@"result:%@",resultArray);
        return resultArray;
    }
    return nil;
}

-(NSArray *)getBoardsOfCategoryId:(NSInteger)categoryId
{
    return [self getBoardsOfCategoryId:categoryId page:1];
}

-(NSArray *)getBoardsOfCategoryId:(NSInteger)categoryId page:(NSInteger)page
{
    return [self getBoardsOfCategoryId:categoryId page:page countPerPage:10];
}

-(NSArray *)getBoardsOfCategoryId:(NSInteger)categoryId page:(NSInteger)page countPerPage:(NSInteger)count
{
    
    NSURL *url = [NSURL URLWithString:[picshareDomain stringByAppendingFormat:@"api/board/get_category_boards.json/page=%d&count=%d&category_id=%d",page,count,categoryId]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *response = nil;
    if (!error) {
        response = [request responseString];
    }
    else {
        NSLog(@"error! %@",[error code]);
        //do something in ui
        return nil;
    }
    if (response != nil) {
        NSLog(@"getBoardsOfCategoryId response:%@",response);
    }
    return nil;
}

-(void)dealloc{
    [_password release];
    [_username release];
    [super dealloc];
}

@end
