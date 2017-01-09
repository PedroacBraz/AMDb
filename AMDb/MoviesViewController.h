//
//  MoviesViewController.h
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieCell.h"

@interface MoviesViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *noMoviesLabel;

    
@end
