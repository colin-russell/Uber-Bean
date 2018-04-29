//
//  Cafe.h
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Cafe : NSObject <MKAnnotation>
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
