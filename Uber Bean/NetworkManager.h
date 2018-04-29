//
//  NetworkManager.h
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cafe.h"

@protocol NetworkManagerDelegate <NSObject>
- (void) setCafes:(NSMutableArray *)cafes;
@end

@interface NetworkManager : NSObject
@property (nonatomic, weak) id<NetworkManagerDelegate> delegate;
//@property (nonatomic, strong) NSMutableArray *cafes;
@property BOOL isFinishedAddingCafes;
@end
