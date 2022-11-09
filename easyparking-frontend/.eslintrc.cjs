module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:@typescript-eslint/recommended-requiring-type-checking'
  ],
  plugins: ['@typescript-eslint', 'svelte3'],
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: 'module',
    tsconfigRootDir: __dirname,
    project: ['./tsconfig.json'],
    extraFileExtensions: ['.svelte']
  },
  env: {
    es6: true,
    browser: true
  },
  overrides: [
    {
      files: ['*.svelte'],
      processor: 'svelte3/svelte3'
    }
  ],
  settings: {
    'svelte3/typescript': require('typescript'),
    // ignore style tags in Svelte because of Tailwind CSS
    // See https://github.com/sveltejs/eslint-plugin-svelte3/issues/70
    'svelte3/ignore-styles': () => true
  },
  rules: {
    '@typescript-eslint/semi': [2, 'always'],
    'no-case-declarations': 'off',
    'no-var': 'error',
    'linebreak-style': 'off',
    camelcase: 'error',
    eqeqeq: 'error',
    'no-console': 'off',
    'prefer-arrow-callback': 'error',
    '@typescript-eslint/no-explicit-any': 'warn',
    'no-magic-numbers': ['error', { ignore: [0, 1, 2, -1] }],
    curly: 'error',
    'max-classes-per-file': ['error', 1],
  }
};
