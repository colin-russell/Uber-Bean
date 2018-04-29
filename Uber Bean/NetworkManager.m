//
//  NetworkManager.m
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.isFinishedAddingCafes = NO;
        [self yelpNSURLsetup];
    }
    return self;
}

- (void)yelpNSURLsetup {
    NSURL *yelpUrl = [NSURL URLWithString:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=43.6446486&longitude=-79.3971874"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:yelpUrl];
    [urlRequest addValue:@"Bearer JrzePSDxQeeqqhmpiGEdT7QbusL-kpUK6Iyap0KRlirqrFW-4jt9KLtV46oUl6ExDuteVc_ialILC5fG37i9HkMkjI4yOiQIWlmvnxf6QZMLbBkxjMX7YejzxX3jWnYx" forHTTPHeaderField:@"Authorization"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSArray *cafeArray = root[@"businesses"];
        NSMutableArray *cafes = [NSMutableArray new];
        for (int i = 0; i < cafeArray.count; i++) {
            Cafe *cafe = [[Cafe alloc] initWithDictionary:cafeArray[i]];
            
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                [cafes addObject:cafe];
                //NSLog(@"count: %lu", self.cafes.count);
            }];
            
        }
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            [self.delegate setCafes:cafes];
        }];

        
    }];
    
    [dataTask resume];
}


@end
