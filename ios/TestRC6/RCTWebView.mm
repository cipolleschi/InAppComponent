//
//  RCTWebView.m
//  TestRC6
//
//  Created by Riccardo Cipolleschi on 21/10/2024.
//

#import "RCTWebView.h"

#import <react/renderer/components/AppSpecs/ComponentDescriptors.h>
#import <react/renderer/components/AppSpecs/EventEmitters.h>
#import <react/renderer/components/AppSpecs/Props.h>
#import <react/renderer/components/AppSpecs/RCTComponentViewHelpers.h>
#import <WebKit/WebKit.h>

using namespace facebook::react;

@interface RCTWebView () <RCTWebViewViewProtocol, WKNavigationDelegate>
@end

@implementation RCTWebView {
  NSURL * _sourceURL;
  WKWebView * _webView;
}

-(instancetype)init
{
  
  if(self = [super init]) {
    _webView = [WKWebView new];
    _webView.navigationDelegate = self;
    [self addSubview:_webView];
  }
  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<WebViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<WebViewProps const>(props);
  
  _webView.backgroundColor = UIColor.redColor;
  // Handle your props here
  if (oldViewProps.sourceURL != newViewProps.sourceURL) {
    NSString *urlString = [NSString stringWithCString:newViewProps.sourceURL.c_str() encoding:NSUTF8StringEncoding];
    _sourceURL = [NSURL URLWithString:urlString];
    if ([self urlIsValid:newViewProps.sourceURL]) {
      [_webView loadRequest:[NSURLRequest requestWithURL:_sourceURL]];
    }
  }

  [super updateProps:props oldProps:oldProps];
}

- (BOOL)urlIsValid:(std::string)propString
{
  if (propString.length() > 0 && !_sourceURL) {
    WebViewEventEmitter::OnScriptLoaded result = WebViewEventEmitter::OnScriptLoaded{WebViewEventEmitter::OnScriptLoadedResult::Error};
    
    self.eventEmitter.onScriptLoaded(result);
    return NO;
  }
  return YES;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  WebViewEventEmitter::OnScriptLoaded result = WebViewEventEmitter::OnScriptLoaded{WebViewEventEmitter::OnScriptLoadedResult::Success};
  self.eventEmitter.onScriptLoaded(result);
}


-(void)layoutSubviews
{
  [super layoutSubviews];
  _webView.frame = self.bounds;
  
}

// Event emitter convenience method
- (const WebViewEventEmitter &)eventEmitter
{
  return static_cast<const WebViewEventEmitter &>(*_eventEmitter);
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<WebViewComponentDescriptor>();
}

Class<RCTComponentViewProtocol> WebViewCls(void)
{
  return RCTWebView.class;
}

@end
