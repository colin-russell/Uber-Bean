//
//  Cafe.h
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cafe : NSObject
@property (nonatomic, strong) NSString *name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
