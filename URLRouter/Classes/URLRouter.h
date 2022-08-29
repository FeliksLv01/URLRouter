//
//  URLRouter.h
//  CloudMusic
//
//  Created by FeliksLv on 2022/7/27.
//

#import <UIKit/UIKit.h>
#import "URLRouterNavigatorDelegate.h"
#import "URLRouterViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface URLRouter : NSObject

@property(class, readonly, strong) URLRouter *defaultRouter;

@property(nonatomic, copy) NSString *appScheme;

@property(nonatomic, weak) id <URLRouterNavigatorDelegate> delegate;

- (void)open:(NSString *)url;

- (void)open:(NSString *)url params:(NSDictionary<NSString *, id> *)params;

- (void)present:(NSString *)url params:(NSDictionary<NSString *, id> *)params;

- (UIViewController *)viewControllerForURLString:(NSString *)urlString;

- (UIViewController *)viewControllerForURLString:(NSString *)urlString params:(NSDictionary<NSString *, id> *)params;

- (void)registerRouter:(NSString *)url forClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
