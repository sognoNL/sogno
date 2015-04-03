//
//  Constants.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

@class HappyDAO;

#define gHappyDAO             ([HappyDAO sharedDAO])
#define UIColorWithHex(c,a)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:a]