//
//  URLRouterNavigatorDelegate.h
//  CloudMusic
//
//  Created by FeliksLv on 2022/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol URLRouterNavigatorDelegate <NSObject>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

- (void)openH5:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
