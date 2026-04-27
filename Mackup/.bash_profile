# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(/opt/homebrew/bin/brew shellenv)"

# echo "Welcome, $(whoami)! Today is $(date '+%A, B %d, %Y'). 🌞 Make it amazing! 💪"

# --- Dynamic Time-Color Greeting Start ---
# Define unique colors to prevent clashing with PS1
GREET_CYAN='\033[0;36m'
GREET_YELLOW='\033[1;33m'
GREET_GREEN='\033[0;32m'
GREET_PURPLE='\033[0;35m'
GREET_NC='\033[0m' # No Color

# Determine time of day and color theme
HOUR=$(date +"%H")
if [ "$HOUR" -lt 12 ]; then
    GREET="Good morning"
    EMOJI="🌅"
    BORDER=$GREET_YELLOW
    ACCENT=$GREET_CYAN
elif [ "$HOUR" -lt 18 ]; then
    GREET="Good afternoon"
    EMOJI="☕"
    BORDER=$GREET_CYAN
    ACCENT=$GREET_YELLOW
else
    GREET="Good evening"
    EMOJI="🌙"
    BORDER=$GREET_PURPLE
    ACCENT=$GREET_CYAN
fi

# Get simple uptime (Mac friendly)
UPTIME_MAC=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')

# Print greeting with the rounded open-box aesthetic
echo -e "${BORDER}╭────────────────────────────────────────────────────────╮${GREET_NC}"
echo -e "${BORDER}│${GREET_NC} ${ACCENT}${GREET}, $(whoami)!${GREET_NC} ${EMOJI}"
echo -e "${BORDER}│${GREET_NC}"
echo -e "${BORDER}│${GREET_NC} 📅 ${GREET_GREEN}Date:${GREET_NC}   $(date '+%A, %B %d, %Y')"
echo -e "${BORDER}│${GREET_NC} 🕒 ${GREET_GREEN}Time:${GREET_NC}   $(date '+%I:%M %p')"
echo -e "${BORDER}│${GREET_NC} 💻 ${GREET_GREEN}Uptime:${GREET_NC} ${UPTIME_MAC}"
echo -e "${BORDER}╰────────────────────────────────────────────────────────╯${GREET_NC}"
# --- Dynamic Time-Color Greeting End ---