# GWTool 功能
```objc
+(void)execAfter:(double)seconds cb:(DelayExecCB)cb;//延迟执行
+(UIColor *)getColor:(NSString*)hexColor alpha:(float)alpha;//从16进制获得颜色
+(NSString*)trim:(NSString*)string;//去掉字符串中的空格
+(int)getScreenWidth;//获得屏幕宽
+(int)getScreenHeight;//获得屏幕高
+(UIImage*)clipImage:(UIImage*)srcimg area:(CGRect)area;//图片剪裁
+(float)getStatusBarHeight;//获得状态栏高度
+(float)getNaviLanHeight:(UIViewController*)sender; //获得导航栏高度
+(void)setTitleWithNaviItem:(UINavigationItem*)item //设置导航栏标题
                      title:(NSString*)title 
		  fonntSize:(int)f
		  textColor:(UIColor*)c;

+(void)setRightBtnWithNaviItem:(UINavigationItem*)item //设置右按钮
                   stateNormal:(UIImage*)img_normal
		     stateDown:(UIImage*)img_down
		         frame:(CGRect)frame
			 action:(SEL)action
			 target:(id)target;

+(void)setLeftBtnWithNaviItem:(UINavigationItem*)item //设置左边按钮
                  stateNormal:(UIImage*)img_normal
		    stateDown:(UIImage*)img_down
		        frame:(CGRect)frame
		       action:(SEL)action
		       target:(id)target;
//获得圆角view 指定某个角用which 多个角用|连接 如:UIRectCornerTopLeft|UIRectCornerTopRight
+(UIView*)getRoundCornerView:(UIView*)target radius:(int)radius which:(UIRectCorner)which;

+(NSString*)getAppVersion; //获得app版本
+(NSString*)getAppBuild; //获得app Build
//时间戳转时间，format，例如:@"MM月dd日HH:mm:ss"
+(NSString*)timeSpToDateStr:(SInt32)timeSp format:(NSString*)format;
+(NSDictionary*)strToJson:(NSString *)str; //字符串转字典
+(BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;//当前时间是否在指定时间内
+(NSString*)getIPAddressByHostName:(NSString*)strHostName;//根据域名获得ip

```
# 安装
### 源码安装
1. 直接下载代码 集成到工程.

### cocopods安装
1. 未安装cocopods的自行安装.
2. 执行pod search GWtool.
3. 编辑Podfile,添加 pod 'GWTool', '~> 0.0.2'.
4. 执行pod install --verbose --no-repo-update.

# 更新记录
### 0.0.2
1. 增加函数 +(NSString*)getIPAddressByHostName:(NSString*)strHostName;//根据域名获得ip.

