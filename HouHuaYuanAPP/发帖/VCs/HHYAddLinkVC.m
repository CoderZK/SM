//
//  HHYAddLinkVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYAddLinkVC.h"

@interface HHYAddLinkVC ()
@property (weak, nonatomic) IBOutlet UIView *linkV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UIButton *BT;

@end

@implementation HHYAddLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加链接";
    
    self.BT.clipsToBounds = YES;
    self.BT.layer.cornerRadius = 3;
    self.linkV.hidden = YES;
    
    UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
    //    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [hitClickButtonn setTitle:@"完成" forState:UIControlStateNormal];
    hitClickButtonn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    hitClickButtonn.titleLabel.font = kFont(14);
    [hitClickButtonn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    hitClickButtonn.tag = 11;
    //    [self.view addSubview:hitClickButtonn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hitClickButtonn];
    
    
}

- (void)navigationItemButtonAction:(UIButton *)button {
    if (self.linkBlock != nil) {
        
        self.linkBlock(self.TF.text);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (IBAction)action:(id)sender {
    
    self.linkV.hidden = NO;
    self.titleLB.text = self.TF.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
