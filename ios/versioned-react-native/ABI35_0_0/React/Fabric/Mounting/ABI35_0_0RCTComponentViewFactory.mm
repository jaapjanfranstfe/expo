/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI35_0_0RCTComponentViewFactory.h"

#import <ReactABI35_0_0/ABI35_0_0RCTAssert.h>
#import <ReactABI35_0_0/core/ReactABI35_0_0Primitives.h>

#import "ABI35_0_0RCTActivityIndicatorViewComponentView.h"
#import "ABI35_0_0RCTImageComponentView.h"
#import "ABI35_0_0RCTParagraphComponentView.h"
#import "ABI35_0_0RCTRootComponentView.h"
#import "ABI35_0_0RCTScrollViewComponentView.h"
#import "ABI35_0_0RCTSliderComponentView.h"
#import "ABI35_0_0RCTSwitchComponentView.h"
#import "ABI35_0_0RCTViewComponentView.h"

using namespace facebook::ReactABI35_0_0;

@implementation ABI35_0_0RCTComponentViewFactory {
  std::unordered_map<ComponentHandle, Class<ABI35_0_0RCTComponentViewProtocol>> _registry;
}

+ (ABI35_0_0RCTComponentViewFactory *)standardComponentViewFactory
{
  ABI35_0_0RCTAssertMainQueue();

  ABI35_0_0RCTComponentViewFactory *componentViewFactory = [[ABI35_0_0RCTComponentViewFactory alloc] init];

  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTViewComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTRootComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTScrollViewComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTImageComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTParagraphComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTActivityIndicatorViewComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTSliderComponentView class]];
  [componentViewFactory registerComponentViewClass:[ABI35_0_0RCTSwitchComponentView class]];

  return componentViewFactory;
}

- (void)registerComponentViewClass:(Class<ABI35_0_0RCTComponentViewProtocol>)componentViewClass
{
  ABI35_0_0RCTAssertMainQueue();

  ComponentHandle componentHandle = [componentViewClass componentHandle];
  _registry[componentHandle] = componentViewClass;
}

- (UIView<ABI35_0_0RCTComponentViewProtocol> *)createComponentViewWithComponentHandle:
    (facebook::ReactABI35_0_0::ComponentHandle)componentHandle
{
  ABI35_0_0RCTAssertMainQueue();

  auto iterator = _registry.find(componentHandle);
  ABI35_0_0RCTAssert(
      iterator != _registry.end(),
      @"ComponentView with componentHandle `%lli` (`%s`) not found.",
      componentHandle,
      (char *)componentHandle);
  Class componentViewClass = iterator->second;
  return [[componentViewClass alloc] init];
}

@end
