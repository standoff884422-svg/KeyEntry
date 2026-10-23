#import <UIKit/UIKit.h>

static UIViewController *topVC(void) {
    for (UIScene *s in UIApplication.sharedApplication.connectedScenes) {
        if ([s isKindOfClass:UIWindowScene.class]) {
            for (UIWindow *w in ((UIWindowScene *)s).windows) {
                if (w.isKeyWindow) {
                    UIViewController *vc = w.rootViewController;
                    while (vc.presentedViewController) vc = vc.presentedViewController;
                    return vc;
                }
            }
        }
    }
    return nil;
}

static void showKeyAlert(void) {
    UIAlertController *a = [UIAlertController alertControllerWithTitle:@"Введите ключ"
        message:nil preferredStyle:UIAlertControllerStyleAlert];
    [a addTextFieldWithConfigurationHandler:^(UITextField *tf) { tf.placeholder = @"Ключ"; }];
    [a addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction *x) {
            NSLog(@"Key: %@", a.textFields.firstObject.text);
        }]];
    [topVC() presentViewController:a animated:YES completion:nil];
}

__attribute__((constructor)) static void init(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{ showKeyAlert(); });
}
