#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///
"""
Pre-tool use hook for Claude Code to guide worktrunk (wt) usage
instead of raw git worktree commands.

Uses exit code 2 + stderr to block commands (current Claude Code API).
Exit 0 allows the command to proceed.
"""

import json
import re
import sys
from typing import Dict, Any


# Subcommands that have wt equivalents (block and suggest)
MAPPED_SUBCOMMANDS = {"add", "list", "remove", "prune"}
# Subcommands with no wt equivalent (allow with note)
UNMAPPED_SUBCOMMANDS = {"move", "lock", "unlock"}


def parse_worktree_add(args: str) -> str:
    """Parse 'git worktree add' arguments and return a wt suggestion."""
    tokens = args.split()
    # git worktree add -b <branch> <path> [<base>]
    # git worktree add -B <branch> <path> [<base>]
    if tokens and tokens[0] in ("-b", "-B"):
        if len(tokens) >= 2:
            branch = tokens[1]
            # Check for base commit (4th positional after -b branch path)
            if len(tokens) >= 4:
                base = tokens[3]
                return f"wt switch --create {branch} --base {base}"
            return f"wt switch --create {branch}"
    # git worktree add <path> <existing-branch>
    elif len(tokens) >= 2:
        existing_branch = tokens[1]
        return f"wt switch {existing_branch}"
    # git worktree add <path> (no branch specified)
    elif len(tokens) == 1:
        return "wt switch --create <branch>"
    return "wt switch <branch>"


def suggest_wt_command(subcommand: str, rest: str) -> str:
    """Return a wt suggestion string for a given git worktree subcommand."""
    if subcommand == "add":
        return parse_worktree_add(rest)
    elif subcommand == "list":
        return "wt list"
    elif subcommand == "remove":
        return "wt remove"
    elif subcommand == "prune":
        return "wt step prune"
    return ""


def analyze_command(command: str) -> Dict[str, Any]:
    """Analyze a shell command for git worktree usage."""
    # Allow commands that are already using wt
    if re.search(r"(^|\s|;|&&|\|)\s*wt\s", command) or command.strip().startswith("wt"):
        return {"action": "allow"}

    # Pattern to find 'git worktree <subcommand>' in command chains
    pattern = r"(?:^|[;&|]\s*|&&\s*)git\s+worktree\s+(\w+)(.*?)(?=[;&|]|$)"
    matches = list(re.finditer(pattern, command))

    if not matches:
        return {"action": "allow"}

    for match in matches:
        subcommand = match.group(1)
        rest = match.group(2).strip()

        if subcommand in MAPPED_SUBCOMMANDS:
            suggestion = suggest_wt_command(subcommand, rest)
            return {
                "action": "block",
                "reason": (
                    f"Use worktrunk instead of raw git worktree commands. "
                    f"Try: {suggestion}"
                ),
            }
        elif subcommand in UNMAPPED_SUBCOMMANDS:
            return {
                "action": "allow",
                "note": (
                    f"Note: 'git worktree {subcommand}' has no worktrunk equivalent. "
                    f"Proceeding with raw git command."
                ),
            }

    return {"action": "allow"}


def main():
    """Main hook function."""
    try:
        input_data = json.loads(sys.stdin.read())

        tool_name = input_data.get("tool_name", "")
        if tool_name not in ("Bash", "Run"):
            sys.exit(0)

        tool_input = input_data.get("tool_input", {})
        command = tool_input.get("command", "")

        if not command:
            sys.exit(0)

        result = analyze_command(command)

        if result["action"] == "block":
            print(result["reason"], file=sys.stderr)
            sys.exit(2)

        if "note" in result:
            print(result["note"], file=sys.stderr)

        sys.exit(0)

    except Exception as e:
        # On error, allow to avoid blocking workflow
        print(f"Hook error (allowing): {e!s}", file=sys.stderr)
        sys.exit(0)


if __name__ == "__main__":
    main()
