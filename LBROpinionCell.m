//
//  LBROpinionCell.m
//  ParseDemo
//
//  Created by Jose A. Contreras on 31/10/13.
//  Copyright (c) 2013 Lirobits. All rights reserved.
//

#import "LBROpinionCell.h"

@implementation LBROpinionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 307, 21)];
        self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 29, 320, 61)];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 98, 180, 21)];
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 98, 130, 21)];
        self.titleLabel.textColor = [UIColor blueColor];
        self.messageTextView.textColor = [UIColor grayColor];
        self.scoreLabel.textColor = [UIColor orangeColor];
        self.dateLabel.textColor = [UIColor grayColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageTextView];
        [self addSubview:self.dateLabel];
        [self addSubview:self.scoreLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
