//
//  CEXFileManager.m
//  CorreosExpress
//
//  Created by MGM on 9/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import "CEXFileManager.h"
#import <dispatch/dispatch.h>
#import "CEXUtils.h"

NSString*const kBackgroundQueueName= @"es.empresa.app";

@interface CEXFileManager ()

@property (nonatomic,strong) dispatch_queue_t backgroundQueue;

- (id) init;

@end
@implementation CEXFileManager

+ (id)sharedCEXFileManager {
    static CEXFileManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
-(id)init {
    if ((self=[super init])) {
        self.backgroundQueue = dispatch_queue_create([kBackgroundQueueName UTF8String], nil);
    }
    return self;
}
- (void) cargaFicheroDeBundleAsync:(NSString*)directory  fichero:(NSString*)fichero __handler:(void(^) (id)) __handler;
{
 //   NSLog(@"cargaFicheroDeBundleAsync: (%@)",  [NSThread currentThread]);
    dispatch_async(self.backgroundQueue, ^{
   //     NSLog(@"backgroundQueue: (%@)",  [NSThread currentThread]);
        NSData *datos=[CEXUtils cargaFicheroDeBundle:directory fichero:fichero];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
     //       NSLog(@"dispatch_get_main_queue: (%@)",  [NSThread currentThread]);
            __handler(datos);
        });
    });
    
}
@end
