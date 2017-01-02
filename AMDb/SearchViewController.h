//
//  SearchViewController.h
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MTLSearchMovie.h"


@interface SearchViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchedMovies;
@property (nonatomic, strong) NSMutableArray *movies;


- (NSString *) createURLforSearch: (NSString *) movieTitle;

@end
