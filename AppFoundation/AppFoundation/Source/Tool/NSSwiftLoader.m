//
//  NSSwiftLoader.m
//  AppFoundation
//
//  Created by 永平 on 2020/12/22.
//

#import "NSSwiftLoader.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>

@implementation NSSwiftLoader

+ (void)loadUrlRouters {
    
//    int numClasses = 0, newNumClasses = objc_getClassList(NULL, 0);
//    Class *classes = NULL;
//
//    while (numClasses < newNumClasses) { // 3
//        numClasses = newNumClasses;
//        classes = (Class *)realloc(classes, sizeof(Class) * numClasses);
//        newNumClasses = objc_getClassList(classes, numClasses);
//
//        for (int i = 0; i < numClasses; i++) {
//            Class class = classes[i];
//            if (class_conformsToProtocol(class, @protocol(JCURLNavigatorSubmodule))) {
//                [(id<JCURLNavigatorSubmodule>)class register];
//                [(id<JCURLNavigatorSubmodule>)class handle];
//            }
//        }
//    }
//    free(classes);
}

@end
