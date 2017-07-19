//
//  SecondViewController.m
//  TianQi
//
//  Created by liyi on 14-9-7.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
               
    }
    return self;
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"0.jpg"]];    
   imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
   titleArr = [[NSMutableArray alloc]initWithObjects: @"日期", @"城市",@"风向",@"风",@"天气" ];
   keyArr = [[NSMutableArray alloc]initWithObjects:@"days", @"citynm",@"winp",@"wind",@"weather"];

    for (int i=0;i<5;i++){
        UILabel *titltLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 130 + i * 30, 310, 20)];
        titltLabel.tag = 1000 + i;
        titltLabel.backgroundColor= [UIColor clearColor];
        [self.view addSubview:titltLabel];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(200, 280, 50, 30);
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"lll" object:nil];//监听名为@"lll"的通知，收到通知时会执行showInfo:方法

}


-(void)onClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//显示信息
- (void)showInfo:(NSNotification *)notification {
  
    NSString *cityId = [notification object];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.today&weaid=%@&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json",cityId];
    [manager POST:urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = responseObject;
       
        if (dic) {
            NSDictionary *dataDic = [dic objectForKey:@"result"];
        
            //取出label
            for (int i=0;i<titleArr.count;i++){
                
                UILabel *titltLabel = [self.view viewWithTag:1000 + i];
                NSString *titleStr = [titleArr objectAtIndex:i];
                NSString *keyStr = [keyArr objectAtIndex:i];
                titltLabel.text = [NSString stringWithFormat:@"%@：%@", titleStr,[dataDic objectForKey:keyStr]];
                
            }
        }
            

        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        
        NSLog(@"获取验证码 ＝ %@",error);
    }];

    
 }


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
