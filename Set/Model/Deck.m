//
//  Deck.m
//  Machismo
//
//  Created by H Calvin Flegal on 5/23/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property(nonatomic,strong) NSMutableArray *cards; //of Cards

@end

@implementation Deck

-(NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
        return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop {
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }

    
}
-(Card *) drawRandomCard {
    Card* randomCard = nil;
    
    if ([self.cards count]) {
        unsigned rand = arc4random() % [self.cards count];
        randomCard = self.cards[rand];
        [self.cards removeObjectAtIndex:rand];
    }
    return randomCard;
}

@end
