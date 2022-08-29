//
//  URLRouter.m
//  CloudMusic
//
//  Created by FeliksLv on 2022/7/27.
//

#import "URLRouter.h"
#import "URLRouterViewControllerProtocol.h"

@implementation URLRouter {
    NSMutableDictionary<NSString *, Class> *_routers;
}

+ (URLRouter *)defaultRouter {
    static URLRouter *_defaultRouter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultRouter = [[URLRouter alloc] init];
    });
    return _defaultRouter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _routers = [NSMutableDictionary dictionaryWithCapacity:5];
        [self registerRouters];
    }
    return self;
}

- (UIViewController *)viewControllerForURLString:(NSString *)urlString {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:urlString];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        param[obj.name] = obj.value;
    }];
    return [self viewControllerForURLString:[urlComponents path] params:param];
}

- (UIViewController *)viewControllerForURLString:(NSString *)urlString params:(NSDictionary *)params {
    UIViewController *viewController;
    id target = _routers[urlString];
    if (!target) {
        return [[UIViewController alloc] init];
    }
    if ([target respondsToSelector:@selector(routerInitWithParams:)]) {
        viewController = (id) [target routerInitWithParams:params];
        return viewController;
    } else {
        Class cls = target;
        return (UIViewController *) [cls new];
    }
}

- (void)open:(NSString *)url {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        [self openH5:url];
        return;
    }
    NSLog(@"[Router] push %@", url);
    UIViewController *vc = [self viewControllerForURLString:url];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.delegate pushViewController:vc animated:YES];
    }
}

- (void)open:(NSString *)url params:(NSDictionary<NSString *, id> *)params {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        [self openH5:url];
        return;
    }
    NSLog(@"[Router] push %@ params: %@", url, params);
    UIViewController *vc = [self viewControllerForURLString:url params:params];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.delegate pushViewController:vc animated:YES];
    }
}

- (void)present:(NSString *)url params:(NSDictionary<NSString *, id> *)params {
    NSLog(@"[Router] present %@ params: %@", url, params);
    UIViewController *vc = [self viewControllerForURLString:url params:params];
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self.delegate presentViewController:vc animated:NO completion:nil];
    }
}

- (void)openH5:(NSString *)url {
    if (self.delegate && [self.delegate respondsToSelector:@selector(openH5:)]) {
        [self.delegate openH5:url];
    }
}

- (void)registerRouters {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"router" ofType:@"plist"];
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    NSDictionary<NSString *, id> *routerDict = [[NSDictionary alloc] initWithContentsOfURL:fileUrl error:nil];
    for (NSString *key in routerDict) {
        Class cls = NSClassFromString(key);
        NSAssert(cls, @"找不到%@类", key);
        NSDictionary *config = routerDict[key];
        NSString *url = config[@"url"];
        _routers[url] = cls;
    }
}

- (void)registerRouter:(NSString *)url forClass:(Class)cls {
    @synchronized (self) {
        self->_routers[url] = cls;
    }
}

@end
