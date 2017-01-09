//
//  Movie.h
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import <AFNetworking/AFNetworking.h>


@interface Movie : RLMObject

// Movie's attributes

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *shortSynopsis;
@property (nonatomic, copy) NSString *fullSynopsis;
@property (nonatomic, copy) NSString *moviePosterURL;
@property (nonatomic, copy) NSString *actors;
@property (nonatomic, copy) NSString *director;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, copy) NSString *rated;
@property (nonatomic, copy) NSString *runtime;
//@property (nonatomic, copy) UIImage *moviePoster;
@property (nonatomic, copy) NSData *moviePosterData;

- (Movie *) initWithDictionary:(NSDictionary *)movieDictionary;

@end
RLM_ARRAY_TYPE(Movie)
