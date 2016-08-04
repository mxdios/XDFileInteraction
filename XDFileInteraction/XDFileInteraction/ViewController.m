//
//  ViewController.m
//  XDFileInteraction
//
//  Created by miaoxiaodong on 16/8/4.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "QLViewController.h"
#import "InteractionViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURL *_textUrl;
    UITableView *_tableView;
    NSArray *_datas;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textUrl = [[NSBundle mainBundle] URLForResource:@"Swift知识点.pdf" withExtension:nil];
    _datas = @[@"QuickLook预览+打印操作", @"webView预览+文件交互操作", @"预览功能"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[QLViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[InteractionViewController alloc] init] animated:YES];
            break;
        case 2:
            [self openClick];
            break;
        default:
            break;
    }
}


- (void)openClick
{
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:_textUrl];
    documentController.delegate = self;
    [documentController presentPreviewAnimated:YES];
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.view.frame;
}
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
    NSLog(@"预览关闭");
}
@end
