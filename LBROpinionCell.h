//
//  LBROpinionCell.h
//  ParseDemo
//
//  Created by Jose A. Contreras on 31/10/13.
//  Copyright (c) 2013 Lirobits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBROpinionCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@end
