//
//  LYPLogInViewController.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 7/28/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LYPLogInViewController.h"
#import <Parse.h>

@interface LYPLogInViewController () <PFLogInViewControllerDelegate>

@end

@implementation LYPLogInViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [PFUser logOut];
    PFLogInViewController *loginVC = [PFLogInViewController new];
    loginVC.delegate = self;
    if (![PFUser currentUser]) {
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"logInToMasterSegueID" sender:nil];
    }
    

}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user {
        NSLog(@"We logged in! And know it!");
    [logInController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"We'll see ourselves out, thank you");
    }];
}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didFailToLogInWithError:(nullable NSError *)error {
    NSLog(@"We failed! With an error: %@", error);
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
