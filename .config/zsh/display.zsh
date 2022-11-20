
# Set DISPLAY if running in WSL (WSL2 need to use hosts IP)
# X server needds to be running on the host. mobaxterm has this.
if [[ -f /proc/version ]] && cat /proc/version | grep "microsoft" 2>&1 1>/dev/null ; then
  if command -v route.exe >/dev/null 2>&1; then
    export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
  fi
fi
