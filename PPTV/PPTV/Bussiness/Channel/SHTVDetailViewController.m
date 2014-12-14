//
//  SHTVDetailViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//
// detailInfo
#import "SHTVDetailViewController.h"
#import "SHChannelHorizontalCell.h"

@interface SHTVDetailViewController ()

@end

@implementation SHTVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    dicPreInfo = [self.intent.args objectForKey:@"detailInfo"];
    mScrollview.datasource = self;
    mScrollview.delegate = self;
   
   
   
    

    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://183.136.140.38/gsws/z.m3u8";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
    if ([[self.intent.args objectForKey:@"type"]intValue] == 0) {
        self.title = @"播放详情(标清)";
         mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/201409291618464557d5afdfe_5f77c692.mp4?wsiphost=local";
    }else if ([[self.intent.args objectForKey:@"type"]intValue] == 1) {
        self.title = @"播放详情(高清)";
         mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/2014092916192198605db245e_e0a8255b.mp4?wsiphost=local";
    }else {
        self.title = @"播放详情(超清)";
        mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/201409291618156309b21cbd8_4e58bd54.mp4";
    }
   
   
    
   
    mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);

    mShowViewControll.isfull = YES;
    [self.view addSubview:mShowViewControll.view];
    
    [self request:[[dicPreInfo objectForKey:@"id"]intValue]];

    [mDrameViewControll.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(void) request:(NSInteger)videoID
{
 
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/vodinfo");
    [post.postArgs setValue:[NSNumber numberWithInt:videoID] forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *t) {
        
        mResultDetail = [[t result]mutableCopy];
        mVideotitle = [mResultDetail objectForKey:@"title"];
        mVideoUrl = [[mResultDetail objectForKey:@"vods"]objectForKey:@"hd2" ];
        self.title = mVideotitle;
        NSURL * videoUrl = [NSURL URLWithString:mVideoUrl];
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:0];
        
        if (mDemandDetailViewControll==nil) {// 详情
            mDemandDetailViewControll = [[SHDemandDetailViewController alloc]init];
            mDemandDetailViewControll.view.frame = mViewContent.bounds;
        }
        mDemandDetailViewControll.detail = [mResultDetail mutableCopy];
        if (mDrameViewControll ==nil) {// 剧集
            mDrameViewControll = [[SHTVDrameViewController alloc]init];
            mDrameViewControll.view.frame = mViewContent.bounds;
        }
        
        mDrameViewControll.list = [[NSMutableArray alloc]init ];
        [mViewContent addSubview:mDrameViewControll.view];
        // 大家都在看
        mList = [[mResultDetail objectForKey:@"recoms"]mutableCopy];
        [mScrollview reloadData];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
    }];

}


- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHChannelHorizontalCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [((SHChannelHorizontalCell*)cell).imgPic setUrl:[dic objectForKey:@"pic"]];
    ((SHChannelHorizontalCell*)cell).labTitle.text = [dic objectForKey:@"title"];
    ((SHChannelHorizontalCell*)cell).labContent.text = [dic objectForKey:@"focus"];
    
    return cell;
    
}
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section
{
    
    return mList.count;
}

- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    //    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
//    [mScrollview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];


    [self request:[[[mList objectAtIndex:indexPath.row] objectForKey:@"id"]intValue]];
    
}
#pragma video delegate
- (NSURL *)playCtrlGetNextMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    return [[NSURL alloc]initWithString:@"http://183.136.140.38/gsws/z.m3u8"];
}

- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{

    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
            

            mShowViewControll.view.frame = self.view.bounds;
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.view bringSubviewToFront:mShowViewControll.view];
            
        } else {

            mShowViewControll.view.frame = mViewVideo.bounds;
           
        }
    }completion:^(BOOL finished) {
        
    }];
}
-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton *)sender tag:(int)tag
{
    
    [self changeRightViewContent:tag];
}

#pragma  菜单响应变化
-(void) changeRightViewContent:(int) index
{
    for (UIView * view in mViewContent.subviews) {
        [view removeFromSuperview];
    }
    switch (index) {
        case 1:// 剧集
            [mViewContent addSubview:mDrameViewControll.view];
            break;
        case 2:// 详情
            [mViewContent addSubview:mDemandDetailViewControll.view];
            break;
        case 3:// 下载
            
            break;
        case 4://收藏
            
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
