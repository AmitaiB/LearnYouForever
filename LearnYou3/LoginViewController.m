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
#import "LY3RandomOctocatAPIClient.h"
#import <Parse.h>

@interface LoginViewController ()
- (IBAction)githubButtonWasTapped:(id)sender;
- (IBAction)invisibleButtonTapped:(id)sender;
@property (nonatomic, strong) NSMutableArray *octocatURLsArray;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Viewdidload called");
    // Do any additional setup after loading the view.
    
   
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSLog(@"View Will appear!!");
    
    
    
    if ([AFOAuthCredential retrieveCredentialWithIdentifier:@"githubOAuthToken"]) {
        
        NSLog(@"In if statement of retrieveCredential");
            [self performSegueWithIdentifier:@"logInToMasterSegueID" sender:nil];
    }
    
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
    
    NSURL *url = notification.userInfo[@"url"];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationOpenedForURL" object:nil userInfo:@{@"url":url}];
    
    NSString *code = [self firstValueForQueryItemNamed:@"code" inURL:url];
    NSLog(@"Opened from URL %@", url);
    
}

    ///AFOAuth2Manager stores passwords etc. in the Keychain.
- (IBAction)githubButtonWasTapped:(id)sender {
//    AFOAuth2Manager *oAuthManager = [self githubOAuth2ManagerCreate];
    
    GitHubOAuthController *oAuthController = [[GitHubOAuthController alloc] initWithClientId:GITHUB_CLIENT_ID
                                                                                clientSecret:GITHIB_CLIENT_SECRET
                                                                                       scope:@"repo"
                                                                                     success:^(NSString *accessToken, NSDictionary *raw) {
                                                                                         NSLog(@"access token: %@ \nraw: %@", accessToken, raw);
        AFOAuthCredential *credential = [AFOAuthCredential credentialWithOAuthToken:raw[@"access_token"]
                                                                          tokenType:raw[@"token_type"]];
        [AFOAuthCredential storeCredential:credential withIdentifier:@"githubOAuthToken"];

                                                                                     } failure:nil];
    
    [oAuthController showModalFromController:self];
}

- (IBAction)invisibleButtonTapped:(id)sender {
    
        PFObject *octocatURLsPF = [PFObject objectWithClassName:@"octodex"];
//    }
//
//    if (!self.octocatURLs.count) {
        [LY3RandomOctocatAPIClient populateOctocatURLArrayWithCompletion:^(NSURLSessionDataTask *task, NSDictionary *octodex) {
            [self populateURLArrayFromResponse:octodex];
//            NSLog(@"Inside the completion block: octodex (response object): %@", [octodex description]);
            octocatURLsPF[@"octocatURLs"] = self.octocatURLsArray;
            [octocatURLsPF saveInBackground];
        }];
//            NSMutableArray *octoURLs = [NSMutableArray new];
//            for (NSDictionary *octoDict in octodex[@"results"]) {
//                [octoURLs addObject:octoDict[@"preview_image"]];
//            }
//            octocatURLs[@"octodexArray"] = octoURLs;
//            [octocatURLs pinInBackground];
//            NSLog(@"octoURLs: %@!", [octoURLs description]);
//    } else {
//        PFQuery *query = [PFQuery queryWithClassName:@"OctocatURLs"];
//        PFObject *octocatURLs = query.fromPin;
//        NSLog(@"octocatURLs Parse object: %@", octocatURLs);
//    }
}

-(void)populateURLArrayFromResponse:(NSDictionary*)response {
//    NSLog(@"Inside the populatemethod: response (response object): %@", [response description]);
    NSMutableArray *temp = [NSMutableArray new];
    for (NSDictionary *octoDict in response[@"results"]) {
        NSLog(@"octoDict[@\"preview_image\"] is equal to: %@", octoDict[@"preview_image"]);
        [temp addObject:octoDict[@"preview_image"]];
    }
    self.octocatURLsArray = temp;
    NSLog(@"self.octocatURLsArray in populateURLArrayFromResponse:\n%@", [self.octocatURLsArray description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
