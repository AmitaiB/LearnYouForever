//
//  LY3RandomOctocatAPIClient.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/3/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LY3RandomOctocatAPIClient.h"
#import "LY2Constants.h"
#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@interface LY3RandomOctocatAPIClient()
@property (nonatomic, strong) NSMutableArray *octocatURLs;
@end

@implementation LY3RandomOctocatAPIClient

+(void)populateOctocatURLArrayWithCompletion:(void (^)(NSURLSessionDataTask *task, NSArray *octocats))completionBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"_apikey" : IMPORT_IO_API_KEY};
    
    [manager GET:OCTOCAT_API_URL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             completionBlock(task, responseObject);
             NSLog(@"Inside the populate octocat arrays success block");
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Octocat failure with error: %@", error);
         }];
}

+(void)getOctocatImageFromURL:(NSString *)octocatURL WithCompletion:(void (^)(NSURLSessionDataTask *, NSArray *))completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"_apikey" : IMPORT_IO_API_KEY};
    
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
