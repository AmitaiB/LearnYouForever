//
//  GithubRepository.m
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "GithubRepository.h"

@implementation GithubRepository

-(BOOL)isEqual:(id)object
{
    GithubRepository *repo2 = (GithubRepository *)object;
    NSString *urlA = [self.htmlURL absoluteString];
    NSString *urlB = [repo2.htmlURL absoluteString];
    return [repo2.repositoryID isEqualToString:self.repositoryID] && [repo2.fullName isEqualToString:repo2.fullName] && [urlA isEqualToString:urlB];
}

+(GithubRepository *)repoFromDictionary:(NSDictionary *)repoDictionary
{
    GithubRepository *repo = [[GithubRepository alloc] init];
    repo.repositoryID = [repoDictionary[@"id"] stringValue];
    repo.fullName=repoDictionary[@"full_name"];
    repo.htmlURL=[NSURL URLWithString:repoDictionary[@"html_url"]];
    return repo;
}

@end
