//
//  UStAppDelegate.h
//  USt
//
//  Created by Matthias Blanquett on 03.04.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MotionWindow.h"


// UIAlertViewDelegate, um korrekt auf die Schüttelgeste zu reagieren
@interface UStAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate>
{
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

	// Eigenes Window wegen der Shake-Detection
	MotionWindow *window;

	UINavigationController *__weak navigationController;

	// Um zu verhindern, dass Shake zu oft hintereinander ausgeführt wird
	CFTimeInterval lastTime;
}

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) IBOutlet MotionWindow *window;
@property (nonatomic, readonly, weak) IBOutlet UINavigationController *navigationController;

- (NSString *)applicationDocumentsDirectory;

@end