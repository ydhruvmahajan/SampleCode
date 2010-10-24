//
//  DetailViewController.h
//  SalesQuote2
//
//  Created by Dhruv Mahajan on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Opportunity.h"
#import <MapKit/MapKit.h>

@class RootViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate,UITabBarControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    NSManagedObject *detailItem;

    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIView *viewItemSelected;
@property (nonatomic, retain) IBOutlet UIView *viewItemNotSelected;
@property (nonatomic, retain) NSManagedObject *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailHospitalLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailOpportunityLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailAddressLabel;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIButton *btnShowLocation;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

- (IBAction)startOpportunityEditor:(id)sender;
- (IBAction)createNewOpportunity:(id)sender;
- (IBAction)toggleMyLocation:(id)sender;
@end
