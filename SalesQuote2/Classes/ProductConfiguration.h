//
//  ProductConfiguration.h
//  SalesQuote
//
//  Created by Dhruv Mahajan on 10/17/10.
//  Copyright 2010 private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ProductConfiguration : UITableViewController {


}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
