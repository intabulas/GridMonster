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
#import "MMGridViewDefaultCell.h"

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
    - (void) createTestData:(int)numberOfColumns;
    - (UIColor*) generateRandomColor;

@end

@implementation GridMonsterViewController
@synthesize gridControlNameLabel   = _gridControlNameLabel;
@synthesize gridControlNotesLabel  = _gridControlNotesLabel;
@synthesize gridControlLinkLabel   = _gridControlLinkLabel;
@synthesize gridContainer          = _gridContainer;
@synthesize gridColumnCountSlider  = _gridColumnCountSlider;

@synthesize aqGridButton = _aqGridButton;
@synthesize chGridButton = _chGridButton;
@synthesize mmGridButton = _mmGridButton;
@synthesize ohGridButton = _ohGridButton;

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
        
    _currentGrid = 2;
    
    [self createTestData:100];    
    
    [self setupAQGridView];
    
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

//- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//}

- (void) teardownActiveGrid {
    switch (_currentGrid) {
        case 0:
            [self tearDownAQGridView];
            break;
        case 1:
            [self tearDownCHGridView];
            break;
        case 2:
            [self tearDownMMGridView];
            break;
        case 3:            
            [self tearDownOHGridView];
            break;
            
        default:
            break;
    }
}

/* */
- (IBAction) changeGridToolkit:(id)sender {
    
    UIBarButtonItem *_gridTypeButton = (UIBarButtonItem*)sender;
    
    [self teardownActiveGrid];
    
    
    switch (_gridTypeButton.tag) {
        case 0:
            [self setupAQGridView];
            break;
        case 1:
            [self setupCHGridView];            
            break;
        case 2:
            [self setupMMGridView];            
            break;
        case 3:
            [self setupOHGridView];            
            break;
            
        default:
            break;
    }
    
    
}


- (void) createTestData:(int)numberOfColumns {
    _gridTestData = [[NSMutableArray alloc] init];      

    LoremIpsum *_loremGenerator = [[LoremIpsum alloc] init];
    for ( int x = 0; x < numberOfColumns; x++ ) {
        GridTestObject *_testObject = [[GridTestObject alloc] init];
        [_testObject setTestnumber:x];
        [_testObject setTestsentance:[_loremGenerator words:7]];
        [_testObject setTestcolor:[self generateRandomColor]];
        [_gridTestData addObject:_testObject];
        
        [_testObject release];
        
    }
    [_loremGenerator release];
    
}

- (UIColor*) generateRandomColor {
    float rand_max = RAND_MAX;
    
    float red   = arc4random() / rand_max;
    float green = arc4random() / rand_max;
    float blue  = arc4random() / rand_max;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (IBAction) openControlInSafari:(id)sender {
   [[ UIApplication sharedApplication ] openURL:[NSURL URLWithString:_gridControlLinkLabel.titleLabel.text]];    
}

- (IBAction) columnCountSliderChanged:(id)sender {
    
    [self createTestData:_gridColumnCountSlider.value];
    
    switch (_currentGrid) {
        case 0:
            [_aqGridView reloadData];
            break;
        case 1:
            [_chGridView reloadData];
            break;
        case 2:
            [_mmGridView reloadData];          
            break;
        case 3:
            [_ohGridView reloadData];          
            break;
            
        default:
            break;
    }    
    
    
}

#pragma mark =[ Grid Toolkit Helpers and Delegates ]=


#pragma mark ==< AQGridView >==
- (void) tearDownAQGridView {    
    [_aqGridButton setStyle:UIBarButtonItemStyleBordered];    
    [_aqGridView removeFromSuperview];
    [_aqGridView release], _aqGridView = nil;        
}

- (void) setupAQGridView {    
    
    [_aqGridButton setStyle:UIBarButtonItemStyleDone];    
    
    [_gridControlNameLabel   setText:@"AQGridView"];
    [_gridControlNotesLabel  setText:@""];  
    [_gridControlLinkLabel   setTitle:@"https://github.com/AlanQuatermain/AQGridView" forState:UIControlStateNormal];
    
    _aqGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0,0,_gridContainer.bounds.size.width,_gridContainer.bounds.size.height)];
    [_aqGridView setDelegate:self];
    [_aqGridView setDataSource:self];
    [_aqGridView setBackgroundColor:[UIColor clearColor]];
    [_aqGridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    [_gridContainer addSubview:_aqGridView];

    _currentGrid = 0;    
    [_aqGridView reloadData];
}

/* AQGridView Datasource Methods */

/* USES A GENERIC HANDLER FOR numberOfItemsInGridView */

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index {
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";

    GridTestObject *_testObject = [_gridTestData objectAtIndex:index];

    AQGridViewCell * cell = (AQGridViewCell *)[gridView dequeueReusableCellWithIdentifier: PlainCellIdentifier];
	if ( cell == nil ) {
		cell = [[[AQGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0) reuseIdentifier: PlainCellIdentifier] autorelease];
		[cell.contentView setBackgroundColor:[_testObject testcolor]];
	}
    
    return ( cell );
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
    [_chGridButton setStyle:UIBarButtonItemStyleBordered];    
    [_chGridView removeFromSuperview];
    [_chGridView release], _chGridView = nil;        
}

- (void) setupCHGridView {    
    
    [_chGridButton setStyle:UIBarButtonItemStyleDone];    
    
    [_gridControlNameLabel   setText:@"CHGridView"];   
    [_gridControlNotesLabel  setText:@""];
    [_gridControlLinkLabel   setTitle:@"https://github.com/camh/CHGridView" forState:UIControlStateNormal];    
    
    _chGridView = [[CHGridView alloc] initWithFrame:CGRectMake(0,0,_gridContainer.bounds.size.width,_gridContainer.bounds.size.height)];
    [_chGridView setDelegate:self];
    [_chGridView setDataSource:self];
    [_chGridView setBackgroundColor:[UIColor clearColor]];
    [_chGridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];    
    [_gridContainer addSubview:_chGridView];
    
    _currentGrid = 1;
    [_chGridView reloadData];
}

/* CHGridView Datasource */
- (int)numberOfTilesInSection:(int)section GridView:(CHGridView *)gridView {
    return _gridTestData.count;
}

- (CHTileView *)tileForIndexPath:(CHGridIndexPath)indexPath inGridView:(CHGridView *)gridView {
	static NSString *TileIndentifier = @"Tile";

    GridTestObject *_testObject = [_gridTestData objectAtIndex:indexPath.tileIndex];

	CHTileView *tile = (CHTileView *)[gridView dequeueReusableTileWithIdentifier:TileIndentifier];
    
	if(tile == nil)
		tile = [[[CHTileView alloc] initWithFrame:CGRectZero reuseIdentifier:TileIndentifier] autorelease];
    
	[tile setContentBackgroundColor:_testObject.testcolor];
    
	return tile;
}

// optional
- (int)numberOfSectionsInGridView:(CHGridView *)gridView {
    return 1;
}
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
    [_mmGridButton setStyle:UIBarButtonItemStyleBordered];        
    
    [_mmGridView removeFromSuperview];
    [_mmGridView release], _mmGridView = nil;    
}

- (void) setupMMGridView {    
    
    [_mmGridButton setStyle:UIBarButtonItemStyleDone];    
    
    [_gridControlNameLabel   setText:@"MMGridView"];    
    [_gridControlNotesLabel  setText:@"This grid view scrolls left to right vs up and down"];
    [_gridControlLinkLabel   setTitle:@"https://github.com/provideal/MMGridView" forState:UIControlStateNormal];        
    
    _mmGridView = [[MMGridView alloc] initWithFrame:CGRectMake(0,0,_gridContainer.bounds.size.width,_gridContainer.bounds.size.height)];
    [_mmGridView setDelegate:self];
    [_mmGridView setDataSource:self];
    [_mmGridView setBackgroundColor:[UIColor clearColor]];
    [_gridContainer addSubview:_mmGridView];
    
    _currentGrid = 2;
    [_mmGridView reloadData];
}


/* MMGridView Datasource */

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView {
    return _gridTestData.count;
}

- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index {    
    
    GridTestObject *_testObject = [_gridTestData objectAtIndex:index];
    
    MMGridViewDefaultCell *cell = [[[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull] autorelease];
    cell.textLabel.text = [_testObject testsentance];
    [cell.backgroundView setBackgroundColor:[_testObject testcolor]];
    return cell;    
   
}

/* MMGridView Delegate - ALL OPTIONAL */

//- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index {
//}
//
//- (void)gridView:(MMGridView *)gridView didDoubleTappedCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index {    
//}

/* MMGrid View marks this optional but doesn't check it delegate respondes to it */
- (void)gridView:(MMGridView *)gridView changedPageToIndex:(NSUInteger)index {    
}



#pragma mark ==< OHGridView >==
- (void) tearDownOHGridView {    
    [_ohGridButton setStyle:UIBarButtonItemStyleBordered];        
    
    [_ohGridView removeFromSuperview];
    [_ohGridView release], _ohGridView = nil;    
    
}

- (void) setupOHGridView {    
    
    [_ohGridButton setStyle:UIBarButtonItemStyleDone];    
    
    [_gridControlNameLabel   setText:@"OHGridView"];    
    [_gridControlNotesLabel  setText:@""];
    [_gridControlLinkLabel   setTitle:@"https://github.com/AliSoftware/OHGridView" forState:UIControlStateNormal];        

    _ohGridView = [[OHGridView alloc] initWithFrame:CGRectMake(0,0,_gridContainer.bounds.size.width,_gridContainer.bounds.size.height)];
    [_ohGridView setDelegate:self];
    [_ohGridView setDataSource:self];
    [_ohGridView setBackgroundColor:[UIColor clearColor]];
    [_ohGridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];    
    [_gridContainer addSubview:_ohGridView];  
    
    _currentGrid = 3;    
    [_ohGridView reloadData];
}


/* OHGridView Datasource */

/* USES A GENERIC HANDLER FOR numberOfItemsInGridView */

-(OHGridViewCell*)gridView:(OHGridView*)aGridView cellAtIndexPath:(NSIndexPath*)indexPath {
	NSUInteger _index = [aGridView indexForIndexPath:indexPath];

    GridTestObject *_testObject = [_gridTestData objectAtIndex:_index];
    
	OHGridViewCell* cell = [aGridView dequeueReusableCell];
	if (!cell) {
		cell = [OHGridViewCell cell];
        
		cell.backgroundColor = [_testObject testcolor];
	}
    
	cell.textLabel.text = [_testObject testsentance];
    
	return cell;  
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
