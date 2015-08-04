//
//  LY3RandomOctocatAPIClient.h
//  LearnYou3
//
//  Created by Amitai Blickstein on 8/3/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LY3RandomOctocatAPIClient : NSObject

+(void)populateOctocatURLArrayWithCompletion:(void (^)(NSURLSessionDataTask *task, NSDictionary *octodex))completionBlock;

+(void)getOctocatImageFromURL:(NSString*)octocatURL WithCompletion:(void (^)(NSURLSessionDataTask *task, UIImage *octocat))completionBlock;


@end
