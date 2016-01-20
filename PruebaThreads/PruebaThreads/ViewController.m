//
//  ViewController.m
//  PruebaThreads
//
//  Created by MGM on 10/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

#import "ViewController.h"
#import "CEXPaisModel.h"
#import "CEXPaisesModel.h"
#import "CEXFileManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *estadoLabel;

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *nombreLabel2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onIniciar1:(id)sender {
    [CEXPaisesModel cargaPaisesAsynFin:^(NSNumber *fin) {
        NSInteger total = [[CEXPaisesModel sharedPaises].paises count];
        CEXPaisModel *pais = [[CEXPaisesModel sharedPaises].paises objectAtIndex:total-1];
        
        self.nombreLabel1.text = [NSString stringWithFormat:@"%@ %lu",pais.nombre,(long)total];
    }];
    /*
    [CEXPaisModel cargaPaisesAsyn:^(NSArray *paises) {
        [self onShowStatus:nil];
        for (CEXPaisModel * pais in paises){
            self.nombreLabel1.text = pais.nombre;
            NSLog(@"nombre: %@",pais.nombre);
        }
    }];
     */
}
- (IBAction)onIniciar2:(id)sender {
    [CEXPaisesModel cargaPaisesAsynFinHIGHT:^(NSNumber *fin) {
        NSInteger total = [[CEXPaisesModel sharedPaises].paises count];
        CEXPaisModel *pais = [[CEXPaisesModel sharedPaises].paises objectAtIndex:total-1];

        self.nombreLabel2.text = [NSString stringWithFormat:@"%@ %lu",pais.nombre,(long)total];
    }];
}
- (IBAction)onShowStatus:(id)sender {
    NSInteger total = [[CEXPaisesModel sharedPaises].paises count];
    CEXPaisModel *pais = [[CEXPaisesModel sharedPaises].paises objectAtIndex:total-1];
    
    self.estadoLabel.text = [NSString stringWithFormat:@"total paises: %lu nombre: %@ fecha: %@",(long)total,pais.nombre,[NSDate date]];
    
    NSArray *paises = [NSArray arrayWithArray:[CEXPaisesModel sharedPaises].paises];
    for (CEXPaisModel * pais in paises){
        NSLog(@"nombre: %@",pais.nombre);
    }

    /*
    // no resuelve el problema de *** Terminating app due to uncaught exception 'NSGenericException', reason: '*** Collection <__NSArrayM: 0x17e9e620> was mutated while being enumerated.'
    @synchronized([CEXPaisesModel sharedPaises].paises) {
        for (CEXPaisModel * pais in [CEXPaisesModel sharedPaises].paises){
            self.nombreLabel1.text = pais.nombre;
            NSLog(@"nombre: %@",pais.nombre);
        }        
    }
     */

}

@end
