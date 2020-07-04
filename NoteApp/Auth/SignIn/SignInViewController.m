//
//  SignInViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "SignInViewController.h"
#import "Utilities.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[Utilities styleFilledButton:_signInButton];
}

- (IBAction)signInAction:(id)sender {

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
