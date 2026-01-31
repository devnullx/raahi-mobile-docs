import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { useEffect } from 'react';
import * as SplashScreen from 'expo-splash-screen';

// Prevent the splash screen from auto-hiding before asset loading is complete
SplashScreen.preventAutoHideAsync();

export default function RootLayout() {
  useEffect(() => {
    // Initialize app and hide splash screen
    const initializeApp = async () => {
      try {
        // TODO: Initialize database, auth, etc.
        await new Promise(resolve => setTimeout(resolve, 1000)); // Temporary delay
      } catch (error) {
        console.error('App initialization error:', error);
      } finally {
        await SplashScreen.hideAsync();
      }
    };

    initializeApp();
  }, []);

  return (
    <>
      <StatusBar style="auto" />
      <Stack screenOptions={{ headerShown: false }}>
        <Stack.Screen name="index" />
        <Stack.Screen name="(auth)" />
        <Stack.Screen name="(main)" />
        <Stack.Screen name="(modals)" options={{ presentation: 'modal' }} />
      </Stack>
    </>
  );
}