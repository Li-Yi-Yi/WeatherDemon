//
//  MainViewController.m
//  TianQi
//
//  Created by liyi on 14-9-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];//这本身就是一种初始化方法
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 40)/2, 300, 40, 20);
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //建了一个pickView
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -320)/2, 10, 0, 0)];
    
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.showsSelectionIndicator = YES;
    [self.view addSubview:pickView];
    
    //取数组
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TianQi" ofType:@"plist"];
    data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
     NSLog(@"%@", data);//直接打印数据。
    data1 = [data allKeys];//下面的所有的都能用这个
    pName = [data1 objectAtIndex:0];//选中的省
    NSDictionary *items = [data objectForKey:[data1 objectAtIndex:0]];
    str0 = [[items allKeys]objectAtIndex:0];// 默认值
    
 }


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return data1.count;//取得省
    }
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    NSDictionary *items = [data objectForKey:[data1 objectAtIndex:selectedRow]];//得到市

    return items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component
{
    if(component ==0){
        
        return [data1 objectAtIndex:row];
    }
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    
    NSDictionary *items = [data objectForKey:[data1 objectAtIndex:selectedRow]];//市
    NSArray *citynm = [items allKeys];
    NSString *cityName = [citynm objectAtIndex:row];
    return cityName;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component ==0){
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        pName = [data1 objectAtIndex:row];//选中的省
    }
    
    if (component ==1) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        NSDictionary *items = [data objectForKey:[data1 objectAtIndex:selectedRow]];
        
        str0 = [[items allKeys]objectAtIndex:row];// 选中的某一个城市名字
    }
}


-(void)onClick{
    
    SecondViewController *svc = [[SecondViewController alloc]init];
    [self presentViewController:svc animated:YES completion:^{}];
    
    NSDictionary *dic = [data objectForKey:pName];//省对应的全部城市
    NSLog(@"省对应的全部城市%@", dic);//直接打印数据。
    NSString *cityid = [dic objectForKey:str0];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"lll" object:cityid];
    
    
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
