# GitAI

**GitAI** is a small Bash script that generates commit messages using an AI model. The script inspects your staged changes and asks the configured API to suggest a commit title and description following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) style.

## Features

- Works with your existing Git workflow.
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

GitAI expects an API key for the backend that generates the commit messages. You can provide it in two ways:

1. Set the environment variable `GITAI_API_KEY`.
2. Create a file named `.gitai` next to the script that exports the variable. For example:

```bash
# .gitai
export GITAI_API_KEY="your-api-key"
```

The script also allows overriding the API endpoint and model by modifying the variables at the top of the script.

## Usage

Stage your changes and run the script:

```bash
git add file.txt
./gitai
```

GitAI will print the git status, send your diff to the API and show the suggested commit message. You can then choose whether to commit and optionally push.

A complete example is available in [`examples/basic_usage.sh`](examples/basic_usage.sh).

## Contributing

Contributions are welcome! Please open issues or pull requests on GitHub.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
