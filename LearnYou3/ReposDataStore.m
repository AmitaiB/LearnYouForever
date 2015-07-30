//
//  ReposDataStore.m
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ReposDataStore.h"
#import "GithubAPIClient.h"
#import "GithubRepository.h"

@implementation ReposDataStore
+ (instancetype)sharedDataStore {
    static ReposDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[ReposDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _repositories=[NSMutableArray new];
    }
    return self;
}
-(void)getRepositoriesWithCompletion:(void (^)(BOOL))completionBlock
{
    [GithubAPIClient getRepositoriesWithCompletion:^(NSArray *repoDictionaries) {
        for (NSDictionary *repoDictionary in repoDictionaries) {
            [self.repositories addObject:[GithubRepository repoFromDictionary:repoDictionary]];
        }
        completionBlock(YES);
    }];
}

-(void)toggleStarForRepo:(GithubRepository *)repo CompletionBlock:(void (^)(BOOL))completionBlock
{
    [GithubAPIClient checkIfRepoIsStarredWithFullName:repo.fullName CompletionBlock:^(BOOL starred) {
        
        NSLog(@"ASDF");
        if (starred) {
            [GithubAPIClient unstarRepoWithFullName:repo.fullName CompletionBlock:^{
                completionBlock(NO);
            }];
        } else
        {
            [GithubAPIClient starRepoWithFullName:repo.fullName CompletionBlock:^{
                completionBlock(YES);
            }];
        }
    }];
}
@end
