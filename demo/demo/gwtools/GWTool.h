//
//  GWTool.h
//  demo
//
//  Created by shawn on 7/27/16.
//  Copyright © 2016 shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DelayExecCB)();
@interface GWTool : NSObject

//延迟执行
+(void)execAfter:(double)seconds cb:(DelayExecCB)cb;

//从16进制获得颜色
+(UIColor *)getColor:(NSString*)hexColor alpha:(float)alpha;

//去掉字符串中的空格
+(NSString*)trim:(NSString*)string;

//获得屏幕宽
+(int)getScreenWidth;
//获得屏幕高
+(int)getScreenHeight;

//图片剪裁
+(UIImage*)clipImage:(UIImage*)srcimg area:(CGRect)area;

//获得状态栏高度
+(float)getStatusBarHeight;

//获得导航栏高度
+(float)getNaviLanHeight:(UIViewController*)sender;

//设置导航栏标题
+(void)setTitleWithNaviItem:(UINavigationItem*)item
                      title:(NSString*)t
                  fonntSize:(int)f
                  textColor:(UIColor*)c;
//设置右按钮
+(void)setRightBtnWithNaviItem:(UINavigationItem*)item
                   stateNormal:(UIImage*)img_normal
                     stateDown:(UIImage*)img_down
                         frame:(CGRect)frame
                        action:(SEL)action
                        target:(id)target;
//设置左边按钮
+(void)setLeftBtnWithNaviItem:(UINavigationItem*)item
                  stateNormal:(UIImage*)img_normal
                    stateDown:(UIImage*)img_down
                        frame:(CGRect)frame
                       action:(SEL)action
                       target:(id)target;

//获得圆角view 指定某个角用which 多个角用|连接 如:UIRectCornerTopLeft|UIRectCornerTopRight
+(UIView*)getRoundCornerView:(UIView*)target radius:(int)radius which:(UIRectCorner)which;

//获得app版本
+(NSString*)getAppVersion;
//获得app Build
+(NSString*)getAppBuild;

//时间戳转时间，format，例如:@"MM月dd日HH:mm:ss"
+(NSString*)timeSpToDateStr:(SInt32)timeSp format:(NSString*)format;

//字符串转字典
+(NSDictionary*)strToJson:(NSString *)str;
//当前时间是否在指定时间内
+(BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
@end
