# GitAI

**GitAI** is a small Bash script that generates commit messages using an AI model. The script inspects your staged changes and asks the configured API to suggest a commit title and description following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) style.

## Features

- Works with your existing Git workflow.
- Supports multiple providers: AvalAI, OpenRouter, Cloudflare Workers AI, and Google AI Studio (Gemini API).
- Warns about unstaged changes before committing.
- Trims very large diffs to avoid sending excessively long requests.
- Interactive prompts let you review and accept the generated message.

## Requirements

- `bash`
- [`curl`](https://curl.se/) for making HTTP requests
- [`jq`](https://stedolan.github.io/jq/) for parsing JSON

## Installation

Clone this repository and place the `gitai` script somewhere in your `PATH` or run it directly from the repository root:

```bash
# Clone the repository
git clone <repository url>
cd gitai

# Optional: copy the script somewhere in your PATH
cp gitai /usr/local/bin/
```

## Configuration

GitAI needs API credentials. You can either use a shared key (`GITAI_API_KEY`) or provider-specific keys, and you can set them as environment variables or in a `.gitai` file next to the script.

Example `.gitai` file:

```bash
export GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"
export GITAI_GOOGLE_API_KEY="your-google-key"
export GITAI_OPENROUTER_API_KEY="your-openrouter-key"
export GITAI_CLOUDFLARE_API_KEY="your-cloudflare-key"
export GITAI_AVALAPIS_API_KEY="your-avalapis-key"
export GITAI_CLOUDFLARE_ACCOUNT_ID="your-cloudflare-account-id"
```

### Provider options

Set `GITAI_PROVIDER` to one provider **or a comma-separated fallback chain**:

- `avalapis` (default)
- `openrouter`
- `cloudflare`
- `google`

Examples:

- `GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"`
- `GITAI_PROVIDER="openrouter"`

Additional provider-specific variables:

- `openrouter`
  - Optional: `GITAI_MODEL` (default `openai/gpt-4o-mini`)
- `cloudflare`
  - Required unless `GITAI_API_BASE` is set: `GITAI_CLOUDFLARE_ACCOUNT_ID`
  - Optional: `GITAI_MODEL` (default `@cf/meta/llama-3.3-70b-instruct-fp8-fast`)
- `google`
  - Optional: `GITAI_MODEL` (default `gemini-2.0-flash`)

Global optional variables:

- `GITAI_API_BASE`: Override endpoint URL (advanced use)
- `GITAI_MAX_DIFF_LENGTH`: Max diff chars sent to model (default `12000`)
- `GITAI_MODEL`: Shared default model override

Per-provider API keys (recommended for fallback chains):

- `GITAI_AVALAPIS_API_KEY`
- `GITAI_OPENROUTER_API_KEY`
- `GITAI_CLOUDFLARE_API_KEY`
- `GITAI_GOOGLE_API_KEY`

Per-provider model overrides (optional):

- `GITAI_AVALAPIS_MODEL`
- `GITAI_OPENROUTER_MODEL`
- `GITAI_CLOUDFLARE_MODEL`
- `GITAI_GOOGLE_MODEL`

## Usage

Stage your changes and run the script:

```bash
git add file.txt
./gitai
```

GitAI will print git status, send your diff to the configured provider, and show the suggested commit message. You can then choose whether to commit and optionally push.

A complete example is available in [`examples/basic_usage.sh`](examples/basic_usage.sh).

## Contributing

Contributions are welcome! Please open issues or pull requests on GitHub.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
