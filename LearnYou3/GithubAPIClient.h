//
//  GithubAPIClient.h
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubAPIClient : NSObject

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *repoDictionaries))completionBlock;
+(void)checkIfRepoIsStarredWithFullName:(NSString *)fullName CompletionBlock:(void (^)(BOOL starred))completionBlock;
+(void)starRepoWithFullName:(NSString *)fullName CompletionBlock:(void (^)(void))completionBlock;
+(void)unstarRepoWithFullName:(NSString *)fullName CompletionBlock:(void (^)(void))completionBlock;

@end
