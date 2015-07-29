//
//  LYPNavigationController.m
//  LearnYou2
//
//  Created by Amitai Blickstein on 7/27/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LYPNavigationController.h"
#import <Parse.h>

@interface LYPNavigationController ()

@end

@implementation LYPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [PFUser logOut];
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"nav→MasterSegueID" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"nav→LogInSegueID" sender:nil];
    }
    
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
