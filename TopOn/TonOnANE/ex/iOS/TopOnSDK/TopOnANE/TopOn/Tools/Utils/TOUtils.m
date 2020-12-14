//
//  TOUtils.m
//  TopOnSDK
//
//  Created by 洋吴 on 2020/6/11.
//  Copyright © 2020 洋吴. All rights reserved.
//

#import "TOUtils.h"
#import "TOConst.h"

@implementation TOUtils

+ (CGRect) transformationToOCCoordinates:(CGRect)frame{
    
    CGFloat scales = [UIScreen mainScreen].scale;
    CGRect finalFrame = CGRectZero;
    CGFloat originX = frame.origin.x;
    CGFloat originY = frame.origin.y;
    CGFloat originW = frame.size.width;
    CGFloat originH = frame.size.height;
    
    if (SCREENSIZE_IS_6SP) {

        finalFrame = CGRectMake(originX/0.92/scales, originY/0.9/scales, originW/scales, originH/scales);

    }else if (SCREENSIZE_IS_XR && scales == 2){

        finalFrame = CGRectMake(originX/scales, originY/scales-44, originW/2.2, originH/2.2);
        
    }else{

        finalFrame = CGRectMake(originX/scales, originY/scales, originW/scales, originH/scales);
    }
    
    return finalFrame;
}



@end
