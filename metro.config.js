const { getDefaultConfig } = require('expo/metro-config');

const config = getDefaultConfig(__dirname);

// Add support for TypeScript path mapping
config.resolver.alias = {
  '@': './src',
  '@/components': './src/components',
  '@/screens': './src/screens',
  '@/stores': './src/stores',
  '@/services': './src/services',
  '@/utils': './src/utils',
  '@/types': './src/types',
  '@/constants': './src/constants',
};

module.exports = config;