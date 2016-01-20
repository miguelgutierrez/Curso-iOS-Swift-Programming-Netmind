//
//  CEXUtils.h
//  CorreosExpress
//
//  Created by MGM on 9/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEXUtils : NSObject

+ (NSData*) cargaFicheroDeBundle:(NSString*)directory  fichero:(NSString*)fichero;
+ (NSData*)   cargaFicheroDeDocuments:(NSString*)directory  fichero:(NSString*)fichero;

@end
