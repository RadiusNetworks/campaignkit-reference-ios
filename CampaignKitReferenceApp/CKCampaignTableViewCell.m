//
//  CKCampaignTableViewCell.m
//  CKReferenceApp
//
//  Created by Scott Yoder on 7/16/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import "CKCampaignTableViewCell.h"

@implementation CKCampaignTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.cardView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.cardView.layer.cornerRadius = 10.0;
    //self.cardView.layer.borderWidth = 1.0;
    //self.cardView.layer.borderColor = [UIColor colorWithRed:0.227 green:0.745 blue:0.933 alpha:1.0].CGColor;
    
    self.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentView.layer.shadowRadius = 5.0;
    self.contentView.layer.shadowOpacity = 1.0;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    
    //self.cardView.layer.masksToBounds = YES;
    self.contentView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.cardView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    } else {
        self.cardView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    }
}

@end
