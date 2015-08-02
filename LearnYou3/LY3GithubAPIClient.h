//
//  LY3GithubAPIClient.h
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/2/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LY3GithubAPIClient : NSObject

+(void)getMembershipforOrg:(NSString*)orgName WithCompletion:(void (^)(NSArray *repos))completionBlock;
+(void)getRepositoriesforOrg:(NSString*)orgName WithCompletion:(void (^)(NSArray *repos))completionBlock;
+(void)getRepositoriesforUser:(NSString*)userName WithCompletion:(void (^)(NSArray *repos))completionBlock;
+(void)getCurrentUserRepositoriesWithCompletion:(void (^)(NSArray *repos))completionBlock;
+(void)getRepositoriesForkedFromParentRepo:(NSString *)repoFullName WithCompletion:(void (^)(NSArray *))completionBlock;


@end
