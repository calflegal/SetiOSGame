//
//  SetGame.h
//  SetGame
//
//  Created by H Calvin Flegal on 8/1/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "Deck.h"
#import "SetCard.h"

@interface SetGame : NSObject
-(id)initUsingDeck:(Deck *)deck;
-(SetCard*)cardAtIndex:(NSUInteger)index;
//indicies of found set or nil
-(NSArray*)flipCardAtIndex:(NSUInteger)index;
-(NSUInteger)addCardswithCount:(NSUInteger)count;
@property (nonatomic,strong)NSMutableArray* cards;
@property(nonatomic,readonly) NSString* successString;
@property(nonatomic,readonly)NSMutableSet* remainingSets;
@property(nonatomic,readonly)NSMutableSet* foundSets;

@end
