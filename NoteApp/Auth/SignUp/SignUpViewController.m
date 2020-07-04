//
//  SignUpViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "SignUpViewController.h"
#import "Utilities.h"
@import Firebase;

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[Utilities styleFilledButton:_signUpButton];
}

- (IBAction)signUpAction:(id)sender {
	if(![self validateAuth]) {
		return;
	} else {
		[self performSignUp];
	}
}

- (void)performSignUp {
	[[FIRAuth auth] createUserWithEmail:_emailTextField.text
							   password:_passwordTextField.text
							 completion:^(FIRAuthDataResult * _Nullable authResult,
										  NSError * _Nullable error) {
		if (error != nil) {
			[Utilities showAlert:error.localizedDescription viewController:self];
		} else {
			NSLog(@"user is: %@", authResult.user);
		}
	}];
}

- (BOOL)validateAuth {
	if (!([Utilities vaildateIsEmpty:_emailTextField.text] || [Utilities vaildateIsEmpty:_passwordTextField.text] || [Utilities vaildateIsEmpty:_confirmPasswordTextField.text])) {
		[Utilities showAlert:@"Please enter all fields." viewController:self];
		return false;
	}
	
	if (![Utilities validateEmailWithString:_emailTextField.text]) {
		[Utilities showAlert:@"Please enter vaild email." viewController:self];
		return false;
	}
	
	if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
		[Utilities showAlert:@"Password and confirm password are mismatched." viewController:self];
		return false;
	}
	return true;
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
