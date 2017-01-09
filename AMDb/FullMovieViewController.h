//
//  FullMovieViewController.h
//  AMDb
//
//  Created by Mac Mini Beta on 03/01/17.
//  Copyright © 2017 Mac Mini Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import <Realm/Realm.h>
#import "UIImageView+AFNetworking.h"

@interface FullMovieViewController : UIViewController

@property (nonatomic, strong) Movie * movie;
@property (nonatomic, strong) Movie * movietoAddInFavorites;
@property (nonatomic, strong) NSString * moviePosterURL;
@property (nonatomic, strong) NSDictionary *movieData;

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UITextView *movieSynopsisTextView;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieActorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDirectorLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRuntimeLabel;

- (IBAction)favoriteMovieButtonTouched:(id)sender;


@end
