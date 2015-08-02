//
//  LY3GithubAPIClient.h
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/2/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LY3GithubAPIClient : NSObject

+(void)getOrgMembershipWithCompletion:(void (^)(NSArray *repos))completionBlock forOrg:(NSString*)orgName;
+(void)getRepositoriesWithCompletion:(void (^)(NSArray *repos))completionBlock forOrg:(NSString*)orgName;
+(void)getRepositoriesWithCompletion:(void (^)(NSArray *repos))completionBlock forUser:(NSString*)userName;
+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock forkedFromRepo:(NSString *)repoFullName;


@end
