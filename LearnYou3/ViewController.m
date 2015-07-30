//
//  ViewController.m
//  LearnYou3
//
//  Created by Omar El-Fanek on 7/29/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)doneButtonTapped:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = @"Loading...";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Notify this instance of the view controller and call method
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationOpenedForURL:) name:@"ApplicationOpenedForURL" object:nil];
    
    
}

-(NSString *)firstValueForQueryItemNamed: (NSString *)name inURL:(NSURL *)url{
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:nil];
    NSArray *queryItems = urlComponents.queryItems;
    
    for (NSURLQueryItem *queryItem in queryItems){
        if([queryItem.name isEqualToString:name]){
            return queryItem.value;
        }
    }
    return nil;
}



-(void)handleApplicationOpenedForURL:(NSNotification *)notification{
    // Naming: without handle, the name feels more like a URL
    
    
    NSLog(@"Does this get called????!");
    
    NSURL *url = notification.userInfo[@"url"];
    
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationOpenedForURL" object:nil userInfo:@{ @"url":url}];
    
    
    NSString *code = [self firstValueForQueryItemNamed:@"code" inURL:url];
    NSLog (@"Opened from URL %@", url);
    
    
    NSURL *baseURL = [NSURL URLWithString:@"https://github.com/"];
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:@"cdd79b714788bbf55a89"
                                      secret:@"c59bd40f72e6602d4aab31a1d691f70e02374f03"];
    
    OAuth2Manager.useHTTPBasicAuthentication = NO;
    
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/login/oauth/access_token" code:code redirectURI:@"" success:^(AFOAuthCredential *credential) {
        NSLog (@"Oauth successful: %@", credential);
        
        [AFOAuthCredential storeCredential:credential
                            withIdentifier:@"githubAuthentication"];
        
        
        [self updateNameLabel];
        
        
    } failure:^(NSError *error) {
        NSLog (@"Oauth unsuccessful: %@", error);
        
    }];
    
    
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ApplicationOpenedForURL" object:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTapped:(id)sender {
    
    // OAuth:
    // The user does not want to give an app their password.
    // Instead, they sign in to Github through Safai and are
    // redirected back to our app.
    
    // OAuth acts as the middle man between your app and
    // an external service such as Github, Facebook, Twitter
    // using a personalized access key.
    
    // Access keys are unique per user and per application.
    
    // Scoping:
    // Ask for specific permissions when accessing a users
    // information. (ex) Contact info, Public profile, etc.
    
    // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- //
    
    // GOAL:
    // Send user to Github URL in Safari.
    // Wait for response
    // Use AFOauthManager to get the access token.
    
    NSMutableString *authURLString = [@"https://github.com/login/oauth/authorize" mutableCopy];
    [authURLString appendString:@"?client_id=cdd79b714788bbf55a89"];
    [authURLString appendString:@"&redirect_uri=my-github-app://oauth"];
    
    NSURL *url = [NSURL URLWithString:authURLString];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

- (IBAction)githubButtonTapped:(id)sender {
    NSMutableString *authURLString = [@"https://github.com/login/oauth/authorize" mutableCopy];
    [authURLString appendString:@"?client_id=cdd79b714788bbf55a89"];
    [authURLString appendString:@"&redirect_uri=my-github-app://oauth"];
    
    NSURL *url = [NSURL URLWithString:authURLString];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (void)updateNameLabel {
    
    AFOAuthCredential *credential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:@"githubAuthentication"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];
    
    [manager GET:@"https://api.github.com/user" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog (@"success, %@", responseObject);
        
        NSDictionary *userDictionary = responseObject;
        
        self.nameLabel.text = userDictionary[@"login"];
        self.nameLabel.alpha = 1;
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog (@"Failure %@", error);
    }];
}

-(void) doneButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
