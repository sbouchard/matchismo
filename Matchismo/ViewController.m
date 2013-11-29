//
//  ViewController.m
//  Matchismo
//
//  Created by SBouchard on 10/24/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic) int flipCount;
@property (nonatomic) int numCard;
@property (strong, nonatomic) NSMutableArray *actionHistory;
@property (strong, nonatomic) UIImage *frontCardImg;
@property (strong, nonatomic) UIImage *backCardImg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl;


@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderCtrl;

- (IBAction)dealCards:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)segCtrlValueChanged:(id)sender;

@end

@implementation ViewController

-(int)numCard{
    if(!_numCard) _numCard = 2;
    return _numCard;
}

-(UIImage *)backCardImg{
    if(!_backCardImg) _backCardImg = [UIImage imageNamed:@"backcard.jpg"];
    return _backCardImg;
}

-(UIImage *)frontCardImg{
    if(!_frontCardImg) _frontCardImg = [UIImage imageNamed:@"dogcard.jpg"];
    return _frontCardImg;
}

-(CardMatchingGame *)game{
    
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            andNumberOfCardToMAtch:self.numCard
                                                         usingDeck:[[PlayingCardDeck alloc]init]];
    
    return _game;
}



-(void) setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(NSMutableArray *) actionHistory{
    if(!_actionHistory) _actionHistory = [[NSMutableArray alloc]init];
    return _actionHistory;
}


-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [[NSString alloc]initWithFormat:@"Flips : %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.segCtrl.enabled = NO;
     [self updateUI];
}

-(void)updateUI{
    
    for(UIButton* cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if(card.isFaceUp){
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(5,5,5,5)];
            [cardButton setImage:self.backCardImg forState:UIControlStateSelected|UIControlStateDisabled];
            [cardButton setImage:self.backCardImg forState:UIControlStateNormal];
        }else{
            [cardButton setImage:self.frontCardImg forState:UIControlStateNormal];
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(5,5,5,5)];
        }
        

    }
    
    self.lastActionLabel.text = self.game.lastAction;
    self.lastActionLabel.alpha = 1.0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", self.game.score];
    
    if(self.game.lastAction){
        [self.actionHistory addObject:self.game.lastAction];
     self.sliderCtrl.minimumValue = 0;
        self.sliderCtrl.maximumValue = [self.actionHistory count]-1;
        self.sliderCtrl.value = [self.actionHistory count]-1;
    }
}

- (IBAction)dealCards:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    self.actionHistory = nil;
    self.segCtrl.enabled = YES;
    [self updateUI];
}

- (IBAction)sliderValueChanged:(id)sender {
    
    if([self.actionHistory count]){
        UISlider *slider = (UISlider *)sender;
        NSInteger index = lround(slider.value);
        self.lastActionLabel.text = self.actionHistory[index];
        
        self.lastActionLabel.alpha=1.0;
        if(self.actionHistory[index] != [self.actionHistory lastObject]){
            self.lastActionLabel.alpha=0.3;
        }
    }
}

- (IBAction)segCtrlValueChanged:(id)sender {
    
    switch(self.segCtrl.selectedSegmentIndex){
       case 0:
            self.numCard = 2;
            [self dealCards:nil];
            break;
       case 1:
            self.numCard = 3;
            [self dealCards:nil];
            break;
    }
    
    self.segCtrl.enabled = NO;
}
@end
