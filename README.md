# GitAI

GitAI is a small terminal-first assistant for generating Conventional Commit messages from staged Git changes, reviewing the result, committing it, and optionally pushing it to one or more remotes.

It stays close to normal Git instead of replacing your workflow. The UI uses [Gum](https://github.com/charmbracelet/gum) when available and falls back to plain terminal prompts when it is not.

## Features

- Generates Conventional Commit titles and descriptions from staged changes.
- Supports AvalAI, OpenRouter, Cloudflare Workers AI, and Google AI Studio (Gemini API).
- Supports provider fallback chains.
- Terminal UI for staging, reviewing, committing, and choosing a push target.
- Multi-remote aware: push to one remote or all configured remotes.
- Works well in Warp, iTerm2, Terminal.app, and other modern terminals without requiring terminal-specific APIs.
- Falls back to simple text prompts when Gum is unavailable or `GITAI_TUI=0`.
- Warns about changes outside the index and lets you keep the current staged set or stage everything.
- Trims very large diffs before sending them to an AI provider.
- User-wide and repository-specific configuration.

## Requirements

- `bash`
- `git`
- `curl`
- [`jq`](https://jqlang.github.io/jq/)
- [`gum`](https://github.com/charmbracelet/gum) for the richer terminal UI (optional outside Homebrew installs)

## Install with Homebrew

This repository contains a Homebrew formula. Until a dedicated `homebrew-tap` repository exists, add this repository as a custom tap and install the HEAD formula:

```bash
brew tap jaavid/gitai https://github.com/jaavid/gitai
brew install --HEAD jaavid/gitai/gitai
```

Upgrade later with:

```bash
brew update
brew upgrade --fetch-HEAD gitai
```

Homebrew installs `jq` and `gum` automatically.

### Manual install

```bash
git clone https://github.com/jaavid/gitai.git
cd gitai
install -m 755 gitai /usr/local/bin/gitai
```

## Configuration

GitAI reads configuration in this order, with later files overriding earlier values:

1. Legacy `.gitai` next to the executable, if present.
2. `~/.config/gitai/config` (or `$XDG_CONFIG_HOME/gitai/config`).
3. `.gitai` in the current repository root.

For API keys, prefer the user-wide config instead of committing credentials into a repository.

Create it with:

```bash
mkdir -p ~/.config/gitai
$EDITOR ~/.config/gitai/config
```

Example:

```bash
export GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"
export GITAI_GOOGLE_API_KEY="your-google-key"
export GITAI_OPENROUTER_API_KEY="your-openrouter-key"
export GITAI_CLOUDFLARE_API_KEY="your-cloudflare-key"
export GITAI_AVALAPIS_API_KEY="your-avalapis-key"
export GITAI_CLOUDFLARE_ACCOUNT_ID="your-cloudflare-account-id"
```

### Provider options

Set `GITAI_PROVIDER` to one provider or a comma-separated fallback chain:

- `avalapis` (default)
- `openrouter`
- `cloudflare`
- `google`

Examples:

```bash
export GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"
```

```bash
export GITAI_PROVIDER="openrouter"
```

Global optional variables:

- `GITAI_API_BASE`: override endpoint URL for advanced/custom setups.
- `GITAI_MAX_DIFF_LENGTH`: maximum staged diff characters sent to a provider (default: `12000`).
- `GITAI_MODEL`: shared model override.
- `GITAI_TUI=0`: disable Gum and use plain terminal prompts.

Per-provider API keys:

- `GITAI_AVALAPIS_API_KEY`
- `GITAI_OPENROUTER_API_KEY`
- `GITAI_CLOUDFLARE_API_KEY`
- `GITAI_GOOGLE_API_KEY`

Per-provider model overrides:

- `GITAI_AVALAPIS_MODEL`
- `GITAI_OPENROUTER_MODEL`
- `GITAI_CLOUDFLARE_MODEL`
- `GITAI_GOOGLE_MODEL`

Cloudflare additionally needs `GITAI_CLOUDFLARE_ACCOUNT_ID` unless `GITAI_API_BASE` is explicitly set.

## Usage

From any Git repository:

```bash
gitai
```

A typical flow is:

1. GitAI shows the repository, branch, and short status.
2. If needed, choose whether to stage all changes or keep only the current staged set.
3. GitAI sends only the staged diff to the configured AI provider chain.
4. Review the generated Conventional Commit message.
5. Confirm the commit.
6. Choose whether and where to push.

If the repository has multiple remotes, GitAI presents all of them together with an **All remotes** option. The current branch is pushed explicitly to each selected remote.

### Push options

```bash
# Commit, then ask where to push
gitai --push

# Commit and push to every configured remote
gitai --push-all

# Commit without offering to push
gitai --no-push
```

### Disable the richer TUI

```bash
gitai --no-tui
```

or:

```bash
export GITAI_TUI=0
```

## Warp compatibility

GitAI deliberately uses normal shell input/output rather than a full-screen alternate-buffer UI. In Warp this means each run remains a normal command block, output stays searchable/copyable, and Git/GitAI subprocess output remains visible in the same block.

No Warp-specific configuration is required.

## CLI reference

```text
gitai [options]

--push       Push after committing; asks for a remote when necessary
--push-all   Push to every configured remote
--no-push    Never ask to push
--no-tui     Use plain prompts instead of Gum
-v, --version
-h, --help
```

## Contributing

Issues and pull requests are welcome.

## License

MIT — see [LICENSE](LICENSE).
