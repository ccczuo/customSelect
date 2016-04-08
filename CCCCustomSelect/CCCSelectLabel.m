//
//  CCCSelectLabel.m
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import "CCCSelectLabel.h"

@implementation CCCSelectLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth =  2;
        [self addTapAction];
        self.isCLick = NO;
    }
    return self;
}

-(void)addTapAction
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle)];
    [self addGestureRecognizer:tap];
    
}

-(void)setIsCLick:(BOOL)isCLick
{
    _isCLick = isCLick;
    
    if(isCLick)
    {
        [self setHighlightedStatus];
    }
    else
    {
        [self setNormalStatus];
    }
    
}

-(void)tapHandle
{
  
    //点击取消时
    if(self.isCLick == YES)
    {
        [self setNormalStatus];
    }
    
    //点击选中时
    else
    {
        [self setHighlightedStatus];
    }
    
    self.isCLick = !self.isCLick;
    
    [self.clinicDele clinicTitle:self.text withClinicChoose:self.isCLick];
    
}

-(void)setNormalStatus
{
    
    self.textColor =[UIColor lightGrayColor];
   
    self.layer.borderColor=  [[UIColor lightGrayColor] CGColor];
    
}
-(void)setHighlightedStatus
{
    
    self.textColor =[UIColor cyanColor];
  
    self.layer.borderColor=  [[UIColor cyanColor] CGColor];
;
    
    
}


@end
