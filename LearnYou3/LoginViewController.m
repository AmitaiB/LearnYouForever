//
//  CPYLoginViewController.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>
#import "LY2Constants.h"
#import <GitHubOAuthController.h>

@interface LoginViewController ()
- (IBAction)githubButtonWasTapped:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
        //Notify this instance of the view controller and call method.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationOpenedForURL:) name:@"ApplicationOpenedForURL" object:nil];
}

-(NSString *)firstValueForQueryItemNamed:(NSString *)name inURL:(NSURL *)url {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:nil];
    NSArray *queryItems = urlComponents.queryItems;
    
        //Amitai added this so he could learn about what was going on...
    NSLog(@"queryItems is:\n%@", [queryItems description]);
    
    for (NSURLQueryItem *queryItem in queryItems) {
        if ([queryItem.name isEqualToString:name]) {
            return queryItem.value;
        }
    }
    return nil;
}


-(void)handleApplicationOpenedForURL:(NSNotification *)notification
{
        //Naming: without handle, the name feels more like a URL
    
    
    NSLog(@"Does this get called?????!");
    
    NSURL *url = notification.userInfo[@"url"];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationOpenedForURL" object:nil userInfo:@{@"url":url}];
    
    NSString *code = [self firstValueForQueryItemNamed:@"code" inURL:url];
    NSLog(@"Opened from URL %@", url);
    
    NSURL *baseURL = [NSURL URLWithString:@"https://github.com/"];
    AFOAuth2Manager *OAuth2Manager = [[AFOAuth2Manager alloc] initWithBaseURL:baseURL clientID:GITHUB_CLIENT_ID secret:GITHIB_CLIENT_SECRET];
}


- (IBAction)githubButtonWasTapped:(id)sender {
    GitHubOAuthController *oAuthController = [[GitHubOAuthController alloc] initWithClientId:GITHUB_CLIENT_ID
                                                                                clientSecret:GITHIB_CLIENT_SECRET
                                                                                       scope:@"repo"
                                                                                     success:^(NSString *accessToken, NSDictionary *raw) {
                                                                                         NSLog(@"access token: %@ \nraw: %@", accessToken, raw);
                                                                                     } failure:nil];
    
    [oAuthController showModalFromController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


