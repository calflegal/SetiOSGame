//
//  Card.m
//  Machismo
//
//  Created by H Calvin Flegal on 3/18/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "Card.h"

@implementation Card
-(int)match:(NSArray *)otherCards {
    int score = 0;
    for (Card* card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
-(NSString *)description {
    return self.contents;
}

@end
