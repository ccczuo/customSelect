//
//  ViewController.m
//  CCCCustomSelect
//
//  Created by 楚晨晨 on 16/4/7.
//  Copyright © 2016年 楚晨晨. All rights reserved.
//

#import "ViewController.h"
#import "VCMenuSelect.h"
#import "NSNotification+Extension.h"
@interface ViewController ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak) UIView *upView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 100, 200, 40);
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"开始筛选你的标签吧" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self  observeNotification:@"backData"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)handleNotification:(NSNotification *)notification{

    if ([notification is:@"backData"]) {
        
        NSArray *arr =notification.object;

        for (int i =0; i<arr.count; i++) {
            
            UILabel *la = [[UILabel alloc]initWithFrame: CGRectMake(10, 200+(40+10)*(i-1), 300, 40)];
            la.text = arr[i];
            la.tag = i+100;
            la.textAlignment = NSTextAlignmentCenter;
            
            [self.view addSubview:la];
        }
       
    }

}
- (void)actionBtn{
    for (UILabel *la in self.view.subviews) {
        if(la.tag>=100){
            [la removeFromSuperview];
       
        }
    }
     self.window = [[UIWindow alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width-50, self.view.frame.size.height)];
     self.window .backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.7];
     self.window .windowLevel = UIWindowLevelNormal;
     self.window .hidden = NO;
     self.window .userInteractionEnabled = YES;
    [ self.window  makeKeyAndVisible];
    VCMenuSelect *up = [[VCMenuSelect alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:up];
    up.view.frame = self.window.bounds;
    self.window.rootViewController = nav;
  [self.window makeKeyAndVisible];

    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    [self.view addSubview:view];
    self.upView = view;
    [up setCancleBarItemHandle:^{
        
        [self.upView removeFromSuperview];
        [self.window resignKeyWindow];
        self.window .hidden = YES;
        self.upView = nil;
    }];
    
}

- (void)tapAction{
    
    [self.upView removeFromSuperview];
    [self.window resignKeyWindow];
    self.window .hidden = YES;
    self.upView = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
