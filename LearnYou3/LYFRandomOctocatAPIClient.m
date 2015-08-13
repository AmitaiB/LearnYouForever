//
//  LY3RandomOctocatAPIClient.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/3/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LYFRandomOctocatAPIClient.h"
#import "LYFConstants_v2.h"
#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@interface LYFRandomOctocatAPIClient()
@property (nonatomic, strong) NSMutableArray *octocatURLs;
@end

@implementation LYFRandomOctocatAPIClient

+(void)populateOctocatURLArrayWithCompletion:(void (^)(NSURLSessionDataTask *task, NSDictionary *octodex))completionBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"_apikey" : IMPORT_IO_API_KEY,
                             @"_input/webpage/url" : @"https%3A%2F%2Foctodex.github.com%2F", @"_user" : IMPORT_IO_USER_ID};
    
    [manager GET:OCTOCAT_API_URL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
             NSLog(@"Inside the populate octocat arrays success block");
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Octocat failure with error: %@", error);
         }];
}

+(void)getOctocatImageFromURL:(NSString *)octocatURL WithCompletion:(void (^)(NSURLSessionDataTask *task, UIImage *octocat))completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"_apikey" : IMPORT_IO_API_KEY,
                             @"_input/webpage/url" : @"https%3A%2F%2Foctodex.github.com%2F", @"_user" : IMPORT_IO_USER_ID};
    
    [manager GET:octocatURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
             NSLog(@"Inside the get octocatImage success block");
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Octocat Image failure with error: %@", error);
         }];
}

@end
