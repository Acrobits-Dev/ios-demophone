#import "SceneDelegate.h"
#import "demophoneAppDelegate.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene
    willConnectToSession:(UISceneSession *)session
    options:(UISceneConnectionOptions *)connectionOptions
{
    if (![scene isKindOfClass:[UIWindowScene class]])
        return;

    // UIKit creates the window and root controller from the scene storyboard.
    [[demophoneAppDelegate theApp] connectWindow:self.window];
}

- (void)sceneDidDisconnect:(UIScene *)scene
{
    [[demophoneAppDelegate theApp] disconnectWindow:self.window];
}

@end
