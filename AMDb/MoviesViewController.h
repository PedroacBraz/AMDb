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
#import "FullMovieViewController.h"

@interface MoviesViewController : UITableViewController{
    RLMResults *movieResults;
    Movie *selectedDataObject;

}

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *noMoviesLabel;



@end
