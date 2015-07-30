//
//  GithubRepository.h
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubRepository : NSObject

///---------------------
/// @name Properties
///---------------------

/**
 *  `NSString` full name of repository. Comes from the "full_name" key
 */
@property (strong, nonatomic) NSString *fullName;

/**
 *  `NSURL` html URL of repository. Comes from the "html_url" key
 */
@property (strong, nonatomic) NSURL *htmlURL;

/**
 *  `NSString` repository ID. Comes from the "id" key
 */
@property (strong, nonatomic) NSString *repositoryID;

+(GithubRepository *)repoFromDictionary:(NSDictionary *)repoDictionary;

@end
