//
//  InteractionViewController.m
//  XDFileInteraction
//
//  Created by miaoxiaodong on 16/8/4.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "InteractionViewController.h"

@interface InteractionViewController ()<UIDocumentInteractionControllerDelegate>
{
    NSURL *_textUrl;
}
@end

@implementation InteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _textUrl = [[NSBundle mainBundle] URLForResource:@"Swift知识点.pdf" withExtension:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(openClick)];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:_textUrl];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)openClick
{
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:_textUrl];
    documentController.delegate = self;
    [documentController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
}





@end
