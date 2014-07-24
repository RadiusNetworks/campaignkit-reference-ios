//
//  DealsViewController.h
//  CKReferenceApp
//
//  Created by Scott Yoder on 7/15/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CampaignKit/CampaignKit.h>

@interface DealsViewController : UITableViewController

- (void)showCampaign:(CKCampaign*)campaign;

@end
