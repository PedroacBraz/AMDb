//
//  MTLSearchMovie.m
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "MTLSearchMovie.h"

@implementation  MTLSearchMovies
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"response":          @"Response",
             @"searchResults":     @"Search",
             @"searchResultsQty":  @"totalResults",
             
             };
}

+ (NSValueTransformer *)posterURLJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSearchMovie.class];
}

@end

@implementation MTLSearchMovie

//returns an NSDictionary with key-value pairs of each model property that should be matched to a value in JSON.
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"posterURL":          @"Poster",
             @"title":              @"Title",
             @"year":               @"Year",
             
             };
}

+ (NSValueTransformer *)posterURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
