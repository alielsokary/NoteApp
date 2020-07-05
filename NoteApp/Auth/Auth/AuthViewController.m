//
//  AuthViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "AuthViewController.h"
#import "Utilities.h"

@interface AuthViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@end

@implementation AuthViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[Utilities styleFilledButton:_signInButton];
	[Utilities styleHollowButton:_signUpButton];
}

@end
