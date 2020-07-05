//
//  NotesViewController.m
//  NoteApp
//
//  Created by Ali Elsokary on 7/4/20.
//  Copyright © 2020 mag. All rights reserved.
//

#import "NotesViewController.h"
#import "Utilities.h"
#import "NoteTableViewCell.h"

@import FirebaseAuth;
@import Firebase;

@interface NotesViewController ()
@property (nonatomic, readwrite) FIRFirestore *db;
@property (weak, nonatomic) IBOutlet UITableView *notesTableView;
@end

@implementation NotesViewController

NSMutableArray *notes;
NSMutableArray *noteIds;

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureTableView];
	self.db = [FIRFirestore firestore];
	[self disableDatabasePersistance];
	notes = [NSMutableArray array];
	noteIds = [NSMutableArray array];
	[self readNotes];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

#pragma mark - TableView Configs
- (void)configureTableView {
	_notesTableView.dataSource = self;
	_notesTableView.delegate = self;
	_notesTableView.rowHeight = UITableViewAutomaticDimension;
	_notesTableView.estimatedRowHeight = 200.f;
}

#pragma mark - Firestore Configs

- (void)disableDatabasePersistance {
    FIRFirestoreSettings *settings = [FIRFirestore firestore].settings;
	settings.persistenceEnabled = false;
}

- (void)readNotes {
	[self clearLocalData];
	[[[[[self.db collectionWithPath:@"usersData"] documentWithPath:[FIRAuth auth].currentUser.uid] collectionWithPath:@"notes"] queryOrderedByField:@"timestamp" descending:YES]
	 addSnapshotListener:^(FIRQuerySnapshot *snapshot, NSError *error) {
		if (snapshot == nil) {
			[Utilities showAlert:error.localizedDescription viewController:self];
			return;
		}
		[self clearLocalData];
		for (FIRDocumentSnapshot *document in snapshot.documents) {
			[noteIds addObject:document.documentID];
			[notes addObject:document.data[@"note"]];
		}
		[self.notesTableView reloadData];
	}];
}

-(void)deleteNoteFromDatabase:(NSString *)documentId {
	[[[[[self.db collectionWithPath:@"usersData"] documentWithPath:[FIRAuth auth].currentUser.uid] collectionWithPath:@"notes"] documentWithPath:documentId]
	 deleteDocumentWithCompletion:^(NSError * _Nullable error) {
		if (error != nil) {
			[Utilities showAlert:error.localizedDescription viewController:self];
		}
	}];
}

- (void)detachDatabaseListener {
  id<FIRListenerRegistration> listener = [[self.db collectionWithPath:@"usersData"]
      addSnapshotListener:^(FIRQuerySnapshot *snapshot, NSError *error) {
  }];
	self.db = nil;
  [listener remove];
}

-(void)clearLocalData {
	[notes removeAllObjects];
	[noteIds removeAllObjects];
	[self.notesTableView reloadData];
}

#pragma mark - SignOut
- (IBAction)signOutAction:(id)sender {
	[self detachDatabaseListener];
	[self performLogout];
	[self showAuth];
}

- (void)performLogout {
	NSError *signOutError;
	BOOL status = [[FIRAuth auth] signOut:&signOutError];
	if (!status) {
		[Utilities showAlert:signOutError.localizedDescription viewController:self];
		return;
	}
	[self clearLocalData];
}

-(void)showAuth {
	[Utilities navigateToViewControllerWithIdentifier:@"AuthViewController" fromViewController:self];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	cell.noteLabel.text = [notes objectAtIndex:indexPath.row];
	return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self deleteNoteFromDatabase:[noteIds objectAtIndex:indexPath.row]];
		[self.notesTableView reloadData];
	}
}

@end
