//
//  LY2Constants.h
//  LearnYou2
//
//  Created by Amitai Blickstein on 7/23/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LY2Constants : NSObject

//extern NSString * const PARSE_API_ID;
//extern NSString * const PARSE_CLIENT_KEY;
extern NSString * const GITHUB_PAC_TOKEN;
extern NSString * const GITHIB_CLIENT_SECRET;
extern NSString * const GITHUB_CLIENT_ID;
extern NSString * const REST_API_KEY;

@end

/**
 *  Scopes limit access for personal tokens. Read more about OAuth scopes.
repo   repo:status   repo_deployment  public_repo   delete_repo   user  user:email   user:follow   admin:org  write:org   read:org   admin:public_key  write:public_key   read:public_key   admin:repo_hook  write:repo_hook   read:repo_hook   admin:org_hook  gist notifications
 */
