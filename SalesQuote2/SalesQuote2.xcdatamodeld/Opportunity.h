//
//  Opportunity.h
//  SalesQuote2
//
//  Created by Dhruv Mahajan on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Opportunity :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * hospital;
@property (nonatomic, retain) NSString * opportunityName;

@end



