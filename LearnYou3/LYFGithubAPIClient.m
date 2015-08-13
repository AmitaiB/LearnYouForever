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
#import "LYFGithubAPIClient.h"
#import "LYFConstants_v2.h"
#import <Regexer.h>
#import <AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@implementation LYFGithubAPIClient
NSString *const GITHUB_API_baseURL = @"https://api.github.com";

NSDictionary * defaultParams; //??? How could I implement this?

NS_ENUM(NSUInteger, LY_HTTPRequestOption) {
    LY_HEADRequestType,
    LY_GETRequestType,
    LY_PUTRequestType,
    LY_DELETERequestType
};

    //Get the org's repos, and pass the info on to the completion block.
+(void)requestMembershipforOrg:(NSString *)orgName options:(NSUInteger)LY_HTTPRequestType pagination:(NSUInteger)totalPages WithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    
    NSString *getOrgMembershipURL = [NSString stringWithFormat:@"%@/orgs/%@/members?", GITHUB_API_baseURL, orgName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100",
                             @"role"            : @"all"};
    
    AFOAuthCredential *sessionToken = [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:sessionToken];
    
    if (LY_HTTPRequestType == LY_HEADRequestType) {
        [manager HEAD:getOrgMembershipURL
           parameters:params
              success:^(NSURLSessionDataTask *task) {
                  completionBlock(nil, @[@([self paginationFromHeaderInDataTask:task])]);
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"Fail line 50: %@", error.localizedDescription);
              }];
    } else if (LY_HTTPRequestType == LY_GETRequestType) {
        
        
        [manager GET:getOrgMembershipURL
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 completionBlock(task, responseObject);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"Fail line 34: %@", error.localizedDescription);
             }];
        
    }
    
    
}

+(void)requestRepositoriesforOrg:(NSString *)orgName WithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    NSString *getOrgReposURL = [NSString stringWithFormat:@"%@/orgs/%@/repos?", GITHUB_API_baseURL, orgName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFOAuthCredential *sessionToken = [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:sessionToken];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getOrgReposURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail line 52: %@", error.localizedDescription);
         }];
}

+(void)requestRepositoriesforUser:(NSString *)userName WithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    NSString *getUserReposURL = [NSString stringWithFormat:@"%@/users/%@/repos?", GITHUB_API_baseURL, userName];
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFOAuthCredential *sessionToken = [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:sessionToken];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getUserReposURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail line 71: %@", error.localizedDescription);
         }];
}

+(void)requestCurrentUserRepositoriesWithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    NSString *getCurrentUserReposURL = [NSString stringWithFormat:@"%@/user/repos", GITHUB_API_baseURL];
    
//    AFOAuth2Manager *authManager = [AFOAuth2Manager alloc] initWithBaseURL:<#(NSURL *)#> clientID:<#(NSString *)#> secret:<#(NSString *)#>
    
    NSDictionary *params = @{@"client_id" : GITHUB_CLIENT_ID,
                             @"client_secret" : GITHIB_CLIENT_SECRET,
                             @"per_page" : @"100"};
    
    AFOAuthCredential *sessionToken = [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:sessionToken];
    
    [manager GET:getCurrentUserReposURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
//             NSArray *temp = (NSArray*)responseObject;
//             NSLog(@"%@", [temp description]);
             completionBlock(task, responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail line 90: %@", error.localizedDescription);
         }];
}

+(void)requestRepositoriesForkedFromParentRepo:(NSString *)repoFullName WithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    NSString *getRepoForksURL = [NSString stringWithFormat:@"%@/repos/%@/forks", GITHUB_API_baseURL, repoFullName]; //Fullname = owner|org : repoName, e.g., "octocat/helloWorld"
    NSDictionary *params = @{@"client_id"       : GITHUB_CLIENT_ID,
                             @"client_secret"   : GITHIB_CLIENT_SECRET,
                             @"per_page"        : @"100"};
    
    AFOAuthCredential *sessionToken = [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:sessionToken];
    
        //Get the org's repos, and pass the info on to the completion block.
    [manager GET:getRepoForksURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Fail line 108: %@", error.localizedDescription);
         }];
}

#pragma mark Helper

+(NSUInteger)paginationFromHeaderInDataTask:(NSURLSessionDataTask *)task {
    DBLG
    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response; //cast because we know it was an HTTP call.
    NSString *linkHeaderText = response.allHeaderFields[@"Link"];
    NSString *rxPattern = @"\\d+(?=>; rel=\"last\")"; //see Github docs on pagination for details.
    NSString *paginationString = [linkHeaderText rx_textsForMatchesWithPattern:rxPattern][0];
    
        //CLEAN: can remove when debugging is over
    NSLog(@"NSURLResponse digging: %@", [[(NSHTTPURLResponse*)task.response allHeaderFields] description]);
    NSLog(@"link header tedxt: %@", linkHeaderText);
    NSLog(@"pagination string: %@", paginationString);
    
    return [paginationString integerValue];
}


@end
