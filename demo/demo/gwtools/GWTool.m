//
//  GWTool.m
//  demo
//
//  Created by shawn on 7/27/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import "GWTool.h"

@implementation GWTool

+(void)execAfter:(double)seconds cb:(DelayExecCB)cb
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        cb();
    });
}
+(UIColor *)getColor:(NSString*)hexColor alpha:(float)alpha
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
}
+(NSString*)trim:(NSString*)string
{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strUrl = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strUrl;
}
+(int)getScreenWidth{
    return [[UIScreen mainScreen] bounds].size.width;
}
+(int)getScreenHeight{
    return [[UIScreen mainScreen] bounds].size.height;
}
+(UIImage*)clipImage:(UIImage*)srcimg area:(CGRect)area
{
    UIImageView *imgview = [[UIImageView alloc] init];
    imgview.frame = CGRectMake(0, 0,srcimg.size.width, srcimg.size.height);
    CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], area);
    UIImage *target  = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return target;
}
+(float)getStatusBarHeight
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}
+(float)getNaviLanHeight:(UIViewController*)sender
{
    CGRect rectNav = sender.navigationController.navigationBar.frame;
    return rectNav.size.height;
}
+(void)setTitleWithNaviItem:(UINavigationItem*)item
                      title:(NSString*)t
                  fonntSize:(int)f
                  textColor:(UIColor*)c
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = c;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = t;
    item.titleView = titleLabel;
}
+(void)setRightBtnWithNaviItem:(UINavigationItem*)item
                   stateNormal:(UIImage*)img_normal
                     stateDown:(UIImage*)img_down
                         frame:(CGRect)frame
                        action:(SEL)action
                        target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:img_normal forState:UIControlStateNormal];
    [btn setImage:img_down forState:UIControlStateHighlighted];
    [btn setFrame:frame];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    item.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+(void)setLeftBtnWithNaviItem:(UINavigationItem*)item
                  stateNormal:(UIImage*)img_normal
                    stateDown:(UIImage*)img_down
                        frame:(CGRect)frame
                       action:(SEL)action
                       target:(id)target;

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:img_normal forState:UIControlStateNormal];
    [btn setImage:img_down forState:UIControlStateHighlighted];
    [btn setFrame:frame];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    item.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+(UIView*)getRoundCornerView:(UIView *)target radius:(int)radius which:(UIRectCorner)which
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:target.bounds byRoundingCorners:which cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = target.bounds;
    maskLayer.path = maskPath.CGPath;
    target.layer.mask = maskLayer;
    return target;
    
}
+(NSString*)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
+(NSString*)getAppBuild
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}
+(NSString*)timeSpToDateStr:(SInt32)timeSp format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeSp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return [confromTimespStr substringWithRange:NSMakeRange(0, confromTimespStr.length-3)];
}
+(NSDictionary*)strToJson:(NSString *)str
{
    NSData *resData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return result;
}
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [self getCustomDateWithHour:fromHour];
    NSDate *date23 = [self getCustomDateWithHour:toHour];
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
        return YES;
    }else{
        NSLog(@"该时间不在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
    }
    return NO;
}
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    NSCalendar *resultCalendar = [NSCalendar currentCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}
@end
