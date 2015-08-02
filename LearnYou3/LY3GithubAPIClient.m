//
//  LY3GithubAPIClient.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/2/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//
/**
 *  sorry for the LY2 and LY3 confusion. We'll have to refactor this...
 */
#import "LY3GithubAPIClient.h"
#import "LY2Constants.h"
#import <AFNetworking.h>

@implementation LY3GithubAPIClient
NSString *const GITHUB_API_baseURL = @"https://api.github.com";
NSDictionary * defaultParams; //??? How could I implement this?

+(void)getOrgMembershipWithCompletion:(void (^)(NSArray *))completionBlock forOrg:(NSString *)orgName {
    NSString *getOrgMembershipURL = [NSString stringWithFormat:@"%@/orgs/%@/members?", GITHUB_API_baseURL, orgName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100",
                             @"role"            : @"all"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getOrgMembershipURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail: %@", error.localizedDescription);
         }];
}

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock forOrg:(NSString *)orgName {
    NSString *getOrgReposURL = [NSString stringWithFormat:@"%@/orgs/%@/repos?", GITHUB_API_baseURL, orgName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getOrgReposURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail: %@", error.localizedDescription);
         }];
}


+(void)getRepositoriesWithCompletion:(void (^)(NSArray *repos))completionBlock forUser:(NSString*)userName {
    NSString *getUserReposURL = [NSString stringWithFormat:@"%@/users/%@/repos?", GITHUB_API_baseURL, userName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getUserReposURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail: %@", error.localizedDescription);
         }];
}

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock forkedFromRepo:(NSString *)repoFullName {
    NSString *getRepoForksURL = [NSString stringWithFormat:@"%@/repos/%@/forks", GITHUB_API_baseURL, repoFullName]; //Fullname = owner|org : repoName, e.g., "octocat/helloWorld"
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getRepoForksURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail: %@", error.localizedDescription);
         }];
}



@end
