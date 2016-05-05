//
//  ViewController.m
//  uitextfieldLimit
//
//  Created by 何川 on 16/5/5.
//  Copyright © 2016年 hechuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>{
    UILabel *label;
    UITextView *limittextview ;
    BOOL isFirst;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isFirst = YES;
    [self makeUI];
}


-(void)makeUI{
    limittextview = [[UITextView alloc]initWithFrame:CGRectMake(40, 100, 300, 40)];
    limittextview.backgroundColor = [UIColor greenColor];
    limittextview.font = [UIFont systemFontOfSize:20];
    limittextview.delegate = self;
    [self.view addSubview:limittextview];
    label = [[UILabel alloc]initWithFrame:CGRectMake(260, 10, 40, 40)];
    label.textColor = [UIColor blackColor];
    [limittextview addSubview:label];
    
    
    UILabel *limlabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 140, 300, 40)];
    limlabel.font = [UIFont systemFontOfSize:22];
    limlabel.textColor = [UIColor redColor];
    limlabel.text = @"限制5个汉字,10个字符的输入";
    [self.view addSubview:limlabel];
    
}


#pragma mark- UITextFieldDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    //计算字符个数,一共是60
    NSString *string = textView.text;
    int totalChar = 0;
    int totalHan = 0;
    for (int i = 0; i< string.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (cString == NULL) {
            //emoji
            //            totalChar += 2;
            //            i++;
        }else if(strlen(cString)==3){
            //汉字
            totalHan += 1;
            //            i += 2;
        }else{
            //字符
            totalChar += 1;
        }
    }
    int last = 5 - totalHan - (totalChar/2 +1);
    
    label.text = [NSString stringWithFormat:@"%d",last] ;
    
    if (last<0) {
        if(isFirst){
         label.text = @"0";
        [limittextview resignFirstResponder];
            isFirst = NO;
        }else{
            [limittextview setText:[limittextview.text substringToIndex:string.length-1]];
            label.text = @"0";
            [limittextview resignFirstResponder];
        }
       

        return;
    }else {
        isFirst = YES;
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
