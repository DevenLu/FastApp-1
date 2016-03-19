//
//  FSPersonCenterViewController.m
//  FastApp
//
//  Created by tangkunyin on 16/3/8.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import "FSPersonCenterViewController.h"
#import "FSWebViewController.h"
#import "FSServerCommunicator.h"

@interface FSPersonCenterViewController ()
@property (nonatomic, strong) UIButton *loadDataBtn;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation FSPersonCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说IT"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(webViewControllerTest)];

    
    
    [PositionTools layView:self.textView atCenterOfView:self.view maxSize:CGSizeMake(300, 200) margins:0];
    [PositionTools layView:self.loadDataBtn outsideView:self.textView type:MiddleBottom maxSize:CGSizeMake(120, 60) offset:CGSizeMake(0, 30)];
}

//服务器请求演示，带进度的
- (void)loadDataTest
{
    FSServerCommunicator *serverReq = [[FSServerCommunicator alloc] init];
    __weak typeof(self) weakSelf = self;
    [serverReq doGetWithUrl:@"http://goodidea-big.qiniudn.com/screenclean.swf"
                     respObj:nil
                    progress:^(NSProgress *progress) {
                        NSString *completed = [NSString stringWithFormat:@"已完成：%.2f%%",progress.fractionCompleted * 100];
                        [MBProgressHUD showProgress:progress.fractionCompleted
                                            message:completed
                                               mode:MBProgressHUDModeDeterminateHorizontalBar];
                 }completion:^(BOOL success, id respData) {
                     if (success) {
                         [MBProgressHUD showMessage:@"响应完成" completion:^{
                             weakSelf.textView.text = [NSString stringWithFormat:@"%@",respData];
                         }];
                     }
    }];
}

- (void)webViewControllerTest
{
    FSWebViewController *webVC = [[FSWebViewController alloc] initWithTitle:@"关注技术和人文的原创IT博客" webUrl:API_SERVER_URL];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - getters
- (UIButton *)loadDataBtn
{
    if (!_loadDataBtn) {
        _loadDataBtn  = [UICreator createButtonWithTitle:@"下载开始"
                                              titleColor:FSWhiteColor
                                                    font:SysFontWithSize(14)
                                                  target:self
                                                  action:@selector(loadDataTest)];
        _loadDataBtn.backgroundColor = FSOrangeColor;
        _loadDataBtn.layer.cornerRadius = 5;
    }
    return _loadDataBtn;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [UICreator createTextViewWithAttrString:nil editEnable:NO scroolEnable:YES];
        _textView.backgroundColor = FSlightGrayColor;
    }
    return _textView;
}

@end
