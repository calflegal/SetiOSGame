//
//  SetCardDeck.m
//  SetGame
//
//  Created by H Calvin Flegal on 8/1/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
-(id)init {
    self = [super init];
    //return nil if you got nil!
    if (self) {
        for (NSString* shape in [SetCard validShapes]) {
            for (int count = 1; count <= [SetCard maxCount]; count++) {
                for (NSString* t in [SetCard validTextures]) {
                    for (UIColor* c in [SetCard validColors]) {
                        SetCard* card = [[SetCard alloc] init];
                        card.count = count;
                        card.shape = shape;
                        card.color = c;
                        card.texture = t;
                        card.contents = [card.shape stringByPaddingToLength:count withString:card.shape startingAtIndex:0];
                        [self addCard:card atTop:YES];
                        
                    }
                }
                
            }
        }
        
    }
    return self;
}

@end
