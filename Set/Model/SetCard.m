//
//  SetCard.m
//  SetGame
//
//  Created by H Calvin Flegal on 8/1/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard



+(NSUInteger)maxCount {
    return 3;
}
+(NSArray*)validColors {
    return @[[UIColor redColor],[UIColor blueColor],[UIColor colorWithRed:61/255.0f green:153/255.0f blue:61/255.0f alpha:1]];
}
+(NSArray*)validTextures {
    return @[@"open",@"solid",@"striped"];
}
+(NSArray *)validShapes {
    return @[@"squiggle",@"diamond",@"oval"];
}

@end
