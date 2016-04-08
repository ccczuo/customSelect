//
//  CCCSelectLabel.h
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SeleLableDele <NSObject>

-(void)clinicTitle:(NSString *)title withClinicChoose:(BOOL)isChoose;

@end

@interface CCCSelectLabel : UILabel

@property (nonatomic,assign) BOOL isCLick;

@property (nonatomic,assign) id<SeleLableDele> clinicDele;


@end
