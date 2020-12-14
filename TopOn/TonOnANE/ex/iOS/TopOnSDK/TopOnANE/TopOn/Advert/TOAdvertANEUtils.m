//
//  TOAdvertANEUtils.c
//  TopOnSDK
//
//  Created by 洋吴 on 2019/5/14.
//  Copyright © 2019 洋吴. All rights reserved.
//

#import "TOAdvertANEUtils.h"
#import "TOAdvertANE.h"

NSString * TopOnAdvertGetStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

FREObject TopOnAdvertCreateFREString(NSString * string)
{
    const char *str = [string UTF8String];
    FREObject obj;
    
    FRENewObjectFromUTF8((uint32_t)strlen(str)+1, (const uint8_t*)str, &obj);
    return obj;
}
/*-------------------------------double-----------------------------------*/
double TopOnAdvertGetDoubleFromFREObject(FREObject obj)
{
    double number;
    FREGetObjectAsDouble(obj, &number);
    return number;
}
FREObject TopOnAdvertCreateFREDouble(double value)
{
    FREObject obj = nil;
    FRENewObjectFromDouble(value, &obj);
    return obj;
}
/*---------------------------------int---------------------------------*/
int TopOnAdvertGetIntFromFREObject(FREObject obj)
{
    int32_t number;
    FREGetObjectAsInt32(obj, &number);
    return number;
}


FREObject TopOnAdvertCreateFREInt(int value)
{
    FREObject obj = nil;
    FRENewObjectFromInt32(value, &obj);
    return obj;
}
/*------------------------------bool----------------------------------------*/
BOOL TopOnAdvertGetBoolFromFREObject(FREObject obj)
{
    uint32_t boolean;
    FREGetObjectAsBool(obj, &boolean);
    return boolean;
}

FREObject TopOnAdvertCreateFREBool(BOOL value)
{
    FREObject obj = nil;
    FRENewObjectFromBool(value, &obj);
    return obj;
}

NSString *TopOnAdvertObj2ANEJSON(id obj){
    if (obj&&[NSJSONSerialization isValidJSONObject:obj])
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
        if (jsonData==nil) {
            return @"";
        }
        NSString * json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return @"";
}



void TopOnAdvertSendANEMessage(int what,NSString *code,NSString *key,NSString *value){
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:what], @"what",value,key, nil];
    NSString *json = TopOnAdvertObj2ANEJSON(dict);
    TopOnAdvertANEDispatchStatusEventAsyn(code,json);
}

void TopOnAdvertSendANEMessageWithDict(NSDictionary *dict,NSString *code){
    
    NSString *json = TopOnAdvertObj2ANEJSON(dict);
    TopOnAdvertANEDispatchStatusEventAsyn(code,json);
}

void TopOnAdvertANEDispatchStatusEventAsyn(NSString  * type ,NSString *jsonString ){
    if(TopOnANEEventContext==NULL){
        return ;
    }
    const char * cTypeString = [type cStringUsingEncoding:NSUTF8StringEncoding];
    
    const char * cJsonString = [jsonString cStringUsingEncoding:NSUTF8StringEncoding];
    const uint8_t* ane_type = (const uint8_t*)cTypeString;
    const uint8_t* ane_params = (const uint8_t*) cJsonString;
    
    FREDispatchStatusEventAsync(TopOnANEEventContext,ane_type,
                                ane_params);
}



