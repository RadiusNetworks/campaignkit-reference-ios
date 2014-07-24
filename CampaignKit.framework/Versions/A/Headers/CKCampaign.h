//  Copyright (c) 2014 Radius Networks. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/** CKCampaign contains all the data related to a campaign. */
@interface CKCampaign : NSObject

/** The campaign's id */
@property (strong, nonatomic) NSString *id;

/** The campaign's title, for alerts or notifications */
@property (strong, nonatomic) NSString *title;

/** The campaign detail content, in HTML format. This should be presented to
 * the user when a campaign is detected.
 */
@property (strong, nonatomic) NSString *content;

/** Alert message text */
@property (strong, nonatomic) NSString *message;

/** Date & time when the campaign begins. */
@property (strong, nonatomic) NSDate *startAt;

/** Date & time when the campaign ends or expires. */
@property (strong, nonatomic) NSDate *endAt;

@property (strong, nonatomic) NSArray *places;

- (id)initWithDictionary:(NSDictionary*) dictionary;

/** isActive
 *
 * returns `YES` if the campaign is currently active, otherwise returns `NO`.
 */
- (BOOL)isActive;

- (BOOL)isEqual:(id)object;

- (UILocalNotification*) buildLocalNotification;

@end