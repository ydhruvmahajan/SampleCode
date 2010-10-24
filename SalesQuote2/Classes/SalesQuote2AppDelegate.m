//
//  SalesQuote2AppDelegate.m
//  SalesQuote2
//
//  Created by Dhruv Mahajan on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SalesQuote2AppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"
#import "Opportunity.h"
#import "Configuration.h"

@implementation SalesQuote2AppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;


#pragma mark -
#pragma mark Application lifecycle


- (void)awakeFromNib {
    // Pass the managed object context to the root view controller.
    rootViewController.managedObjectContext = self.managedObjectContext; 
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
    
	// Add the split view controller's view to the window and display.
	[window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"SalesQuote2" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
	BOOL bCreateSampleData = NO;
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"SalesQuote2.sqlite"];
	//NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"SalesQuote2" ofType:@"sqlite"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn’t exist, copy the default store.
	// Divya - always create sample data
	NSError *error = nil;
    if ([fileManager fileExistsAtPath:storePath]) {
		bCreateSampleData=NO;
	} else {
		bCreateSampleData=YES;
	}
	NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"SalesQuote2.sqlite"]];
    
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    if (bCreateSampleData) [self createSampleData];
    return persistentStoreCoordinator_;
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
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {

    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[splitViewController release];
	[rootViewController release];
	[detailViewController release];

	[window release];
	[super dealloc];
}

#define NEWOPP (Opportunity *)[NSEntityDescription insertNewObjectForEntityForName:@"Opportunity" inManagedObjectContext:context];
#define NEWCONFIG (Configuration *)[NSEntityDescription insertNewObjectForEntityForName:@"Configuration" inManagedObjectContext:context];

- (void) createSampleData {
	// Create a new instance of the entity managed by the fetched results controller.
    SalesQuote2AppDelegate *appDelegate =
	[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = [appDelegate managedObjectContext];
	/*
	 
	 NSEntityDescription *accountEntity = [NSEntityDescription
	 entityForName:@"Account"
	 inManagedObjectContext:context];
	 NSEntityDescription *opportunityEntity = [NSEntityDescription
	 entityForName:@"Opportunity"
	 inManagedObjectContext:context];
	 */
	Opportunity *newOpp;
	Configuration *newCfg;
	newOpp = NEWOPP;
	newOpp.hospital=@"Lawrence General Hospital";
	newOpp.opportunityName=@"The Birthing Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Lawrence General Hospital";
	newOpp.opportunityName=@"Trauma Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Lawrence General Hospital";
	newOpp.opportunityName=@"Short Stay Unit";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Lawrence General Hospital";
	newOpp.opportunityName=@"Pediatric Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Lawrence General Hospital";
	newOpp.opportunityName=@"Day Surgery Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Holy Family Hospital";
	newOpp.opportunityName=@"Pediatric Place";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Holy Family Hospital";
	newOpp.opportunityName=@"Birthing Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"St. Anne's Hospital";
	newOpp.opportunityName=@"Birthing Center";
	newOpp.address=@"unknown address";
	
	newOpp = NEWOPP;
	newOpp.hospital=@"Norwood Hospital";
	newOpp.opportunityName=@"Trauma Center";
	newOpp.address=@"unknown address";
	
	
	newCfg = NEWCONFIG;
	newCfg.product = @"MP2 #1";
	newCfg.configurationItem = @"Include SPO2";
	newCfg.configurationValue = @"YES";
	
	newCfg = NEWCONFIG;
	newCfg.product = @"MP2 #1";
	newCfg.configurationItem = @"Include Anaesthesia";
	newCfg.configurationValue = @"YES";
	
	newCfg = NEWCONFIG;
	newCfg.product = @"MP2 #2";
	newCfg.configurationItem = @"Include SPO2";
	newCfg.configurationValue = @"NO";
	
	newCfg = NEWCONFIG;
	newCfg.product = @"MP2 #2";
	newCfg.configurationItem = @"Include Anaesthesia";
	newCfg.configurationValue = @"YES";
	
	newCfg = NEWCONFIG;
	newCfg.product = @"X2 #1";
	newCfg.configurationItem = @"Number of waveforms";
	newCfg.configurationValue = @"4";
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}


@end

