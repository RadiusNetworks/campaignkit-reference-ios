//
//  CKPlace.h
//  CampaignKit
//
//  Created by Scott Yoder on 8/13/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKRegion;

typedef NS_ENUM (NSInteger, CKPlaceType) {
    CKPlaceTypeBeacon,
    CKPlaceTypeGeofence,
};

/*!
 CKPlace objects can be returned when a kit's places are detected using the
 [CKManagerDelegate campaignKit:didDetectPlace:onEvent:] callback.
 */
@interface CKPlace : NSObject

/** The name, as set in the portal */
@property (readonly) NSString* name;

/**  */
@property (readonly) NSInteger id;

/*!
 place type
 
 @see CKPlaceType
 */
@property (readonly) CKPlaceType type;

- (CKPlace *)initWithRegion:(PKRegion *)region;

+ (NSArray *)parsePlaceIds:(NSString *)placeIds;

@end
