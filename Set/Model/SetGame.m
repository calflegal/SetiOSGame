
//
//  SetGame.m
//  SetGame
//
//  Created by H Calvin Flegal on 8/1/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "SetGame.h"
#import "SetCardDeck.h"
@interface SetGame()
@property (nonatomic,strong)NSMutableSet* selectedCards;
@property (nonatomic)NSString* successString;
@property(nonatomic)int score;
@property(nonatomic)NSMutableSet* remainingSets;
@property(nonatomic)NSMutableSet* foundSets;
@property (nonatomic,strong)SetCardDeck* deck;

@end

@implementation SetGame

-(NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initUsingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i=0; i< 12; i++) {
            Card* card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    if ([deck isKindOfClass:[SetCardDeck class]]) {
            self.deck = (SetCardDeck*)deck;
    }
    return self;
}
-(NSMutableSet*)remainingSets {
    
        _remainingSets = [[NSMutableSet alloc] init];
        for (int i=0; i<[self.cards count]; i++) {
            for (int j=i+1; j<[self.cards count]; j++) {
                for (int k=j+1; k<[self.cards count]; k++) {
                    SetCard* firstCard = [self.cards objectAtIndex:i];
                    SetCard* secondCard = [self.cards objectAtIndex:j];
                    SetCard* thirdCard = [self.cards objectAtIndex:k];
                    if ([self scoreSelection:[NSSet setWithArray:@[firstCard,secondCard,thirdCard]]]) {
                        [_remainingSets addObject:[[NSSet alloc] initWithArray:@[firstCard,secondCard,thirdCard]]];
                    }
                }
            }
        }
    return _remainingSets;
}
-(NSMutableSet*)selectedCards {
    if (!_selectedCards) {
        _selectedCards = [[NSMutableSet alloc] init];
        
    }
    return _selectedCards;
}
-(NSMutableSet*)foundSets {
    if (!_foundSets)
        _foundSets = [[NSMutableSet alloc] init];
    return _foundSets;
}
-(NSString*)successString {
    if (!_successString) {
        _successString = @"Select a set";
    }
    return _successString;
}

-(NSArray*)flipCardAtIndex:(NSUInteger)index {
    NSMutableArray* retArray = nil;
    //bit of extra code here since changing selected cards
    //from array to set
    SetCard* card = [self cardAtIndex:index];
    card.faceUp = !card.isFaceUp;
    if ([self.selectedCards count] < 3) {
        if ([self.selectedCards containsObject:card]) {
            [self.selectedCards removeObject:card];
        }
        else {
            [self.selectedCards addObject:card];
            
        }
    
    }
    if ([self.selectedCards count] == 3) {
        
        
        //if it is a set.
        
        if ([self scoreSelection:self.selectedCards] == YES) {
            //prepare the indicies of cards to pull.
            retArray = [[NSMutableArray alloc] init];
            for (SetCard* card in self.selectedCards) {
                [retArray addObject:[NSNumber numberWithInt:[self.cards indexOfObject:card
                                    ]]];
                [self.cards removeObject:card];
            }
            self.successString = @"Set found!";
            [self.foundSets addObject:[self.selectedCards copy]];
            if ([self.remainingSets containsObject:self.selectedCards] ) {
                [self.remainingSets removeObject:self.selectedCards];
            }
        }
        else {
            self.successString = @"That's not a set";
            //careful this part is a little magic number ish
            retArray = [@[[NSNumber numberWithInt:-1]] mutableCopy];
        }
        for (SetCard* selCard in self.selectedCards) {
            
            selCard.faceUp = !selCard.isFaceUp;
            
        }
        [self.selectedCards removeAllObjects];
    }
    return retArray;
}
-(SetCard*) cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}
-(NSUInteger)addCardswithCount:(NSUInteger)count {
    NSMutableArray* drawnCards = [[NSMutableArray alloc] init];
    for (int i=0; i<count; i++) {
        SetCard* card =(SetCard*)[self.deck drawRandomCard];
        if (nil != card) {
            [drawnCards addObject:card];
        }
    }
    self.cards = [[self.cards arrayByAddingObjectsFromArray:drawnCards ] mutableCopy];
    return [drawnCards count];
}
-(BOOL)scoreSelection:(NSSet*)selectedCardsSet{
    BOOL isSet;
    isSet =YES;
    NSMutableSet* textures = [[NSMutableSet alloc] init];
    NSMutableSet* shapes = [[NSMutableSet alloc] init];
    NSMutableSet* counts =[[NSMutableSet alloc] init];
    NSMutableSet* colors = [[NSMutableSet alloc] init];
    NSArray* setArray = @[textures,shapes,counts,colors];
    for (SetCard* card in selectedCardsSet) {
        [textures addObject:card.texture];
        [shapes addObject:card.shape];
        [counts addObject:[NSNumber numberWithInt:card.count]];
        [colors addObject:card.color];
        
    }
    for (NSSet* set in setArray) {
        if ([set count] != 1 && [set count] != 3) {   
            isSet = NO;
        }
    }
    return isSet;
}

@end
