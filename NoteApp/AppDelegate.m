//
//  AppDelegate.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthViewController.h"
#import "NotesViewController.h"
@import Firebase;

@interface AppDelegate ()
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[FIRApp configure];

	[self handleAuthenticatedState];

	return YES;
}

-(void)handleAuthenticatedState {
	if ([FIRAuth auth].currentUser) {
		[self performTransitionTo:@"NotesViewController"];
	} else {
		[self performTransitionTo:@"AuthViewController"];
	}
}

-(void)performTransitionTo:(NSString *)viewController {
	self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:viewController];
	self.window.rootViewController = vc;
	[self.window makeKeyAndVisible];
}


@end
