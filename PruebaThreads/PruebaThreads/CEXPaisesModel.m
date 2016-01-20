//
//  CEXPaisesModel.m
//  PruebaThreads
//
//  Created by MGM on 10/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import "CEXPaisesModel.h"
#import "CEXFileManager.h"
#import "CEXPaisModel.h"

static NSString*const kFicheroPaises=@"countries.json";
static NSString *const kDirectorioDatosIniciales=@"DatosIniciales";

@interface CEXPaisesModel ()

@property (nonatomic,strong) dispatch_queue_t backgroundQueue;  // (Serial Queue)

@end

@implementation CEXPaisesModel
-(id)init {
    if ((self=[super init])) {
        self.backgroundQueue = dispatch_queue_create([kBackgroundQueueName UTF8String], nil);
        self.paises = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

+ (CEXPaisesModel*)sharedPaises {
    static CEXPaisesModel *sharedPaises = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPaises = [[self alloc] init];
    });
    return sharedPaises;
}
+ (void)cargaPaisesAsyn:(void (^)(NSArray *))block
{
    [[CEXFileManager sharedCEXFileManager] cargaFicheroDeBundleAsync:kDirectorioDatosIniciales fichero:kFicheroPaises __handler:^(id handler) {
        if (handler) {
            NSData *datos = (NSData*)handler;
            id json=[NSJSONSerialization JSONObjectWithData:datos options:(NSJSONReadingMutableContainers) error:nil];
            block([CEXPaisesModel cargaPaises:json]);
        }
        else
            block(nil);
    }];
    
}
+ (void)cargaPaisesAsynFin:(void (^)(NSNumber*))block
{
    [[CEXFileManager sharedCEXFileManager] cargaFicheroDeBundleAsync:kDirectorioDatosIniciales fichero:kFicheroPaises __handler:^(id handler) {
        if (handler) {
            NSData *datos = (NSData*)handler;
            id json=[NSJSONSerialization JSONObjectWithData:datos options:(NSJSONReadingMutableContainers) error:nil];
            //[CEXPaisesModel sharedPaises].paises = [CEXPaisesModel cargaPaises:json];
            
            [[CEXPaisesModel sharedPaises] cargaPaisesAsync:json block:^(NSNumber *result) {
                block(result);
            }];

        }
        else
            block([NSNumber numberWithBool:NO]);
    }];
    
}
+ (void)cargaPaisesAsynFinHIGHT:(void (^)(NSNumber *))block
{
    [[CEXFileManager sharedCEXFileManager] cargaFicheroDeBundleAsync:kDirectorioDatosIniciales fichero:kFicheroPaises __handler:^(id handler) {
        if (handler) {
            NSData *datos = (NSData*)handler;
            id json=[NSJSONSerialization JSONObjectWithData:datos options:(NSJSONReadingMutableContainers) error:nil];
            //[CEXPaisesModel sharedPaises].paises = [CEXPaisesModel cargaPaises:json];
            
            [[CEXPaisesModel sharedPaises] cargaPaisesAsyncHightPriority:json block:^(NSNumber *result) {
                block(result);
            }];
            
        }
        else
            block([NSNumber numberWithBool:NO]);
    }];
    
}
+(NSArray *)cargaPaises:(id)json
{
    NSMutableArray *paises = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (json) {
        NSInteger totalPaises = [json count];
        for(int contadorPaises=0; (contadorPaises<totalPaises); contadorPaises++){
            CEXPaisModel *pais = [[CEXPaisModel alloc] initWithAttributes:[json objectAtIndex:contadorPaises]];
            [paises addObject:pais];
            
        }
    }
    NSLog(@"fin cargaPaises");
    
    return paises;
}

- (void)cargaPaisesAsync:(id)json block:(void (^)(NSNumber*))block
{
    NSLog(@"cargaPaises: (%@)",  [NSThread currentThread]);
    //dispatch_async(self.backgroundQueue, ^{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        NSLog(@"backgroundQueue: (%@)",  [NSThread currentThread]);

        //@synchronized(self.valorParaProbarSynchronize) { //
        @synchronized(self.paises) {//OK //  @synchronized(self) { OK
            // sólo puede estar este proceso accediendo a self o self.paises
            // tiene que estar el otro proceso tambien sincronizado
            if (json) {
                NSInteger totalPaises = [json count];
                
                for(int contadorPaises=0; (contadorPaises<totalPaises); contadorPaises++){
                    CEXPaisModel *pais = [[CEXPaisModel alloc] initWithAttributes:[json objectAtIndex:contadorPaises]];
                    [NSThread sleepForTimeInterval:.1]; //sleep(1);
                    [self.paises addObject:pais];
                    
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSLog(@"dispatch_get_main_queue: (%@)",  [NSThread currentThread]);
            block([NSNumber numberWithBool:YES]);
        });
    });
}
- (void)cargaPaisesAsyncHightPriority:(id)json block:(void (^)(NSNumber*))block
{
    NSLog(@"cargaPaises: (%@)",  [NSThread currentThread]);
    
        // Concurrent Queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
         NSLog(@"QUEUE HIGHT: (%@)",  [NSThread currentThread]);
        
        //@synchronized(self.valorParaProbarSynchronize) { //no sincroniza
        @synchronized(self.paises) {// OK //  @synchronized(self) { OK

            if (json) {
                NSInteger totalPaises = [json count];
                
                for(int contadorPaises=0; (contadorPaises<totalPaises); contadorPaises++){
                    CEXPaisModel *pais = [[CEXPaisModel alloc] initWithAttributes:[json objectAtIndex:contadorPaises]];
                    [NSThread sleepForTimeInterval:.1]; //sleep(1);
                    [self.paises addObject:pais];
                    
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSLog(@"dispatch_get_main_queue: (%@)",  [NSThread currentThread]);
            block([NSNumber numberWithBool:YES]);
        });
    });
}

@end
