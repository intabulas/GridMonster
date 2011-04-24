//
//  GridMonsterViewController.h
//  GridMonster
//
//  Created by Mark Lussier on 4/23/11.
//  Copyright 2011 Juniper Networks, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"
#import "CHGridView.h"
#import "MMGridView.h"
#import "OHGridView.h"

@interface GridMonsterViewController : UIViewController <MMGridViewDataSource, MMGridViewDelegate, 
                                                         OHGridViewDataSource, OHGridViewDelegate,
                                                         CHGridViewDataSource, CHGridViewDelegate,
                                                         AQGridViewDataSource, AQGridViewDelegate> {    
    // AQGridView
    AQGridView *_aqGridView;

    // CHGridView    
    CHGridView *_chGridView;    
    
    // MMGridView    
    MMGridView *_mmGridView;    
    
    // OHGridView    
    OHGridView *_ohGridView;    
     
    // Test Data                                                             
    NSMutableArray *_gridTestData;                                                             
                                                             
                                                             
}

- (IBAction) changeGridToolkit:(id)sender;

/* Shared Generic Delegate Methods - AQ and OH have a same named datasource method */

-(NSUInteger)numberOfItemsInGridView:(id)gridview;


@end