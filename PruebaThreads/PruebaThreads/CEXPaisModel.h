//
//  CEXPaisModel.h
//  CorreosExpress
//
//  Created by MGM on 25/11/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEXPaisModel : NSObject


@property (nonatomic,strong) NSString *nombre;
@property (nonatomic,strong) NSString *codigo; // "ES" ---> España

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (NSArray<CEXPaisModel*>* )searchForText:(NSString *)searchText en:(NSArray<CEXPaisModel*>*)paises;
+ (CEXPaisModel*) getPaisPorDefecto;


@end
