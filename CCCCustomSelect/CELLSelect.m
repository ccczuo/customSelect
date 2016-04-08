//
//  CELLSelect.m
//  JDSelectDemo
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import "CELLSelect.h"
#import "CCCSelectLabel.h"
#import "NSNotification+Extension.h"
@interface MCELLSelect()

@end
@implementation MCELLSelect
- (instancetype)init{

    self  = [super init ];
    if (self) {
        
        self.selectArr = [NSMutableArray array];
    }

    return self;
}


@end
@interface CELLSelect()<SeleLableDele>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation CELLSelect
- (void)onint{
    self.titleArray = [NSMutableArray array];
    self.titleLabel = [[UILabel alloc]init];
    
    [self addSubview:self.titleLabel];
    
    [self observeNotification:@"CCC"];
    
}
- (void)setSelctedBlock:(Block)block{

    self.block = block;
}
- (void)handleNotification:(NSNotification *)notification{
    if ([notification is:@"CCC"]) {
        
    self.block(self.titleArray);

    }

    [self.titleArray removeAllObjects];
}
- (void)updateData{
    self.arr = [NSMutableArray array];
    self.titleLabel.text = self.data.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.data.arrLabel>0) {
        for (int i =0; i<self.data.arrLabel.count; i++) {
            
            CCCSelectLabel *lable = [[CCCSelectLabel alloc]init];
            lable.text = self.data.arrLabel[i];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor grayColor];
            lable.tag = 10000 + i;
            lable.clinicDele = self;
            [self addSubview:lable];
            [self.arr addObject:lable];
        }
    }
    [self refresh];
}



-(void)clinicTitle:(NSString *)title withClinicChoose:(BOOL)isChoose;
{

    
    
    switch (self.data.seleType) {
            
        case CL_SeleType_Radio:
            
            [self handleInRadioIndex:title];
            
            break;
            
        case CL_SeleType_CheckBoxes:
            
            [self handleInCheckBoxIndex:title withClinicChoose:isChoose];
            
            break;
      
            
        default:
            break;
    }
    
    

    
    
    
    for (int i = 0 ;  i < self.data.arrLabel.count; i ++) {
        
        CCCSelectLabel *lable = [self viewWithTag:(i + 10000)];
        
        if ([self.titleArray containsObject:[self.data.arrLabel objectAtIndex:i]]) {
            
            lable.isCLick = YES;
            
            continue;
        }
        lable.isCLick = NO;
        
    }
    
}

#pragma mark ---  Radio处理
-(void)handleInRadioIndex:(NSString *)titleName
{
    [self changeTheBorderToNormalInRadio];
    
    [self addTheLableInStoreArray:titleName];
   }

-(void)changeTheBorderToNormalInRadio
{
    
    [self.titleArray removeAllObjects];
}


-(void)addTheLableInStoreArray:(NSString *)titleName
{
    
    
    [self.titleArray addObject:titleName];
}



#pragma mark ---  CheckBox 处理
-(void)handleInCheckBoxIndex:(NSString *)titleName withClinicChoose:(BOOL)isChoose
{
    
    //如果是选择,加入数组
    if(isChoose)
    {
        //判断是不是重复选择
            BOOL isValue = [self.titleArray containsObject:titleName];
        
            if (isValue) {
    
                return;
            }
 
        
        [self.titleArray addObject:titleName];
        
    }
    else
    {
        [self.titleArray removeObject:titleName];
    }
    
}


- (void)refresh{
//    [super layoutSubviews];
    CGRect r = self.titleLabel.frame;
    r.origin.x= self.center.x-50;
    r.origin.y = 10;
    r.size.width = 100;
    r.size.height = 30;
    self.titleLabel.frame = r;
    CGRect r0;
    r0.size.width=(self.frame.size.width-2*20-15*(3-1))/3;
    r0.size.height = 30;
    int a  =0;
    
    if (self.arr>0) {
        
        
        
        for(int i=0;i<self.arr.count;i ++) {
            
            UILabel *la =  (UILabel *)self.arr[i];
           
            CGRect r = la.frame;
            if (CGRectGetMaxX(r0)+25+r0.size.width>self.frame.size.width) {
                r.origin.y= CGRectGetMaxY(r0)+5;
                r.origin.x = 20;
                a++;
            }else {
                if (i==0) {
                    r.origin.y =5+40;
                    r.origin.x = 20;
                    
                }else {
                    r.origin.x =CGRectGetMaxX(r0)+15;
                    r.origin.y =r0.origin.y;
                    
                }
                
              
                
            }
            
            r.size.width =r0.size.width;
            r.size.height = 30;
            la.frame =r;
            r0 = r;
            
        }
        
        self.data.cellHeight = CGRectGetMaxY(r0)+20;
//        [self onint];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
