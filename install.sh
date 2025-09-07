#!/bin/bash

# Focus Blocker Installation Script
# This script sets up the focus and unfocus commands globally

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="/usr/local/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Focus Blocker Installation${NC}"
echo "=========================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please don't run this script as root${NC}"
    echo "The script will ask for sudo permission when needed."
    exit 1
fi

# Check if /usr/local/bin exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Creating $INSTALL_DIR directory...${NC}"
    sudo mkdir -p "$INSTALL_DIR"
fi

# Make scripts executable
echo -e "${BLUE}Making scripts executable...${NC}"
chmod +x "$SCRIPT_DIR/focus"
chmod +x "$SCRIPT_DIR/unfocus"

# Set up configuration file if it doesn't exist
if [ ! -f "$SCRIPT_DIR/blocked_sites.txt" ]; then
    echo -e "${BLUE}Creating default blocked sites configuration...${NC}"
    cp "$SCRIPT_DIR/blocked_sites_default.txt" "$SCRIPT_DIR/blocked_sites.txt"
    echo -e "${GREEN}✓ Created blocked_sites.txt with default sites${NC}"
else
    echo -e "${YELLOW}✓ Using existing blocked_sites.txt configuration${NC}"
fi

# Create wrapper scripts in /usr/local/bin
echo -e "${BLUE}Installing focus command...${NC}"
sudo tee "$INSTALL_DIR/focus" > /dev/null << EOF
#!/bin/bash
exec "$SCRIPT_DIR/focus" "\$@"
EOF

echo -e "${BLUE}Installing unfocus command...${NC}"
sudo tee "$INSTALL_DIR/unfocus" > /dev/null << EOF
#!/bin/bash
exec "$SCRIPT_DIR/unfocus" "\$@"
EOF

# Make wrapper scripts executable
sudo chmod +x "$INSTALL_DIR/focus"
sudo chmod +x "$INSTALL_DIR/unfocus"

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "You can now use the following commands from anywhere:"
echo -e "  ${YELLOW}focus${NC}        - Block distracting websites"
echo -e "  ${YELLOW}unfocus${NC}      - Unblock websites"
echo -e "  ${YELLOW}focus list${NC}   - Show blocked sites and status"
echo -e "  ${YELLOW}focus add <site>${NC} - Add a site to block list"
echo -e "  ${YELLOW}focus remove <site>${NC} - Remove a site from block list"
echo -e "  ${YELLOW}focus help${NC}   - Show help"
echo ""
echo -e "${BLUE}Configuration file:${NC} $SCRIPT_DIR/blocked_sites.txt"
echo -e "${BLUE}Edit this file to customize your blocked sites.${NC}"
echo ""
echo -e "${YELLOW}Note: The commands require sudo permission to modify /etc/hosts${NC}"
echo ""

# Test if commands are in PATH
if command -v focus &> /dev/null; then
    echo -e "${GREEN}✓ 'focus' command is ready to use${NC}"
else
    echo -e "${RED}⚠ Warning: 'focus' command not found in PATH${NC}"
    echo "You may need to restart your terminal or add /usr/local/bin to your PATH"
fi

if command -v unfocus &> /dev/null; then
    echo -e "${GREEN}✓ 'unfocus' command is ready to use${NC}"
else
    echo -e "${RED}⚠ Warning: 'unfocus' command not found in PATH${NC}"
    echo "You may need to restart your terminal or add /usr/local/bin to your PATH"
fi

echo ""
echo -e "${BLUE}Try running: ${YELLOW}focus help${NC}"
