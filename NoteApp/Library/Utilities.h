//
//  Utilities.h
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

+ (void)styleFilledButton:(UIButton *) button;

+ (void)styleHollowButton:(UIButton *) button;

+ (BOOL)validateEmailWithString:(NSString*)email;

+ (BOOL)vaildateIsEmpty:(NSString *)textField;

+ (void)showAlert:(NSString *)text viewController:(UIViewController*)VC;

@end

NS_ASSUME_NONNULL_END
