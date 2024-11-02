# github-create-next-semantic-release-action

## What is it?

This is a GitHub Action that provides the [github-create-next-semantic-release](https://github.com/fabien-marty/github-next-semantic-version) tool/feature inside a GHA Workflow. This tool guesses **the next [semantic version](https://semver.org/)** from:

- existing **git tags** *(read from a locally cloned git repository)*
- and recently merged **pull-requests labels** *(read from the GitHub API)*

Unlinke plenty of "similar" tools, we don't use any "commit message parsing" here but only **configurable PR labels**.

Then, **it automatically creates a GitHub release** with guessed version and corresponding release notes.

> [!NOTE]
> You can configure the default [golang text/template](https://pkg.go.dev/text/template) for release notes.
>
> The default value is: `{{ range . }}- {{.Title}} (#{{.Number}})\n{{ end }}`

## Usage

```yaml
- uses: actions/checkout@v4
  with:
    fetch-tags: true # we need to fetch tags to determine the latest version
    fetch-depth: 0 # fetch-tags is not enough because of a GHA bug: https://github.com/actions/checkout/issues/1471

- id: create-release
  uses: fabien-marty/github-create-next-semantic-release-action@v1
  with:
    github-token: ${{ github.token }} # Let's use the default value of the current workflow
    repository: ${{ github.repository }} # Let's use the default value of the current workflow
    repository-owner: ${{ github.repository_owner }} # Let's use the default value of the current workflow
```

> [!NOTE]
> In some configurations, you will also need to add this at the job level:
> 
> ```yaml
> permissions:
>   pull-requests: read
>   contents: write
> ```

### Inputs

- `log-level`: Log Level (`DEBUG`, `INFO` or `WARNING`), default to `INFO`
- `github-token`: GitHub Token (in most cases, you can use `${{ github.token }}` as value)
- `repository`: Full repository name (example: `octocat/Hello-World`, in most cases, you want to use `${{ github.repository }}` as value)
- `repository-owner`: repository owner (example: `octocat`), in most cases, you want to use `${{ github.repository-owner }}` as value)
- `major-labels`: coma separated list of PR labels to search for determining a major release (default to: `major,breaking,Type: Major`)
- `minor-labels`: coma separated list of PR labels to search for determining a minor release (default to: `minor,Type: Minor, Type: Feature`)
- `ignore-labels`: coma separated list of PR labels to search for ignoring a PR (default to: `Type: Hidden`), can be useful with `dont-increment-if-no-pr` option
- `consider-also-non-merged-prs`: If set to `true` (default to `false`), consider also "non merged" PRs to compute the next version
- `tag-regex`: If set, filter tags with the given regex
- `release-force`: If set, force the version bump and the creation of a release (even if there is no PR)
- `release-draft`: If set, the release is created in draft mode
- `release-body-template-path`: If set, golang template path to generate the release body (if set, release-body-template option is ignored)
- `release-body-template`: Golang template to generate the release body (default to `{{ range . }}- {{.Title}} (#{{.Number}})\n{{ end }}`)

### Outputs

- `new-tag`: the new version/tag (empty if no release was created)
