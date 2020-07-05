//
//  AddNotesViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/5/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "AddNotesViewController.h"
#import "Utilities.h"
@import FirebaseAuth;
@import Firebase;

@interface AddNotesViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (nonatomic, readwrite) FIRFirestore *db;

@end

@implementation AddNotesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[_noteTextView becomeFirstResponder];
	self.db = [FIRFirestore firestore];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.db = nil;
	self.handle = nil;
}

- (void)addNoteFor:(NSString *)userId note:(NSString *)note {
	[[[[self.db collectionWithPath:@"usersData"] documentWithPath:userId] collectionWithPath:@"notes"] addDocumentWithData:@{
		@"note": note,
		@"timestamp": [FIRTimestamp timestampWithDate:[NSDate date]]
	} completion:^(NSError * _Nullable error) {
		if (error != nil) {
			[Utilities showAlert:error.localizedDescription viewController:self];
		}
	}];

}

- (IBAction)dismissButtonAction:(id)sender {
	[self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
	self.handle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
		if (user) {
			[self addNoteFor:user.uid note:self.noteTextView.text];
		}
	}];
	[self dismissViewControllerAnimated:true completion:nil];
}

@end
