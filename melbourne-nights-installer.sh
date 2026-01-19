#!/bin/bash

# Melbourne Nights - Gnome Terminal Theme Installer
# Ported from GtkSourceView theme by Daniel Bizzarri

# -----------------------------------------------------------------------------
# Color Palette Definition (Mapped from XML)
# -----------------------------------------------------------------------------

# Base Colors
BG_COLOR="#0d1117"
FG_COLOR="#9f7ed7"             # foreground
CURSOR_COLOR="#c0caf5"         # white

# Palette (ANSI 0-15)
# Rows are: [Normal: Black, Red, Green, Yellow, Blue, Magenta, Cyan, White]
#           [Bright: Black, Red, Green, Yellow, Blue, Magenta, Cyan, White]

# 0: Black (Using 'selection' color for better visibility than pure black)
P0="#24283b"
# 1: Red (Fixed typo from #ff7768e -> #ff7768)
P1="#ff7768"
# 2: Green
P2="#90f425"
# 3: Yellow
P3="#e0af68"
# 4: Blue
P4="#0084ff"
# 5: Magenta (Purple)
P5="#5912c4"
# 6: Cyan (Dark Cyan)
P6="#229b92"
# 7: White (Bone White)
P7="#cfc9c2"

# 8: Bright Black (Comment/Weird Gray)
P8="#565f89"
# 9: Bright Red (Using Orange here to make it pop)
P9="#ff5e00"
# 10: Bright Green
P10="#90f425"
# 11: Bright Yellow
P11="#e0af68"
# 12: Bright Blue
P12="#0084ff"
# 13: Bright Magenta (Pink)
P13="#f12eff"
# 14: Bright Cyan (Cyan)
P14="#00ffd9"
# 15: Bright White (White)
P15="#c0caf5"

PALETTE="['$P0', '$P1', '$P2', '$P3', '$P4', '$P5', '$P6', '$P7', '$P8', '$P9', '$P10', '$P11', '$P12', '$P13', '$P14', '$P15']"

# -----------------------------------------------------------------------------
# Installation Logic
# -----------------------------------------------------------------------------

# Generate a new UUID for the profile
PROFILE_UUID=$(uuidgen)
DCONF_PATH="/org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID"

echo "Creating new Gnome Terminal profile: Melbourne Nights ($PROFILE_UUID)"

# Get the current list of profiles
PROFILE_LIST=$(dconf read /org/gnome/terminal/legacy/profiles:/list)

# If the list is empty, initialize it properly
if [ -z "$PROFILE_LIST" ]; then
    PROFILE_LIST="['$PROFILE_UUID']"
else
    # Remove the closing bracket, add the new UUID, and close it again
    PROFILE_LIST="${PROFILE_LIST%]*}, '$PROFILE_UUID']"
fi

# Write the updated profile list
dconf write /org/gnome/terminal/legacy/profiles:/list "$PROFILE_LIST"

# Write the profile settings
dconf write "$DCONF_PATH/visible-name" "'Melbourne Nights'"
dconf write "$DCONF_PATH/background-color" "'$BG_COLOR'"
dconf write "$DCONF_PATH/foreground-color" "'$FG_COLOR'"
dconf write "$DCONF_PATH/cursor-colors-set" "true"
dconf write "$DCONF_PATH/cursor-background-color" "'$CURSOR_COLOR'"
dconf write "$DCONF_PATH/cursor-foreground-color" "'$BG_COLOR'"
dconf write "$DCONF_PATH/use-theme-colors" "false"
dconf write "$DCONF_PATH/use-theme-transparency" "false"
dconf write "$DCONF_PATH/palette" "$PALETTE"

echo "---------------------------------------------------"
echo "Installation Complete!"
echo "To use the theme:"
echo "1. Open Gnome Terminal"
echo "2. Right-click anywhere inside the terminal -> Preferences"
echo "3. Select 'Melbourne Nights' from the Profiles sidebar"
echo "4. (Optional) Set it as Default in the text menu"
echo "---------------------------------------------------"
