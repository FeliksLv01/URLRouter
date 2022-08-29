//
//  URLRouterViewControllerProtocol.h
//  CloudMusic
//
//  Created by Feliks Lv on 2022/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol URLRouterViewControllerProtocol <NSObject>
+ (instancetype)routerInitWithParams:(NSDictionary<NSString *, id> *)params;
@end

NS_ASSUME_NONNULL_END
