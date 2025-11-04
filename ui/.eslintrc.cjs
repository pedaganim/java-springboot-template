module.exports = {
  root: true,
  env: { browser: true, es2022: true, node: true },
  parser: '@typescript-eslint/parser',
  parserOptions: { ecmaVersion: 'latest', sourceType: 'module' },
  plugins: ['@typescript-eslint', 'react', 'react-hooks', 'import'],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:react/jsx-runtime'
  ],
  rules: {
    'react/react-in-jsx-scope': 'off'
  },
  settings: { react: { version: 'detect' } },
  ignorePatterns: ['dist', 'node_modules'],
  overrides: [
    {
      files: ['**/*.test.ts', '**/*.test.tsx'],
      env: { jest: true }
    }
  ]
};
