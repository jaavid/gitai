# GitAI

GitAI is a terminal-first assistant for generating Conventional Commit messages from staged Git changes, reviewing the result, committing it, and optionally pushing it to one or more remotes.

## Features

- Conventional Commit title + description generated from staged changes.
- Providers: AvalAI, OpenRouter, Cloudflare Workers AI, and Google AI Studio (Gemini).
- First-run credential setup when no usable API key is found.
- `gum`-based terminal UI with plain-shell fallback.
- Multi-remote push selection, including **All remotes**.
- Works cleanly in Warp without using a full-screen alternate buffer.
- Config discovery for old and new installations.
- Versioned Homebrew formula, while keeping `--HEAD` available for development builds.

## Homebrew

Add the tap once:

```bash
brew tap jaavid/gitai https://github.com/jaavid/gitai
```

Install the stable version:

```bash
brew install jaavid/gitai/gitai
```

Normal upgrades then work with:

```bash
brew update
brew upgrade gitai
```

### If you previously installed with `--HEAD`

Older GitAI instructions used:

```bash
brew install --HEAD jaavid/gitai/gitai
```

That produces versions such as `HEAD-e7f82ea`, so Homebrew tracks Git commits rather than semantic releases. Switch once to the stable channel after this release is merged:

```bash
brew reinstall jaavid/gitai/gitai
```

Then verify:

```bash
gitai --version
```

Expected for this release:

```text
gitai 0.3.0
```

If you intentionally want the newest `main` commit instead of a release, use:

```bash
brew reinstall --HEAD jaavid/gitai/gitai
brew upgrade --fetch-HEAD gitai
```

Homebrew installs `jq` and `gum` automatically.

## Configuration and API keys

GitAI reads config in this order; later files override earlier values:

1. `.gitai` next to the executable.
2. `~/.bin/gitai/.gitai` — historical GitAI location.
3. `~/.config/gitai/config` or `$XDG_CONFIG_HOME/gitai/config`.
4. `<repo>/.gitai`.

So an existing file such as:

```text
/Users/javid/.bin/gitai/.gitai
```

continues to work without migration.

If no usable key exists for the configured provider(s), GitAI starts an interactive setup wizard. It asks for the provider and API key, masks the key while typing, and stores it in:

```text
~/.config/gitai/config
```

with mode `600`.

Run setup manually at any time:

```bash
gitai --setup
```

Example config:

```bash
export GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"
export GITAI_GOOGLE_API_KEY="your-google-key"
export GITAI_OPENROUTER_API_KEY="your-openrouter-key"
export GITAI_CLOUDFLARE_API_KEY="your-cloudflare-key"
export GITAI_AVALAPIS_API_KEY="your-avalapis-key"
export GITAI_CLOUDFLARE_ACCOUNT_ID="your-cloudflare-account-id"
```

Supported providers:

- `google`
- `openrouter`
- `cloudflare`
- `avalapis`

A comma-separated value in `GITAI_PROVIDER` acts as a fallback chain.

## Usage

From any Git repository:

```bash
gitai
```

Typical flow:

1. Load credentials or run setup.
2. Show branch and Git status.
3. Stage changes if needed.
4. Generate a commit message from the staged diff.
5. Review and confirm the commit.
6. Select a remote, all remotes, or skip pushing.

Useful options:

```text
--setup      Configure provider and API key
--push       Push after committing; choose remote if needed
--push-all   Push to every configured remote
--no-push    Never ask to push
--no-tui     Use plain prompts instead of Gum
-v, --version
-h, --help
```

## Warp

GitAI uses normal terminal input/output rather than a curses-style full-screen interface. In Warp, each run remains a regular command block, and Git/GitAI output stays searchable and copyable.

## Manual install

```bash
git clone https://github.com/jaavid/gitai.git
cd gitai
install -m 755 gitai /usr/local/bin/gitai
```

## License

MIT — see [LICENSE](LICENSE).
