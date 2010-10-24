//
//  Configuration.h
//  SalesQuote2
//
//  Created by Dhruv Mahajan on 10/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Configuration :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSString * configurationValue;
@property (nonatomic, retain) NSString * configurationItem;

@end



