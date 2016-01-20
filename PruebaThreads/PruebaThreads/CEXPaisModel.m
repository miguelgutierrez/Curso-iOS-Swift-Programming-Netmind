//
//  CEXPaisModel.m
//  CorreosExpress
//
//  Created by MGM on 25/11/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import "CEXPaisModel.h"
#import "CEXUtils.h"

static NSString*const kNombrePaisJson=@"name";
static NSString*const kCodigoPaisJson=@"code";

@implementation CEXPaisModel


- (id)initWithAttributes:(NSDictionary *)attributes;
{
    self = [super init];
    
    if (self) {
        [self updateWithAttributes:attributes];
    }
    
    return self;
}

- (void) updateWithAttributes:(NSDictionary *)attributes
{
    
    @try {
        self.nombre=[attributes objectForKey:kNombrePaisJson];
    }
    @catch (NSException*) {}

    @try {
        self.codigo=[attributes objectForKey:kCodigoPaisJson];
    }
    @catch (NSException*) {}
}
+ (NSArray<CEXPaisModel*>* )searchForText:(NSString *)searchText en:(NSArray<CEXPaisModel*>*)paises
{
    if ((searchText != nil) && ([searchText length] > 0)){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.nombre CONTAINS[cd] %@",searchText];
        return  [paises filteredArrayUsingPredicate:predicate];
    }
    else{
        return paises;
    }
}
// el país por defecto es España
// mgm 151127 todo: pendiente cogerlo de la tabla que corresponda cuando la tengamos
+ (CEXPaisModel*) getPaisPorDefecto
{
    CEXPaisModel *pais= [[CEXPaisModel alloc] init];
    pais.nombre = @"España";
    pais.codigo = @"ES";
    return pais;
}

/*
+ (NSArray *)cargaPaises
{
    NSData *datos = [CEXUtils cargaFicheroDeBundle:kDirectorioDatosIniciales fichero:kFicheroPaises];
    
    id json=[NSJSONSerialization JSONObjectWithData:datos options:(NSJSONReadingMutableContainers) error:nil];
    
    return [CEXPaisModel cargaPaises:json];

}
*/
@end
