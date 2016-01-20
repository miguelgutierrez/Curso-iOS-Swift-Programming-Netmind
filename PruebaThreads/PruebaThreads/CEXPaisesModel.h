//
//  CEXPaisesModel.h
//  PruebaThreads
//
//  Created by MGM on 10/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEXPaisesModel : NSObject

@property (nonatomic,strong) NSMutableArray *paises;
@property (nonatomic,strong) NSString *valorParaProbarSynchronize;

+ (CEXPaisesModel*)sharedPaises;

+ (void) cargaPaisesAsyn:(void(^) (NSArray*)) block;
+ (void) cargaPaisesAsynFin:(void (^)(NSNumber*))block;
+ (void)cargaPaisesAsynFinHIGHT:(void (^)(NSNumber*))block;

@end
