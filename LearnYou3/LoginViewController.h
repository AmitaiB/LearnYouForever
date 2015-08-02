//
//  CPYLoginViewController.h
//  LearnYou3
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GitHubOAuthController.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) GitHubOAuthController *oAuthController;

@end
