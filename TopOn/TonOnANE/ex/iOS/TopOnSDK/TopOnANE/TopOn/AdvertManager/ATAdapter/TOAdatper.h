//
//  TOAdatper.h
//
//  Created by 洋吴 on 2019/3/21.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOProtocal.h"

#ifdef __cplusplus
extern "C"{
#endif
    
    void    UnitySendMessage(const char* obj, const char* method, const char* msg);
   
#ifdef __cplusplus
}
#endif




@interface TOAdatper : NSObject <TOProtocal>

+ (TOAdatper *)adatper;


@end

