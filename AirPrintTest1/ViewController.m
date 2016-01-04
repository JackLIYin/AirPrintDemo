//
//  ViewController.m
//  AirPrintTest1
//
//  Created by NaiveVDisk on 16/1/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    [self.view addSubview:Btn];
    Btn.tag = 0;
    [Btn setTitle:@"printView" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *Btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    [self.view addSubview:Btn1];
    Btn1.tag = 1;
    [Btn1 setTitle:@"printItem" forState:UIControlStateNormal];
    [Btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn:(UIButton*) Btn{
    if (Btn.tag) {
        [self printItem];
    }
    else{
        [self printView];
    }
    NSLog(@"clickBtn!");
}

//将需要打印的视图加载到相应的printingItem中打印,多个图片则加入 数组printingItems中
- (void)printItem{
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    UIPrintInteractionCompletionHandler completionHandle = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError * __nullable error){
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
        }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"清纯美女";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printController.printInfo = printInfo;
    printController.showsPageRange = YES;
    printController.printingItem = [UIImage imageNamed:@"005.jpg"];
    
    [printController presentAnimated:YES completionHandler:completionHandle];
}


//将需要打印的视图加载到相应的view中打印
- (void)printView{
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    UIPrintInteractionCompletionHandler completionHandle = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError * __nullable error){
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
        }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"清纯美女";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printController.printInfo = printInfo;
    printController.showsPageRange = YES;
    
    UIPrintPageRenderer *myRenderer = [[UIPrintPageRenderer alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    UIViewPrintFormatter *viewFormatter = [imageView viewPrintFormatter];
    [myRenderer addPrintFormatter:viewFormatter startingAtPageAtIndex:0];
    // Set our custom renderer as the printPageRenderer for the print job.
    printController.printPageRenderer = myRenderer;
    
    [printController presentAnimated:YES completionHandler:completionHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
