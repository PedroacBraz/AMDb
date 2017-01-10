//
//  MovieCell.h
//  AMDb
//
//  Created by Mac Mini Beta on 23/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UILabel *shortSynopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *noMoviesLabel;
@property (weak, nonatomic) IBOutlet UIButton *movieCellButton;


@end
