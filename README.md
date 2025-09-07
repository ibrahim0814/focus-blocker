# Focus Blocker 🚫

A simple terminal-based website blocker for macOS that helps you stay focused by blocking distracting websites.

## Features

- ✅ **Simple Commands**: Just run `focus` to block sites and `unfocus` to unblock them
- ✅ **Customizable Block List**: Easily add/remove sites from your block list
- ✅ **Works System-Wide**: Blocks websites in all browsers and applications
- ✅ **No Background Processes**: Uses the system's hosts file, no daemon required
- ✅ **Terminal Interface**: Perfect for developers who live in the terminal
- ✅ **Visual Status**: See which sites are blocked and your current focus status

## How It Works

Focus Blocker works by modifying your system's `/etc/hosts` file to redirect blocked websites to `127.0.0.1` (localhost). This means when you try to visit a blocked site, it won't be able to connect, effectively blocking access.

## Installation

1. **Clone or download** this repository:
   ```bash
   git clone <repository-url>
   cd focus-blocker
   ```

2. **Run the installation script**:
   ```bash
   ./install.sh
   ```
   
   This will:
   - Make the scripts executable
   - Install `focus` and `unfocus` commands globally
   - Set up the configuration file

3. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc  # or ~/.bashrc depending on your shell
   ```

## Usage

### Basic Commands

- **Block websites (enter focus mode)**:
  ```bash
  focus
  ```

- **Unblock websites (exit focus mode)**:
  ```bash
  unfocus
  ```

- **Check status and see blocked sites**:
  ```bash
  focus list
  ```

### Managing Your Block List

- **Add a site to block list**:
  ```bash
  focus add reddit.com
  focus add youtube.com
  focus add x.com
  ```

- **Remove a site from block list**:
  ```bash
  focus remove youtube.com
  ```

- **Get help**:
  ```bash
  focus help
  ```

### Manual Configuration

You can also manually edit the configuration file:
```bash
nano ~/repos/focus-blocker/blocked_sites.txt
```

Just add one domain per line (without `http://` or `https://`).

## Default Blocked Sites

The default configuration includes common distracting websites:

- **Social Media**: x.com, twitter.com, facebook.com, instagram.com, linkedin.com
- **Entertainment**: youtube.com, tiktok.com, twitch.tv
- **Discussion**: reddit.com, news.ycombinator.com
- **Other**: 9gag.com, imgur.com, pinterest.com

## Examples

```bash
# Start focusing (blocks all configured sites)
$ focus
✓ Focus mode activated! Blocked 15 websites.
Run 'unfocus' to disable.

# Check what's being blocked
$ focus list
Currently configured blocked sites:
  🚫 x.com (blocked)
  🚫 reddit.com (blocked)
  🚫 youtube.com (blocked)
  ...

Focus mode is currently: ACTIVE

# Add a new site to block
$ focus add pinterest.com
✓ Added 'pinterest.com' to block list
Reactivating focus mode with new site...
✓ Focus mode activated! Blocked 16 websites.

# Stop focusing (unblocks all sites)
$ unfocus
✓ Focus mode deactivated! All sites unblocked.
```

## Security & Permissions

- The script requires `sudo` permissions to modify `/etc/hosts`
- A backup of your original hosts file is created automatically
- Only the Focus Blocker entries are modified; your existing hosts file content is preserved

## Customization

### Adding New Sites

You can add sites in several ways:

1. **Command line**: `focus add example.com`
2. **Edit config file**: Add domains to `blocked_sites.txt`
3. **Bulk import**: Copy a list of domains into the config file

### Configuration File Location

- Config file: `~/repos/focus-blocker/blocked_sites.txt`
- Backup of original hosts: `~/repos/focus-blocker/hosts_backup`

## Troubleshooting

### Commands Not Found
If `focus` or `unfocus` commands aren't found after installation:
1. Restart your terminal
2. Check if `/usr/local/bin` is in your PATH
3. Run the installation script again

### Permission Issues
If you get permission errors:
- Make sure you're not running as root
- The script will ask for `sudo` when needed
- Check that `/etc/hosts` is writable by root

### Sites Still Accessible
If blocked sites are still accessible:
1. Check if focus mode is active: `focus list`
2. Try flushing DNS cache manually: `sudo dscacheutil -flushcache`
3. Restart your browser
4. Check if the site uses a different domain (like redirects)

### Restoring Original Hosts File
If something goes wrong, you can restore your original hosts file:
```bash
sudo cp ~/repos/focus-blocker/hosts_backup /etc/hosts
sudo dscacheutil -flushcache
```

## Uninstallation

To remove Focus Blocker:

1. **Deactivate focus mode** (if active):
   ```bash
   unfocus
   ```

2. **Remove global commands**:
   ```bash
   sudo rm /usr/local/bin/focus /usr/local/bin/unfocus
   ```

3. **Remove the project directory**:
   ```bash
   rm -rf ~/repos/focus-blocker
   ```

## Contributing

Feel free to:
- Report bugs and issues
- Suggest new features
- Submit pull requests
- Share your custom blocked sites lists

## License

This project is open source and available under the MIT License.

## Why Focus Blocker?

Unlike browser extensions that can be easily disabled or bypassed:
- ✅ Works across **all browsers** and applications
- ✅ **Harder to bypass** - requires conscious effort to disable
- ✅ **No browser dependencies** - works even if you switch browsers
- ✅ **Lightweight** - no background processes or memory usage
- ✅ **Privacy-focused** - all blocking happens locally

---

**Stay focused and productive! 🎯**
