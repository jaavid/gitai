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

## 2. Obtain an API Key

GitAI requires an API key to contact the backend that generates commit messages. Sign up for a key from the service you intend to use.

## 3. Provide Your API Key

The script looks for the key in the environment variable `GITAI_API_KEY`. You can export it in your shell or create a `.gitai` file in the same directory as the script.

Example `.gitai` file:

```bash
export GITAI_API_KEY="your-api-key"
```

## 4. Optional Configuration

Edit the `gitai` script if you need to change the API endpoint or model name. The relevant variables are at the top of the script.

## 5. Run the Example

A short example script is provided in `examples/basic_usage.sh`. Execute it from the repository root to see GitAI in action.
