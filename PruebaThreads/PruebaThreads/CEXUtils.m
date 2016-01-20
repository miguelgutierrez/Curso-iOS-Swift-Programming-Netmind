//
//  CEXUtils.m
//  CorreosExpress
//
//  Created by MGM on 9/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import "CEXUtils.h"

@implementation CEXUtils


+(NSData *)cargaFicheroDeBundle:(NSString *)directory fichero:(NSString *)fichero
{
    NSString *path;
    if ([directory length]>0){
        path = [[NSBundle mainBundle] pathForResource:directory ofType:nil];
        path = [path stringByAppendingPathComponent:fichero];
    }
    else
        path = [[NSBundle mainBundle] pathForResource:fichero ofType:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        //File exists
        return [NSData dataWithContentsOfFile:path];
        // return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
    }
    else
    {
        return nil;
    }    
}
+(NSData *)cargaFicheroDeDocuments:(NSString *)directory fichero:(NSString *)fichero
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    path = [path stringByAppendingPathComponent:fichero];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        //File exists
        // return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        return [NSData dataWithContentsOfFile:path];
        
    }
    else
    {
        return nil;
    }
}

@end
