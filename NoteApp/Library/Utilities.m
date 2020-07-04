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

@end
