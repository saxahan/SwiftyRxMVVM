//
//  Navigator.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

protocol Viewable { }
extension UIViewController: Viewable { }

protocol NavigationMode: NSObjectProtocol { }
class PushNavigation: NSObject, NavigationMode { }
class ModalNavigation: NSObject, NavigationMode { }
class RootNavigation: NSObject, NavigationMode { }
class PopToRootNavigation: NSObject, NavigationMode { }

enum NavigatorError: Swift.Error {
    case unhandled(NavigationMode)
}

protocol Navigator {
    var viewables: [Viewable] { get }
    func dismiss(with mode: NavigationMode,
                 animated: Bool) -> Completable
    func present(view: Viewable,
                 with mode: NavigationMode,
                 animated: Bool) -> Completable
}

protocol TransitionCoodinating {
    var transitionCoordinator: UIViewControllerTransitionCoordinator? { get }
}

extension TransitionCoodinating {
    func doAfterAnimatingTransition(animated: Bool, completion: @escaping (() -> Void)) {
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil, completion: { _ in
                completion()
            })
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

extension UIWindow: Navigator {
    var viewables: [Viewable] {
        var view = rootViewController
        var views = [Viewable]()
        repeat {
            if let view = view {
                views.append(view)
            }
            view = view?.presentedViewController
        } while view != nil
        return views
    }

    func dismiss(with mode: NavigationMode, animated: Bool) -> Completable {
        if mode is ModalNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.rootViewController!.dismiss(animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else {
            return .error(NavigatorError.unhandled(mode))
        }
    }

    func present(view: Viewable, with mode: NavigationMode, animated: Bool) -> Completable {
        let _view = view as! UIViewController
        if mode is RootNavigation {
            self.rootViewController = _view
            self.makeKeyAndVisible()
            return .empty()
        } else if mode is ModalNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.rootViewController!.present(_view, animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else {
            return .error(NavigatorError.unhandled(mode))
        }
    }
}

extension UINavigationController: Navigator, TransitionCoodinating {
    var viewables: [Viewable] {
        var views: [Viewable] = viewControllers
        var view = presentedViewController
        repeat {
            if let view = view {
                views.append(view)
            }
            view = view?.presentedViewController
        } while view != nil
        return views
    }

    func dismiss(with mode: NavigationMode, animated: Bool) -> Completable {
        if mode is PushNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.popViewController(animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else if mode is PopToRootNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.popToRootViewController(animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else if mode is ModalNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.dismiss(animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else {
            return .error(NavigatorError.unhandled(mode))
        }
    }

    func present(view: Viewable, with mode: NavigationMode, animated: Bool) -> Completable {
        let _view = view as! UIViewController
        if mode is PushNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.pushViewController(_view, animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else if mode is ModalNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.present(_view, animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else {
            return .error(NavigatorError.unhandled(mode))
        }
    }

    private func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping (() -> Void)) {
        if viewControllers.count == 0 {
            setViewControllers([viewController], animated: animated)
            doAfterAnimatingTransition(animated: animated, completion: completion)
        } else {
            pushViewController(viewController, animated: animated)
            doAfterAnimatingTransition(animated: animated, completion: completion)
        }
    }

    private func popViewController(animated: Bool, completion: @escaping (() -> Void)) {
        if viewControllers.count == 1 {
            setViewControllers([], animated: false)
            doAfterAnimatingTransition(animated: false, completion: completion)
        } else {
            popViewController(animated: animated)
            doAfterAnimatingTransition(animated: animated, completion: completion)
        }
    }

    private func popToRootViewController(animated: Bool, completion: @escaping (() -> Void)) {
        popToRootViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }
}

extension UITabBarController: Navigator, TransitionCoodinating {
    var viewables: [Viewable] {
        return viewControllers ?? []
    }

    func dismiss(with mode: NavigationMode, animated: Bool) -> Completable {
        return .error(NavigatorError.unhandled(mode))
    }

    func present(view: Viewable, with mode: NavigationMode, animated: Bool) -> Completable {
        let _view = view as! UIViewController
        if mode is RootNavigation {
            return Completable.deferred {
                return Completable.create { observer in
                    self.addViewController(_view, animated: animated) {
                        observer(.completed)
                    }
                    return Disposables.create()
                }
            }
        } else {
            return .error(NavigatorError.unhandled(mode))
        }
    }

    private func addViewController(_ viewController: UIViewController,
                                   animated: Bool,
                                   completion: @escaping (() -> Void)) {
        let newViewControllers = (viewControllers ?? []) + [viewController]
        setViewControllers(newViewControllers, animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }
}

