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
#import <AFNetworking/AFImageDownloader.h>
#import "MTLSearchMovie.h"
#import "MovieSearchCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "FullMovieViewController.h"
#import "MBProgressHUD.h"


@interface SearchViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchedMovies;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic) int actualPage;
@property (nonatomic, strong) NSString *searchBarText;

- (IBAction)touchedMoviePosterButton:(id)sender;


- (NSString *) createURLforSearch: (NSString *) movieTitle;

@end
