import type {HostComponent, ViewProps} from 'react-native';
import type { BubblingEventHandler } from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';


type WebViewScriptLoadedEvent = {
  result: "success" | "error",
};

export interface NativeProps extends ViewProps {
  sourceURL?: string;

  onScriptLoaded?: BubblingEventHandler<WebViewScriptLoadedEvent> | null;
}

export default codegenNativeComponent<NativeProps>('CustomWebView') as HostComponent<NativeProps>;
