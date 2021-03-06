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
    int _currentGrid;
                                                                                                          
}

@property (nonatomic,retain) IBOutlet UIView   *gridContainer;                                                             
@property (nonatomic,retain) IBOutlet UILabel  *gridControlNotesLabel;
@property (nonatomic,retain) IBOutlet UIButton *gridControlLinkLabel;                                        
@property (nonatomic,retain) IBOutlet UISlider *gridColumnCountSlider;
@property (nonatomic,retain) IBOutlet UISlider *gridNumberOfCellsSlider;

@property (nonatomic,retain) IBOutlet UIBarButtonItem *aqGridButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *chGridButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *mmGridButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *ohGridButton;

- (IBAction) changeGridToolkit:(id)sender;
- (IBAction) openControlInSafari:(id)sender;

- (IBAction) columnCountSliderChanged:(id)sender;
- (IBAction) numberOfCellsSliderChanged:(id)sender;

/* Shared Generic Delegate Methods - AQ and OH have a same named datasource method */

-(NSUInteger)numberOfItemsInGridView:(id)gridview;


@end
