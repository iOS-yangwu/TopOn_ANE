//
//  UIImage+Additions.m
//  TopOnSDK
//
//  Created by 洋吴 on 2020/5/29.
//  Copyright © 2020 洋吴. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)launchImage{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    }else {
        viewOrientation = @"Landscape";
    }
    
    NSString *launchImage = @"";
    
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:launchImage];
}

+ (UIImage *)nativeDetailLabelBgImageWithImageName:(NSString *)imageName{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ANE" ofType :@"bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *img_path = [bundle pathForResource:imageName ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:img_path];
    
}



@end
