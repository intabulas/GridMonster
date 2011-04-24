//
//  GridMonsterViewController.m
//  GridMonster
//
//  Created by Mark Lussier on 4/23/11.
//  Copyright 2011 Juniper Networks, Inc. All rights reserved.
//

#import "GridMonsterViewController.h"

#import "AQGridView.h"
#import "AQGridViewCell.h"

#import "CHGridView.h"
#import "OHGridView.h"

#import "MMGridView.h"
#import "MMGridViewCell.h"

#import "GridTestObject.h"
#import "LoremIpsum.h"

@interface GridMonsterViewController (Private)

    // AQGridView
    - (void) tearDownAQGridView;
    - (void) setupAQGridView;

    // CHGridView
    - (void) tearDownCHGridView;
    - (void) setupCHGridView;

    // MMGridView
    - (void) tearDownMMGridView;
    - (void) setupMMGridView;

    // OHGridView
    - (void) tearDownOHGridView;
    - (void) setupOHGridView;

    // Test Data
    - (void) createTestData;

@end

@implementation GridMonsterViewController

- (void)dealloc {
    [_aqGridView release];
    [_chGridView release];    
    [_mmGridView release];    
    [_ohGridView release]; 
    
    [_gridTestData release];  
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTestData];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

/* */
- (IBAction) changeGridToolkit:(id)sender {
    
    UIBarButtonItem *_gridTypeButton = (UIBarButtonItem*)sender;
    
    switch (_gridTypeButton.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
            
        default:
            break;
    }
    
    
}


- (void) createTestData {
    _gridTestData = [[NSMutableArray alloc] init];      

    LoremIpsum *_loremGenerator = [[LoremIpsum alloc] init];
    for ( int x = 0; x < 100; x++ ) {
        GridTestObject *_testObject = [[GridTestObject alloc] init];
        [_testObject setTestnumber:x];
      //  [_testObject setTestsentance:[_loremGenerator words:10];
        [_gridTestData addObject:_testObject];
        
        [_testObject release];
        
    }
    [_loremGenerator release];
    
}



#pragma mark =[ Grid Toolkit Helpers and Delegates ]=


#pragma mark ==< AQGridView >==
- (void) tearDownAQGridView {    
    [_aqGridView removeFromSuperview];
    [_aqGridView release], _aqGridView = nil;        
}

- (void) setupAQGridView {    
    [_aqGridView removeFromSuperview];
    [_aqGridView release], _aqGridView = nil;    
}

/* AQGridView Datasource Methods */

/* USES A GENERIC HANDLER FOR numberOfItemsInGridView */

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index {
    return nil; 
}

/* AQGridView Delegte Methods - ALL OPTIONS IN AQGRIDVIEW */
//- (void) gridView: (AQGridView *) gridView willDisplayCell: (AQGridViewCell *) cell forItemAtIndex: (NSUInteger) index {    
//}
//
//// Called before selection occurs. Return a new index, or NSNotFound, to change the proposed selection.
//- (NSUInteger) gridView: (AQGridView *) gridView willSelectItemAtIndex: (NSUInteger) index {    
//}
//
//- (NSUInteger) gridView: (AQGridView *) gridView willSelectItemAtIndex: (NSUInteger) index numFingersTouch:(NSUInteger) numFingers {    
//}
//
//- (NSUInteger) gridView: (AQGridView *) gridView willDeselectItemAtIndex: (NSUInteger) index {    
//}
//
//// Called after the user changes the selection
//- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index {    
//}
//
//- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index numFingersTouch:(NSUInteger)numFingers {    
//}
//
//- (void) gridView: (AQGridView *) gridView didDeselectItemAtIndex: (NSUInteger) index {
//}




#pragma mark ==< CHGridView >==
- (void) tearDownCHGridView {    
    [_chGridView removeFromSuperview];
    [_chGridView release], _chGridView = nil;        
}

- (void) setupCHGridView {    
}

/* CHGridView Datasource */
- (int)numberOfTilesInSection:(int)section GridView:(CHGridView *)gridView {
    return _gridTestData.count;
}

- (CHTileView *)tileForIndexPath:(CHGridIndexPath)indexPath inGridView:(CHGridView *)gridView {
    return nil;    
}

// optional
//- (int)numberOfSectionsInGridView:(CHGridView *)gridView {
//    return 1;
//}
//
//- (NSString *)titleForHeaderOfSection:(int)section inGridView:(CHGridView *)gridView {    
//}

/* CHGridView Delegate Methods - ALL OPTIONAL */

//- (void)selectedTileAtIndexPath:(CHGridIndexPath)indexPath inGridView:(CHGridView *)gridView {    
//}
//
//- (void)visibleTilesChangedTo:(int)tiles {    
//}
//
//- (CGSize)sizeForTileAtIndex:(CHGridIndexPath)indexPath inGridView:(CHGridView *)gridView {    
//}
//
//- (CHSectionHeaderView *)headerViewForSection:(int)section inGridView:(CHGridView *)gridView {    
//}


#pragma mark ==< MMGridView >==
- (void) tearDownMMGridView {    
    [_mmGridView removeFromSuperview];
    [_mmGridView release], _mmGridView = nil;    
}

- (void) setupMMGridView {    
}


/* MMGridView Datasource */

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView {
    return _gridTestData.count;
}

- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index {    
    return nil;    
}

/* MMGridView Delegate - ALL OPTIONAL */

//- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index {
//}
//
//- (void)gridView:(MMGridView *)gridView didDoubleTappedCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index {    
//}
//
//- (void)gridView:(MMGridView *)gridView changedPageToIndex:(NSUInteger)index {    
//}



#pragma mark ==< OHGridView >==
- (void) tearDownOHGridView {    
    [_ohGridView removeFromSuperview];
    [_ohGridView release], _ohGridView = nil;    
    
}

- (void) setupOHGridView {    
}


/* OHGridView Datasource */

/* USES A GENERIC HANDLER FOR numberOfItemsInGridView */

-(OHGridViewCell*)gridView:(OHGridView*)aGridView cellAtIndexPath:(NSIndexPath*)indexPath {
    return nil;    
}

/* OHGridView Delegate - ALL ARE OPTIONAL */

-(void)gridView:(OHGridView*)aGridView willDisplayCell:(OHGridViewCell*)aCell forIndexPath:(NSIndexPath*)indexPath {    
}

-(void)gridView:(OHGridView*)aGridView willSelectCellAtIndexPath:(NSIndexPath*)indexPath {    
}

-(void)gridView:(OHGridView*)aGridView didSelectCellAtIndexPath:(NSIndexPath*)indexPath {    
}


/* Shared Generic Delegate Methods - AQ and OH have a same named datasource method */

-(NSUInteger)numberOfItemsInGridView:(id)gridview {
    return _gridTestData.count;    
}


@end
