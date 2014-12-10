//
//  SHHomeViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHRecommendViewController.h"
#import "SHChannelListViewController.H"
#import "SHLiveViewController.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mDictionary = [[NSMutableDictionary alloc]init];
    
    [self tabBar:self.tabbar didSelectItem:[[self.tabbar items] objectAtIndex:0]];
    self.tabbar.selectedItem = [self.tabbar.items objectAtIndex:0];
    self.tabbar.barTintColor = [[UIColor alloc]initWithRed:38/255 green:38/255 blue:38/255 alpha:1];
    self.tabbar.selectedImageTintColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
    
      arrayBtn = [[NSArray alloc]initWithObjects:btnOration,btnOriginal,btnEntertainment,btnLife,btnCar,btnSports,btnTravel,btnMicroShow, nil];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    SHTableViewController * nacontroller;
    if(item.tag == 0){
        nacontroller =[ mDictionary valueForKey:@"SHRecommendViewController"];
        if(!nacontroller){
            SHRecommendViewController * viewcontroller = [[SHRecommendViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHRecommendViewController"];
        }
    }else if (item.tag == 1){
        nacontroller =[ mDictionary valueForKey:@"SHLiveViewController"];
        if(!nacontroller){
            SHLiveViewController * viewcontroller = [[SHLiveViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHLiveViewController"];
        }
    }else if (item.tag == 2){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController2"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.type = @"动漫";
            viewcontroller.tag = 2;
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController2"];
        }
    }else if (item.tag == 3){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController3"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.tag = 3;
            nacontroller = viewcontroller;
            viewcontroller.type = @"电视剧";
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController3"];
        }
    }else if (item.tag == 4){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController4"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.tag = 4;
            nacontroller = viewcontroller;
            viewcontroller.type = @"电影";
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController4"];
        }
    }else if (item.tag == 5){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController5"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.tag = 5;
            nacontroller = viewcontroller;
            viewcontroller.type = @"微电影";
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController5"];
        }
    }else if (item.tag == 6){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController6"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.tag = 6;
            nacontroller = viewcontroller;
            viewcontroller.type = @"综艺";
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController6"];
        }
    }else if (item.tag == 7){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController7"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.tag = 7;
            viewcontroller.type = @"纪录片";
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController7"];
        }
    }else if (item.tag == 8){// more
        [self changeMoreViewColor:lastMoreTag];
        [self showIn:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        return;
        
    }else if (item.tag == 9){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController"];
        }
    }else if (item.tag == 10){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController"];
        }
    }
    if(mIsShow){
        [self close];
    }
    if(lastnacontroller != nacontroller){
        
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        if(item.tag == 0){
            nacontroller.view.frame = self.view.bounds;
            mViewContain.hidden = YES;
            [self.view insertSubview:nacontroller.view atIndex:0];
        }else if(item.tag == 1){
            CGRect rect = mViewContain.frame;
            //            rect.size.height +=49;
            nacontroller.view.frame = rect;
            mViewContain.hidden = YES;
            [self.view addSubview:nacontroller.view];
            [self.view bringSubviewToFront:nacontroller.view];
        }else {
            nacontroller.view.frame = mViewContain.bounds;
            mViewContain.hidden = NO;
            [mViewContain addSubview:nacontroller.view];
        }
        
        
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
        lastMoreTag = 0;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnWatchRecordOntouch:(UIButton *)sender {
}

- (IBAction)btnDownloadOntouch:(UIButton *)sender {
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mSearch resignFirstResponder];
    
}
#pragma  more show
- (void)showIn :(CGRect)rect
{
    if(!mIsShow){
        mIsShow = YES;
        mViewMore.frame = rect;
        mViewMore.alpha = 0;
        mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, mViewMoreContent.frame.origin.y+ mViewMoreContent.frame.size.height, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
        [self.view addSubview:mViewMore];
        [self.view bringSubviewToFront:mViewMore];
        
        [UIView animateWithDuration:0.5 animations:^{
            mViewMore.alpha = 1;
            mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, 0, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self close];
    }
}

- (void)close
{
    if(mIsShow){
        mIsShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, [[UIScreen mainScreen] applicationFrame].size.height-50, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
            mViewMore.alpha = 0;
            
        } completion:^(BOOL finished) {
            [mViewMore removeFromSuperview];
        }];
        
    }
}

- (IBAction)btnCloseOnTouch:(id)sender
{
    [self close];
}

- (IBAction)btnMoreOntouch:(UIButton *)sender {
    SHTableViewController * nacontroller;
    [self changeMoreViewColor:sender.tag];
    switch (sender.tag) {
        case 21:
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController21"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"资讯";
                viewcontroller.tag = 21;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController21"];
            }
            
            break;
        case 22:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController22"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController22"];
            }
      
            break;
        }
        case 23:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController23"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController23"];
            }
         
            break;
        }
        case 24:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController24"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController24"];
            }
           
            break;
        }
        case 25:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController25"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController25"];
            }
            
            break;
        }
        case 26:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController26"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController26"];
            }
            
            break;
        }
        case 27:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController27"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController27"];
            }
            
            break;
        }
        case 28:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController28"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @"原创";
                viewcontroller.tag = 22;
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController28"];
            }
            
            break;
        }            
            
        default:
            break;
    }
    if(lastnacontroller != nacontroller){
        
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        
        nacontroller.view.frame = mViewContain.bounds;
        mViewContain.hidden = NO;
        [mViewContain addSubview:nacontroller.view];
        
        
        
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
        lastMoreTag = sender.tag;
    }
    
    [self close];
    
}
-(void) changeMoreViewColor:(int)selectTag
{
        for (UIButton * button in arrayBtn) {
        if (button.tag == selectTag) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];

            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tab_select_%d",button.tag]] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tab_normal_%d",button.tag]] forState:UIControlStateNormal];
        }
    }

}
@end
