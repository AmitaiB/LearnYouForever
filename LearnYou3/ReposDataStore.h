//
//  ReposDataStore.h
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GithubRepository;
@interface ReposDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *repositories;

+ (instancetype)sharedDataStore;

- (void)getRepositoriesWithCompletion:(void (^)(BOOL success))completionBlock;
- (void)toggleStarForRepo:(GithubRepository *)repo CompletionBlock:(void(^)(BOOL starred))completionBlock;

@end
