//
//  ObjcFirstLib.m
//  ObjcFirstLib
//
//  Created by Kirill Magerya on 14.07.2021.
//

#import "FirstObjLibrary.h"
#import "SwiftLibrary-Swift.h"

@implementation ObjcFirstLib

-(NSString*) objcFirstFunc {
    return @"ObjcFirstLib";
}

-(NSString*) objcSecondLibrary {
    ObjcSecondLib *secondObjcLib = [ObjcSecondLib new];
    return [ObjcSecondLib objcSecondFunc];
}

-(NSString*) swiftFirstLib {
    SwiftFirstLib *swiftFirstLibrary = [SwiftFirstLib new];
    return [swiftFirstLibrary swiftFirstFunc];
}

@end
