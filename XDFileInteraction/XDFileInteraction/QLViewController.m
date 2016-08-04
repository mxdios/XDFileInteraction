//
//  QLViewController.m
//  XDFileInteraction
//
//  Created by miaoxiaodong on 16/8/4.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "QLViewController.h"
#import <QuickLook/QuickLook.h>

@interface QLViewController ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource>
{
    NSURL *_textUrl;
}
@end

@implementation QLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textUrl = [[NSBundle mainBundle] URLForResource:@"Swift知识点.pdf" withExtension:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(putBtnClick)];

    QLPreviewController *previ = [[QLPreviewController alloc] init];
    previ.view.frame = self.view.bounds;
    previ.delegate = self;
    previ.dataSource = self;
    [self.view addSubview:previ.view];
}
- (void)putBtnClick
{
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.jobName = _textUrl.lastPathComponent;
    printInfo.outputType = UIPrintInfoOutputGeneral;
    
    UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
    print.printInfo = printInfo;
    print.printingItem = _textUrl;
    
    [print presentAnimated:true completionHandler:^(UIPrintInteractionController * _Nonnull printInteractionController, BOOL completed, NSError * _Nullable error) {
        if (!error) {
            
        }
    }];
}

//实现代理方法
#pragma mark - 在此代理处加载需要显示的文件
- (NSURL *)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    return _textUrl;
}
#pragma mark - 返回文件的个数
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}
@end
