//
//  CKCampaignTableViewCell.h
//  CKReferenceApp
//
//  Created by Scott Yoder on 7/16/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKCampaignTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
