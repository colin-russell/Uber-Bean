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
        _businesses = [NSMutableDictionary new];
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
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // need to parse through as an array of dictionaries, not a dictionary
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSArray *bussinessArray = root[@"businesses"];
        for (int i = 0; i < bussinessArray.count; i++) {
            NSDictionary *business = bussinessArray[i];
            NSLog(@"business name: %@", business[@"name"]);
        }
        //self.businesses = mainDict[@"businesses"][@"name"];
        
        
//        for (NSDictionary *business in self.businesses) {
//
//            NSLog(@"name: %@", business[@"name"]);
//            [self.photoObjects addObject:photo];
//            NSLog(@"count: %lu", self.photoObjects.count);
//        }
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            //[self.catCollectionView reloadData];
        }];
    }];
    
    [dataTask resume];
}
@end
