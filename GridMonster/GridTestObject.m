//
//  GridTestObject.m
//  GridMonster
//
//  Created by Mark Lussier on 4/23/11.
//  Copyright 2011 Juniper Networks, Inc. All rights reserved.
//

#import "GridTestObject.h"


@implementation GridTestObject
@synthesize testnumber   = _testnumber;
@synthesize testsentance = _testsentance;
@synthesize testcolor    = _testcolor;

- (void) dealloc {
    [_testsentance release], _testsentance = nil;
    [_testcolor release], _testcolor = nil;
    [super dealloc];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"<GridTestObject: number:%d sentence:%@>", _testnumber, _testsentance];
}


@end
