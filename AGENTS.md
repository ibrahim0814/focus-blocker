# AGENTS.md

## Project Overview
Focus Blocker is a terminal-based website blocker for macOS that helps users stay focused by blocking distracting websites like x.com, twitter.com, reddit.com, youtube.com, etc. It works by modifying the system's `/etc/hosts` file to redirect blocked websites to localhost (127.0.0.1).

## Setup Commands
- Install globally: `./install.sh` (requires sudo for /usr/local/bin access)
- Test installation: `focus help`
- Quick test: `focus list` (shows blocked sites and current status)

## Usage Commands
- Block websites: `focus`
- Block websites + launch Spotify playlist: `focus -s` or `focus -s <playlist_name>`
- Unblock websites: `unfocus`  
- Show status: `focus list`
- Add site to blocklist: `focus add <domain>`
- Remove site from blocklist: `focus remove <domain>`
- List Spotify playlists: `focus playlists`
- Add Spotify playlist: `focus playlist add <name> <url>`
- Remove Spotify playlist: `focus playlist remove <name>`
- Show help: `focus help`

## Code Style & Architecture
- **Language**: Bash shell scripts
- **Style**: Use double quotes for variables, single quotes for literal strings
- **Functions**: Prefix with descriptive names, use local variables where possible
- **Colors**: Use ANSI color codes defined as variables (RED, GREEN, BLUE, YELLOW, NC)
- **Error handling**: Check exit codes and provide meaningful error messages
- **File structure**:
  - `focus` - Main script with all core functionality
  - `unfocus` - Standalone script for deactivating blocking
  - `blocked_sites.txt` - Configuration file with domains to block
  - `install.sh` - Installation script for global setup

## System Integration
- **Hosts file location**: `/etc/hosts`
- **Backup location**: `$SCRIPT_DIR/hosts_backup`
- **Block markers**: `# FOCUS_BLOCKER_START` and `# FOCUS_BLOCKER_END`
- **Install location**: `/usr/local/bin/focus` and `/usr/local/bin/unfocus`
- **DNS cache flush**: Uses `dscacheutil -flushcache` and `killall -HUP mDNSResponder`

## Security Considerations
- **Requires sudo**: Scripts need root access to modify /etc/hosts
- **Backup safety**: Always creates backup before modifying hosts file
- **Reversible**: Can restore original hosts file if needed
- **Isolated changes**: Only modifies content between FOCUS_BLOCKER markers
- **No secrets**: No API keys, passwords, or sensitive data handled

## Testing Instructions
- Test basic functionality: Run `focus list` to check if commands are working
- Test blocking: Run `focus`, then try accessing a blocked site in browser
- Test unblocking: Run `unfocus`, then verify sites are accessible
- Test configuration: Add/remove sites with `focus add/remove` commands
- Test installation: Run `./install.sh` in a fresh environment

## Common Issues & Fixes
- **Permission denied**: Ensure scripts are executable with `chmod +x`
- **Command not found**: Check if `/usr/local/bin` is in PATH
- **Sites still accessible**: Clear browser cache and DNS with `sudo dscacheutil -flushcache`
- **Hosts file corruption**: Restore from backup: `sudo cp hosts_backup /etc/hosts`

## Configuration Files
- **blocked_sites.txt**: One domain per line, no http/https prefixes
- **spotify_config.txt**: Contains Spotify playlist URIs for focus mode with pre-configured productivity playlists
- **Format**: Plain text, comments start with #
- **Default sites**: Includes x.com, twitter.com, reddit.com, youtube.com, facebook.com, instagram.com, tiktok.com, etc.
- **Default playlists**: Includes deep, study, coding, jazz, piano, lofi, nature, and noise playlists for different productivity needs
- **Spotify Integration**: Uses AppleScript to control Spotify playback and URI scheme to open playlists. Automatically starts playback and shows playlist name instead of song name. Supports custom playlists via `focus playlist add` command.

## Terminal Output Design
- **Concise messaging**: Terminal output is designed to be informative but not verbose
- **Browser tab feedback**: Shows tab save/restore summaries without excessive detail
- **Spotify integration**: Shows playlist name being played, not song names
- **Progress indicators**: Uses checkmarks (✓) and warning symbols (⚠️) for clear status
- **Color coding**: Green for success, Yellow for warnings, Blue for info, Red for errors
- **Clean output**: Avoids unnecessary intermediate status messages

## Development Tips
- Always test with `focus list` before and after changes
- Use the existing color scheme for consistency
- Preserve the backup/restore functionality
- Test both active and inactive states for all commands
- Ensure proper cleanup of temporary files
- Keep the config file format simple and readable
- Maintain concise terminal output - users should see what's important without clutter

## Deployment
- No build process required (pure shell scripts)
- Installation copies scripts to `/usr/local/bin` with wrapper scripts
- Configuration remains in the original directory
- Uses absolute paths in wrapper scripts for portability

## Git Workflow  
- Commit message format: "action: description" (e.g., "Fix: unfocus logic messaging")
- Always test commands after changes before committing
- Include relevant test outputs in commit messages when fixing bugs
- Use descriptive branch names for features

## macOS Specific Notes
- Uses BSD sed (different from GNU sed)
- DNS cache flush requires both `dscacheutil` and `mDNSResponder` restart
- Hosts file location is standard Unix `/etc/hosts`
- Installation uses `/usr/local/bin` which is standard in macOS PATH
