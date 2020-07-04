//
//  Utilities.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (void)styleFilledButton:(UIButton *) button {
	button.backgroundColor = [UIColor colorWithRed: 0.294 green: 0.431 blue: 0.463 alpha: 1.00];
	button.layer.cornerRadius = 25.0;
	button.tintColor = UIColor.whiteColor;
}

+ (void)styleHollowButton:(UIButton *) button {
	button.layer.borderWidth = 2;
	button.layer.borderColor = [UIColor colorWithRed: 0.294 green: 0.431 blue: 0.463 alpha: 1.00].CGColor;
	button.layer.cornerRadius = 25.0;
	button.tintColor = [UIColor colorWithRed: 0.294 green: 0.431 blue: 0.463 alpha: 1.00];
}

+ (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)vaildateIsEmpty:(NSString *)textField {
	if ([[textField stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]  isEqual: @""]) {
		return false;
	}
	return true;
}

+ (void)showAlert:(NSString *)text viewController:(UIViewController*)VC {
//	UIWindow* topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//	topWindow.rootViewController = [UIViewController new];
//	topWindow.windowLevel = UIWindowLevelAlert + 1;
//
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:text preferredStyle:UIAlertControllerStyleAlert];

	[alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
	}]];

//	[topWindow makeKeyAndVisible];
//	[topWindow.rootViewController presentViewController:alert animated:YES completion:nil];
	[VC presentViewController:alert animated:YES completion:nil];
}


@end
