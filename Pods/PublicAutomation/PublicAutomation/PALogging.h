//
//  PALogging.h
//  PublicAutomation
//
//  Created by Gordon Fontenot on 10/31/13.

#ifndef DISABLE_PA_LOGGING
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...) /* Logging disabled */
#endif
