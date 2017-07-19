//
//  MainViewController.h
//  TianQi
//
//  Created by liyi on 14-9-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
#import "SecondViewController.h"
@interface MainViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


{
    NSDictionary *data;
    NSArray *data1;//创造了全局data
    NSString *str0;
    NSString *pName;
    WeatherModel *wa;
    NSURL *url;
}



//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
//
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
//

@end
