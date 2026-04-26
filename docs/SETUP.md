# Setup Guide

This document explains how to configure GitAI for your environment.

## 1. Install Dependencies

Ensure that the following tools are available on your system:

- `bash`
- `curl`
- `jq`
- `git`

On Debian/Ubuntu you can install them with:

```bash
sudo apt-get install bash curl jq git
```

## 2. Choose a Provider and Obtain an API Key

GitAI supports these providers:

- `avalapis` (default)
- `openrouter`
- `cloudflare`
- `google` (Google AI Studio / Gemini API)

Get an API key from the provider you want to use.

## 3. Provide Configuration

The script reads settings from environment variables or from a `.gitai` file next to the script.

Common variables:

- `GITAI_PROVIDER` (single provider or comma-separated fallback chain)
- `GITAI_API_KEY` (shared fallback key)
- `GITAI_MODEL` (optional shared model)
- `GITAI_MAX_DIFF_LENGTH` (optional, default `12000`)
- `GITAI_API_BASE` (optional endpoint override)


Provider-specific API keys (recommended when using fallback):

- `GITAI_AVALAPIS_API_KEY`
- `GITAI_OPENROUTER_API_KEY`
- `GITAI_CLOUDFLARE_API_KEY`
- `GITAI_GOOGLE_API_KEY`

Provider-specific model overrides (optional):

- `GITAI_AVALAPIS_MODEL`
- `GITAI_OPENROUTER_MODEL`
- `GITAI_CLOUDFLARE_MODEL`
- `GITAI_GOOGLE_MODEL`

Example `.gitai` file for OpenRouter:

```bash
export GITAI_PROVIDER="openrouter"
export GITAI_API_KEY="your-openrouter-key"
export GITAI_MODEL="openai/gpt-4o-mini"
```

Example `.gitai` file for Cloudflare Workers AI:

```bash
export GITAI_PROVIDER="cloudflare"
export GITAI_API_KEY="your-cloudflare-api-token"
export GITAI_CLOUDFLARE_ACCOUNT_ID="your-account-id"
export GITAI_MODEL="@cf/meta/llama-3.3-70b-instruct-fp8-fast"
```

Example `.gitai` file for Google AI Studio:

```bash
export GITAI_PROVIDER="google"
export GITAI_API_KEY="your-google-ai-studio-key"
export GITAI_MODEL="gemini-2.0-flash"
```

Example `.gitai` file for multi-provider fallback:

```bash
export GITAI_PROVIDER="google,openrouter,cloudflare,avalapis"
export GITAI_GOOGLE_API_KEY="your-google-ai-studio-key"
export GITAI_OPENROUTER_API_KEY="your-openrouter-key"
export GITAI_CLOUDFLARE_API_KEY="your-cloudflare-api-token"
export GITAI_AVALAPIS_API_KEY="your-avalapis-key"
export GITAI_CLOUDFLARE_ACCOUNT_ID="your-account-id"
```

GitAI will try providers in order and automatically move to the next one if a provider fails.

## 4. Run the Example

A short example script is provided in `examples/basic_usage.sh`. Execute it from the repository root to see GitAI in action.
