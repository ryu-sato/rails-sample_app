#!/usr/bin/env ruby
#
# Usage:
#   $ .github/scripts/merge-dependabot-pull-request.rb <dependency-name>
#
require "yaml"

# The dependency name to be updated is given as an argument. e.g.) rubocop
target_dependency_name = ARGV.first

config = open('./.github/auto-merge-list.yml', 'r') { |f| YAML.load(f) }

if config["dependency-names"].include?(target_dependency_name)
  # branch protection rules で以下の設定されていた場合に、merge ができるようになるまで考慮する事項があることをラベリングする
  # * Require a pull request before merging / Require approvals が設定されている場合
  #   -> 承認が必要なので "approved by bot" ラベルを付与する
  # * Require status checks to pass before merging / Require branches to be up to date before merging が設定されている場合
  #   -> Source branch を最新の状態で維持する必要があるので "keep branch up-to-date" ラベルを付与する
  #
  # 処理としては PR にラベルをつけているだけであるが、ラベルが付けられたことをトリガして、
  # 別途 PR を承認する GitHub Actions の Job が実行される。
  # ラベルは事前に作成しておく必要がある。
  system('gh pr edit --add-label "approved by bot,keep branch up-to-date" "$PR_URL"', exception: true)

  # Automatically merge PR when CI passes.
  system('gh pr merge --auto --merge "$PR_URL"', exception: true)
end
