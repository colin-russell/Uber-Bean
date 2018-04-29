//
//  Cafe.m
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _title = dictionary[@"name"];
        double latitude = [dictionary[@"coordinates"][@"latitude"] doubleValue];
        double longitude =  [dictionary[@"coordinates"][@"longitude"] doubleValue];
        _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}
@end
