//
//  ViewController.m
//  NewFeatureView
//
//  Created by xialan on 2019/6/28.
//  Copyright © 2019 xialan. All rights reserved.
//

#import "ViewController.h"
#import "SDNewFeatureView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dataArray = @[
                           @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2739077312,1503139555&fm=26&gp=0.jpg",
                           @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3991687160,3941821421&fm=26&gp=0.jpg",
                           @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2338525087,2869291470&fm=26&gp=0.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561721277041&di=33311b6245a0f769a8f54ed536c0cbdd&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201604%2F12%2F20160412020119_wGMPC.jpeg"
                           ];
   
    [SDNewFeatureView showNewFeatureView:dataArray view:self.view];
}


@end
