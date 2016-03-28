//
//  TableViewCell.h
//  MagicMoving
//
//  Created by tangjianzhuo on 16/3/24.
//  Copyright © 2016年 QuanFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
