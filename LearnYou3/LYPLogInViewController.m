//
//  LYPLogInViewController.m
//  LearnYou3
//
//  Created by Amitai Blickstein on 7/28/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "LYPLogInViewController.h"

@interface LYPLogInViewController () <PFLogInViewControllerDelegate>

@end

@implementation LYPLogInViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PFLogInViewController *loginVC = [PFLogInViewController new];
    loginVC.delegate = self;
    
    [self presentViewController:loginVC animated:YES completion:nil];
    

}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user {
    
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
