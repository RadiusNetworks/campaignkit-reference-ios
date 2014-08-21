//  Copyright (c) 2014 Radius Networks. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CKContent.h"

/** CKCampaign contains all the data related to a campaign. */
@interface CKCampaign : NSObject<NSCoding>

/** The campaign's id */
@property (strong, nonatomic) NSString *id;

/** The campaign detail content, in HTML format. This should be presented to
 * the user when a campaign is detected.
 */
@property (strong, nonatomic) CKContent *content;

/** Date & time when the campaign begins. */
@property (strong, nonatomic) NSDate *startAt;

/** Date & time when the campaign ends or expires. */
@property (strong, nonatomic) NSDate *endAt;

@property (strong, nonatomic) NSArray *places;


-(id)initWithCoder:(NSCoder *)coder;
-(void)encodeWithCoder:(NSCoder *)coder;

- (id)initWithDictionary:(NSDictionary*) dictionary contents: (NSArray*)contents;
- (void)updateWithDictionary:(NSDictionary*) dictionary contents: (NSArray*)contents;

/** isActive
 *
 * returns `YES` if the campaign is currently active, otherwise returns `NO`.
 */
- (BOOL)isActive;

- (BOOL)isEqual:(id)object;
- (BOOL)canDetect;
- (void)doNotDetectFor:(NSTimeInterval)seconds;


- (UILocalNotification*) buildLocalNotification;

@end