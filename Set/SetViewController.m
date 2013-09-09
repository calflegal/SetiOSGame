//
//  SetViewController.m
//  Set
//
//  Created by H Calvin Flegal on 8/17/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//
#import "Toast+UIView.h"
#import "SetViewController.h"
#import "CardCollectionViewCell.h"
#import "SetGame.h"
#import "SetCardDeck.h"
#import "SetCollectionController.h"
#import "FoundSetsViewController.h"
#import "RemainingSetsViewController.h"

@interface SetViewController () <UICollectionViewDataSource,UICollectionViewDelegate,SetCollectionDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (strong,nonatomic)SetGame* game;
@property (nonatomic,weak)UIView* toast;
@property (weak, nonatomic) IBOutlet UIButton *showUnfoundButton;
@property (weak, nonatomic) IBOutlet UIButton *showFoundButton;

@end

@implementation SetViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood2.png"]]];
   // self.game.remainingSets;
    self.toast = [self.view makeToast:@"Select a Set" duration:3.0 position:@"center"];
    [self updateUI];
}
-(NSInteger)collectionView:(UICollectionView *)asker
    numberOfItemsInSection:(NSInteger)section {
    return [self.game.cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)asker
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.cardCollectionView
                                  dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    if ([cell isKindOfClass:[CardCollectionViewCell class]]) {
        SetCard* setCardatIndex = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:setCardatIndex];
    }
    return cell;
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showFoundSets"] || [[segue identifier] isEqualToString:@"showUnfound"]) {
        SetCollectionController* scc = (SetCollectionController*) segue.destinationViewController;
        scc.delegate = self;
    }
}

-(void)updateUI {
    for (UICollectionViewCell* cell in [self.cardCollectionView visibleCells]) {
        SetCard* card = [self.game cardAtIndex:[self.cardCollectionView indexPathForCell:cell].item];
        [self updateCell:cell usingCard:card];
    }
    [self.showUnfoundButton setTitle:[NSString stringWithFormat:@"Show unfound (%i)",[self.game.remainingSets count]] forState:UIControlStateNormal];
    [self.showFoundButton setTitle:[NSString stringWithFormat:@"Show found (%i)",[self.game.foundSets count]] forState:UIControlStateNormal];
  //  self.toast = [self.view makeToast:self.game.successString duration:1 position:@"center"];
}
-(NSArray*)sets {
    NSMutableArray* retArray = [[NSMutableArray alloc] init];
    if ([self.presentedViewController isKindOfClass:[FoundSetsViewController class]]) {
        for (NSSet *set in self.game.foundSets){
            //the array for each set
            NSArray* setAsArray = [set allObjects];
            for (SetCard* card in setAsArray) {
                [retArray addObject:card];
            }
            
        }
        return retArray;
    }
    else if ([self.presentedViewController isKindOfClass:[RemainingSetsViewController class]]) {
        for (NSSet* set in self.game.remainingSets) {
            NSArray* setAsArray = [set allObjects];
            for (SetCard* card in setAsArray) {
                [retArray addObject:card];
            }
        }
        return retArray;
    }
    else return nil;
    
}

- (IBAction)add3CardsPressed:(UIButton *)sender {
    NSUInteger addedCount = [self.game addCardswithCount:3];
    NSMutableArray* ip_array = [[NSMutableArray alloc] init];
    for (int i=0; i<addedCount; i++) {
        [ip_array addObject:[NSIndexPath indexPathForItem:([self.game.cards count]-1-i) inSection:0]];
    }
    [self.cardCollectionView insertItemsAtIndexPaths:ip_array];
    [self.cardCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:([self.game.cards count]-1) inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:true];
    [self updateUI];
}
- (IBAction)resetPressed:(id)sender {
    self.game = nil;
    [self.cardCollectionView reloadData];
    [self updateUI];
}
-(IBAction)flipCardwithTap:(UITapGestureRecognizer *)gesture {
    [self.toast removeFromSuperview];
    CGPoint tapPoint = [gesture locationInView:self.cardCollectionView];
    NSIndexPath* indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapPoint];
    if (indexPath) {
        NSArray* setFound = [self.game flipCardAtIndex:indexPath.item];
        if (nil != setFound && (![[setFound objectAtIndex:0] isEqualToNumber:[NSNumber numberWithInt:-1]])) {
            NSMutableArray* indexPatharray = [[NSMutableArray alloc] init];
            for (NSNumber* num in setFound) {
                [indexPatharray addObject:[NSIndexPath indexPathForItem:[num intValue] inSection:0]];
            }
            [self.cardCollectionView deleteItemsAtIndexPaths:indexPatharray];
        }
        //this encoding is a bit of a hack.
        else if ([[setFound objectAtIndex:0] isEqualToNumber:[NSNumber numberWithInt:-1]]) {
            self.toast = [self.view makeToast:@"That's not a set" duration:1.0 position:@"center"];
        }
        [self updateUI];
        
    }
}
-(SetGame*) game {
    if (!_game) _game = [[SetGame alloc] initUsingDeck:[[SetCardDeck alloc] init]];
    return _game;
}



@end
