//
//  Deck.h
//  Machismo
//
//  Created by H Calvin Flegal on 5/23/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

@end
