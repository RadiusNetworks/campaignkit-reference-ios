//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKManagerDelegate.h"
#import "CKCampaign.h"

/** CKManager
 *
 * The `CKManager` class defines the interface for configuring the delivery of campaign related events to your application.
 *
 */
@interface CKManager : NSObject

/** getVersion
 *
 * Get the version string for the Campaign Kit Framework
 *
 */
+ (NSString *)getVersion;


/*! Returns a new instance of a `CKManager` that uses the supplied delegate to delivery events.

 Example usage:
 
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.campaignKitManager = [CKManager managerWithDelegate:self];
        [self.campaignKitManager start];
        return YES;
    }
 
 @see CKManagerDelegate
 */
+ (CKManager *)managerWithDelegate:(id <CKManagerDelegate> )delegate;

/**
 * returns an instance of CKCampaign with the given id.
 */
- (CKCampaign*)campaignWithId: (NSString*)idStr;

- (CKCampaign*)campaignFromNotification: (UILocalNotification*)notification;

/*!
 Sets up the manager and synchronizes data with the server.
 */
- (void)start;

/*!
 Unregister regions and beacons and stop automatic syncing.

 While the CKManager is stopped, if `sync` is called the API will be called
 and data downloaded and synced. However, any regions will not be
 registered with CoreLocation.
 */
- (void)stop;

/*!
 Force a sync with the server. This is not normally required.
 */
- (void)sync;

@property (assign) id <CKManagerDelegate> delegate;

/*!
 Contains a list of all the campaigns that the app has found.
 
 This can be used to populate a TableView with all currently active campaigns that the app has encountered.
 */
@property (strong, nonatomic) NSMutableArray *campaigns;

@end
