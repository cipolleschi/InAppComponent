/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {
  Alert,
  StyleSheet,
  View,
} from 'react-native';
import WebView from './specs/WebViewNativeComponent'

function App(): React.JSX.Element {

  return (
    <View style={styles.container}>
      <WebView sourceURL='https://react.dev/'
        style={{width:'100%', height:'100%', backgroundColor: 'red'}}
        onScriptLoaded={() => {
          console.log('Script Loaded')
          Alert.alert('Page Loaded')

        }} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    alignContent: 'center',
  }
});

export default App;
