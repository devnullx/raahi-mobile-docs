module.exports = function (api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    plugins: [
      'expo-router/babel',
      'react-native-reanimated/plugin',
      [
        'module-resolver',
        {
          root: ['./src'],
          alias: {
            '@': './src',
            '@/components': './src/components',
            '@/screens': './src/screens',
            '@/stores': './src/stores',
            '@/services': './src/services',
            '@/utils': './src/utils',
            '@/types': './src/types',
            '@/constants': './src/constants',
          },
        },
      ],
    ],
  };
};