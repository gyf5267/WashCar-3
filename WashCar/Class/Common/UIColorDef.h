//
//  UIColorDef.h
//  WashCar
//
//  Created by nate on 15/6/24.
//  Copyright (c) 2015年 高 玉锋. All rights reserved.
//

#ifndef WashCar_UIColorDef_h
#define WashCar_UIColorDef_h

#import <Foundation/Foundation.h>

#define UIColorFromRGB(r) [UIColor colorWithRed:(r>>16&0xff)/255. green:(r>>8&0xff)/255. blue:(r&0xff)/255. alpha:1.]

#define UIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

#define UIColorRGB(r) [UIColor colorWithRed:(r>>16&0xff)/255. green:(r>>8&0xff)/255. blue:(r&0xff)/255. alpha:1.]

#define COLOR_NAVIGATION_BAR_BACKGROUND             0x67afee

#define NavigationBarBackgroundColor  [UIColor colorWithRed:242/255.0 green:111/255.0 blue:162/255.0 alpha:1.0]

#endif
