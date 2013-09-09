//
//  FoundSetsController.m
//  Set
//
//  Created by H Calvin Flegal on 9/4/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "SetCollectionController.h"
#import "SetCardView.h"
#import "CardCollectionViewCell.h"
#import "SetCard.h"


@interface SetCollectionController ()




@end

@implementation SetCollectionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)asker
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.cardCollectionView
                                  dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    if ([cell isKindOfClass:[CardCollectionViewCell class]]) {
        SetCard* setCardatIndex = [[self.delegate sets] objectAtIndex:(3*indexPath.section+indexPath.item)];
        [self updateCell:cell usingCard:setCardatIndex];
        return cell;
    }
    else return nil;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"%i",[[self.delegate sets] count]);
    return [[self.delegate sets] count]/3;
}
-(NSInteger)collectionView:(UICollectionView *)asker
    numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(SetCard *)card
{
    if ([cell isKindOfClass:[CardCollectionViewCell class]]) {
        SetCardView *scv = ((CardCollectionViewCell*)cell).setCard;
        scv.count = card.count;
        scv.color = card.color;
        scv.texture = card.texture;
        scv.shape = card.shape;
        scv.isSelected = card.isFaceUp;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DismissPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:TRUE completion:nil];
}

@end
