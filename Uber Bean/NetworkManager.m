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
        _buisinesses = [NSMutableDictionary new];
        [self yelpNSURLsetup];
    }
    return self;
}

- (void)yelpNSURLsetup {
    NSURL *yelpUrl = [NSURL URLWithString:@"https://www.yelp.com/biz/fika-toronto-2?adjust_creative=v-uw1oTKpUIMeKsYMMG2GA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=v-uw1oTKpUIMeKsYMMG2GA"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:yelpUrl];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *mainDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        self.businesses = mainDict[@"businesses"][@"name"];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for (NSDictionary *dict in self.businesses) {
            
            //NSLog(@"URL:%@", photo.url);
            [self.photoObjects addObject:photo];
            //NSLog(@"count: %lu", self.photoObjects.count);
        }
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            //[self.catCollectionView reloadData];
        }];
    }];
    
    [dataTask resume];
}
@end
