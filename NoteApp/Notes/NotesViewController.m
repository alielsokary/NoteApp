//
//  NotesViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "NotesViewController.h"
#import "Utilities.h"
@import FirebaseAuth;
@import Firebase;

@interface NotesViewController ()

@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (nonatomic, readwrite) FIRFirestore *db;

@end

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.db = [FIRFirestore firestore];
}

- (IBAction)addNoteAction:(id)sender {
	self.handle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
		
		NSString * note;
		note = @"This is a new note";
		[self addNoteFor:user.uid note:note];
    }];
}

- (IBAction)signOutAction:(id)sender {
	[self performLogout];
	[self showAuth];
}

-(void)showAuth {
	[Utilities navigateToViewControllerWithIdentifier:@"AuthViewController" fromViewController:self];
}

- (void)addNoteFor:(NSString *)userId note:(NSString *)note {
	__block FIRDocumentReference *ref =
	[[[[self.db collectionWithPath:@"usersData"] documentWithPath:userId] collectionWithPath:@"notes"] addDocumentWithData:@{
		@"note": note
	} completion:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Error adding document: %@", error);
      } else {
        NSLog(@"Document added with ID: %@", ref.documentID);
      }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}

- (void)performLogout {
	NSError *signOutError;
	BOOL status = [[FIRAuth auth] signOut:&signOutError];
	if (!status) {
		NSLog(@"Error signing out: %@", signOutError);
		return;
	}
}

@end
