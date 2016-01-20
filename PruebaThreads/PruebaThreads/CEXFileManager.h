//
//  CEXFileManager.h
//  CorreosExpress
//
//  Created by MGM on 9/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString*const kBackgroundQueueName;

@interface CEXFileManager : NSObject

+ (id)sharedCEXFileManager;

- (void) cargaFicheroDeBundleAsync:(NSString*)directory  fichero:(NSString*)fichero __handler:(void(^) (id)) __handler;

@end
