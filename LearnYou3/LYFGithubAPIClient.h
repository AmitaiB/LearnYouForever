//
//  LY3GithubAPIClient.h
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/2/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYFGithubAPIClient : NSObject

+(void)requestMembershipforOrg:(NSString*)orgName options:(NSUInteger)LY_HTTPRequestType pagination:(NSUInteger)totalPages WithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *repos))completionBlock;
+(void)requestRepositoriesforOrg:(NSString*)orgName options:(NSUInteger)LY_HTTPRequestType WithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *repos))completionBlock;
+(void)requestRepositoriesforUser:(NSString*)userName options:(NSUInteger)LY_HTTPRequestType WithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *repos))completionBlock;
+(void)requestCurrentUserRepositoriesWithOptions:(NSUInteger)LY_HTTPRequestType WithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *repos))completionBlock;
+(void)requestRepositoriesForkedFromParentRepo:(NSString *)repoFullName options:(NSUInteger)LY_HTTPRequestType WithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *repos))completionBlock;

+(NSUInteger)paginationFromHeaderInDataTask:(NSURLSessionDataTask*)task;

@end
