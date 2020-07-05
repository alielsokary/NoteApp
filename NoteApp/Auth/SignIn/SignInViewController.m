//
//  SignInViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "SignInViewController.h"
#import "Utilities.h"
@import Firebase;

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

- (BOOL)validateAuth {
	if (!([Utilities vaildateIsEmpty:_emailTextField.text] || [Utilities vaildateIsEmpty:_passwordTextField.text])) {
		[Utilities showAlert:@"Please enter all fields." viewController:self];
		return false;
	}
	
	if (![Utilities validateEmailWithString:_emailTextField.text]) {
		[Utilities showAlert:@"Please enter vaild email." viewController:self];
		return false;
	}
	return true;
}

-(void)performLogin {
	[[FIRAuth auth] signInWithEmail:_emailTextField.text
						   password:_passwordTextField.text
						 completion:^(FIRAuthDataResult * _Nullable authResult,
									  NSError * _Nullable error) {
		if (error != nil) {
			[Utilities showAlert:error.localizedDescription viewController:self];
		} else {
			[Utilities navigateToViewControllerWithIdentifier:@"NotesViewController" fromViewController:self];
		}
	}];
}

- (IBAction)signInAction:(id)sender {
	if(![self validateAuth]) {
		return;
	} else {
		[self performLogin];
	}
}

@end
