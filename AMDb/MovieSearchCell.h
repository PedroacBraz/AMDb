//
//  MovieSearchCell.h
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;

@end
