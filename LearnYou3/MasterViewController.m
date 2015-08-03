//
//  MasterViewController.m
//  LearnYou2
//
//  Created by Amitai Blickstein on 7/23/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "LY3GithubAPIClient.h"
#import <Parse.h>

@interface MasterViewController () 

@property NSMutableArray *objects;
@property (nonatomic, strong) NSString *userName;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        //Our beautiful logout button.
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout"] style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    __block NSMutableArray *results = [NSMutableArray new];
    __block NSMutableArray *raw = [NSMutableArray new];
    __block NSUInteger pagination = 1;
    
    [LY3GithubAPIClient getCurrentUserRepositoriesWithCompletion:^(NSURLSessionDataTask *task, NSArray *repos) {
            //Populates an array with the repos requested.
        for (NSDictionary *repo in repos) {
            [results addObject:repo[@"full_name"]];
        }
NSLog(@"Inside currentUserRepos completion block -- Results: %@", [results description]);
        [self.tableView reloadData];
NSLog(@"Results is of length: %lu", (unsigned long)results.count);
        NSString *username = repos[0][@"owner"][@"login"];
        NSLog(@"userName: %@", username);
        
        NSLog(@"NSURLResponse digging: %@", [[(NSHTTPURLResponse*)task.response allHeaderFields] description]);
        
    }];
    self.objects = results;
    
}

- (void)logout:(id)sender {
    NSLog (@"Logout");
    
    [self githubLogout];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)githubLogout {
//    NSURL *baseURL = [NSURL URLWithString:@""];
//    AFOAuth2Manager *OAuth2Manager = [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
//                                                                     clientID:@""
//                                                                       secret:@""];
//    return OAuth2Manager;
    
    [AFOAuthCredential deleteCredentialWithIdentifier:@"githubOAuthToken"];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //Labs forked-not-pulled, and labs forked-and-pulled.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = self.objects[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
