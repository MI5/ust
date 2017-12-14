//
//  UStAppDelegate.m
//  USt
//
//  Created by Matthias Blanquett on 03.04.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
//
//
//
// Ich musste "if (cell == nil)" im gesamten Projekt deaktivieren, sonst klappt das Paragraphen-anzeigen umschalten mit Multitasking nicht
#import "UStAppDelegate.h"
#import "Stufe15a.h"


@implementation UStAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// Diese 2 Zeilen und der cast auf StartTVController, damit Zugriff auf ".managedObjectContext"-Property möglich
	//StartTVController *viewController = (StartTVController *) navigationController.topViewController;
	//viewController.managedObjectContext = self.managedObjectContext;

	// Navigation Controller im Fenster einhängen
	// [window addSubview:navigationController.view]; // alt
    [window setRootViewController:navigationController]; // neu
	[window makeKeyAndVisible];

	// Startet unsere App zum allerersten mal?
	NSUserDefaults *einstellungen = [NSUserDefaults standardUserDefaults];
	if ([einstellungen stringForKey:@"firstStartEver"] == nil) {
		[einstellungen setObject:@"!" forKey:@"firstStartEver"];
		[einstellungen setBool:TRUE forKey:@"law"];
		[einstellungen synchronize];

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Erster App-Start", nil) message:NSLocalizedString(@"Sie können in den globalen Geräte-Einstellungen die Paragraphen-anzeige deaktivieren.", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}

	// Abfragen der Einstellungen beim starten
	[[Data instance] setShowLaw:[[NSUserDefaults standardUserDefaults] boolForKey:@"law"]];

	// Abfragen der Einstellungen beim Multitasking
	// Update: Jetzt anders gelöst, über delegate applicationWillEnterForeground()
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferenceDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];


    // Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
    // The "shake" nofification is posted by the MotionWindow object when user shakes the device
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToShake) name:@"shake" object:nil];
}


// Wegen Multitasking, falls User die Einstellungen ändert
- (void)preferenceDidChange:(NSNotification *)aNotification {
	// Funktioniert nicht, ka. Die Notification wird aufgerufen, wenn die Tastatur eingeblendet wird?!?????? Muss was damit zu tun haben, dass
	// dieses ebenfalls über eine Notification gelöst wird.

	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"law"] message:@"preferenceDidChange-Notification wurde aufgerufen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	//[alert show];   
	//[alert release];
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	// Wegen Multitasking, falls User die Einstellungen ändert
    // [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Hide, damit ein evtl. Paragraphen-Anzeigen-Wechsel smoothier aussieht
	// navigationController.topViewController.view.hidden = YES;
}

- (void) applicationWillEnterForeground:(UIApplication *)application {
	// Abfragen der Einstellungen beim Multitasking
	[NSUserDefaults resetStandardUserDefaults]; //Refresh
	[[Data instance] setShowLaw:[[NSUserDefaults standardUserDefaults] boolForKey:@"law"]];

	// viewWillAppear, viewDidAppear und viewDidLoad werden leider alle beim Foreground-Betreten nicht aufgerufen, sonst wäre alles leichter
	// Cast erforderlich, weil eine view zurückgeliefert wird, wir aber TableView brauchen, um die Methode reloadData ohne Warnung aufrufen zu können
	// Aber dies ist gefährlich, weil nicht jede zurückgelieferte View eine TableView ist, deswegen vorher selector-Check
    if ([navigationController.topViewController.view respondsToSelector:@selector(reloadData)]) {
		[(UITableView*)navigationController.topViewController.view reloadData];
    }

	// Dann wieder show, da wir beim in den Hintergrundgehen den View versteckt haben
	// navigationController.topViewController.view.hidden = NO;

	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hinweis" message:[[NSUserDefaults standardUserDefaults] stringForKey:@"law"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	//[alert show];
	//[alert release];
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }

    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }

    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }

    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"USt.sqlite"]];

	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    

    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Shake management

// Called when receiving the "shake" notification
-(void) respondToShake {
    if(CFAbsoluteTimeGetCurrent() > lastTime + 0.5) {
		if ([self.navigationController.topViewController.nibName isEqualToString:@"Stufe15a"]) {
			// Klappt  nicht, da topViewController read-only (?)
			// [((Stufe15a)self.navigationController.topViewController) setYears:2];
			// Deswegen etwas umständlicher unten gelöst, alternativ geht es mit id (warum?):

			// Es ist zwar ein double, aber ich empfange ihn als Integer, damit compare klappt und auch die String-Ausgabe
			NSInteger y = [((id)self.navigationController.topViewController) years];

			// Bei Gebäuden soll nix passieren
            if (y == 10) {
				return;
            }

            if (y == 5) {
				y = 1;
            } else {
				y++;
            }

			// Wenn date2 zu weit entfernt von date1 soll nix passieren																																// 1 Stunde Sicherheitsabstand
			if ([((id)self.navigationController.topViewController) date2].timeIntervalSinceNow - [((id)self.navigationController.topViewController) date1].timeIntervalSinceNow > 60*60*24*365.2*y + 60*60) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Berichtigungszeitraum kann nicht verändert werden, da Änderungsdatum zu weit entfernt von Anschaffungsdatum.", nil) message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
				[alert show];

				return;
			}

			// den neuen y-Wert übergeben
			[[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-1] setYears:y];

			NSString* e = @"";
            if (y != 1) {
				e = @"e";
            }

			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Berichtigungszeitraum geändert auf %li Jahr%@", (long)y, e] message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[alert show];

			[((id)self.navigationController.topViewController) updateRechnung];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Schüttelgeste erkannt", nil) message:@"Von vorne anfangen?" delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja", nil];
			[alert show];   
		}

		lastTime = CFAbsoluteTimeGetCurrent();
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1) {
		//for (UIView *view in window.subviews) {}
		[navigationController popToRootViewControllerAnimated:TRUE];
	}
}



@end

