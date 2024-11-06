export default {
    extends: ['@commitlint/config-conventional'],
      /*
     * Resolve and load conventional-changelog-atom from node_modules.
     * Referenced packages must be installed
     */
      parserPreset: 'conventional-changelog-atom',
      /*
       * Resolve and load @commitlint/format from node_modules.
       * Referenced package must be installed
       */
      formatter: '@commitlint/format',
      /*
       * Any rules defined here will override rules from @commitlint/config-conventional
       */
      rules: {
        'type-enum': [2, 'always', ['foo']],
      },
  };
